%{
    #include "common.h"
    #define YYSTYPE TreeNode *  //此处定义了$$的类型
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
    extern int layernum;
    vector<layer*> layers(1,new layer()); //layer array
%}
%token IF ELSE WHILE FOR PRINTF SCANF TRUE FALSE
%token T_CHAR T_INT T_STRING T_BOOL 
%token IDENTIFIER INTEGER CHAR BOOL STRING

%token SEMICOLON LBRACE RBRACE LPAREN RPAREN
%token LOP_ASSIGN 
%token ADD MINUS MUL DIV MOD SELFADD SELFMIN NEG

%left LOP_EQ //==
%left ADD MINUS 
%left MUL DIV
%right NOT
%nonassoc LOWER_THEN_ELSE
%nonassoc ELSE

%%

program
:   statements {root = new TreeNode(0, NODE_PROG); root->addChild($1);};

statements
:   statement {$$=$1;}
|   statements statement {$$=$1;$$->addSibling($2);}
;

statement
:   SEMICOLON  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}//分号-STMT_SKIP
|   declaration SEMICOLON {$$ = $1;}
|   assign SEMICOLON {$$ = $1;}
|   LBRACE statements RBRACE {$$ = $2;}
|   expr {$$ = $1;}
|   if_else {$$ = $1;}
|   while {$$ = $1;}
|   scanf {$$ = $1;}
|   printf {$$ = $1;}
|   for {$$ = $1;}
;

declaration
: T IDENTIFIER LOP_ASSIGN expr{// declare and init
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($2);
        node->addChild($4);
        layer* curlayer = layers[layernum];
        if(curlayer->vars.size()==0){
                cout<<"this name : "<<$2->var_name<<endl;
        curlayer->vars.push_back(new variable());
        curlayer->vars[0]->var_name = $2->var_name;
        curlayer->vars[0]->type = $1->type;
        // cout<< $1->type->type <<endl; $1->type->type = 1 (VALUE_INT)
        if($1->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curlayer->vars[0]->int_val = $4->int_val;
                //cout<< curlayer->vars[0]->int_val<<endl;
                }
        else if($1->type->type == VALUE_CHAR){
                curlayer->vars[0]->ch_val = $4->ch_val;
                }
        else if($1->type->type == VALUE_STRING){
                curlayer->vars[0]->str_val = $4->str_val;
                }
        else if($1->type->type == VALUE_BOOL){
                curlayer->vars[0]->b_val = $4->b_val;
                }      
        }
    else{
        int size = curlayer->vars.size();
        int preflag = 0;
        for(int i=0; i<size; i++){
            if(curlayer->vars[i]->var_name == $2->var_name){
                preflag = 1;
            }
        }
        if(preflag!=1){
            curlayer->vars.push_back(new variable());
            curlayer->vars.back()->var_name = $2->var_name;
            curlayer->vars.back()->type = $1->type;
            if($1->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curlayer->vars.back()->int_val = $4->int_val;
                //cout<< curlayer->vars.back()->int_val<<endl;
                }
        else if($1->type->type == VALUE_CHAR){
                curlayer->vars.back()->ch_val = $4->ch_val;
                }
        else if($1->type->type == VALUE_STRING){
                curlayer->vars.back()->str_val = $4->str_val;
                }
        else if($1->type->type == VALUE_BOOL){
                cout<<"it's bool"<<endl;
                curlayer->vars.back()->b_val = $4->b_val;
                }
        }
    }
        $$ = node;   
} 
| T IDENTIFIER {// declare
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($2);

        layer* curlayer = layers[layernum];
        if(curlayer->vars.size()==0){
        curlayer->vars.push_back(new variable());
        curlayer->vars[0]->var_name = $2->var_name;
        curlayer->vars[0]->type = $1->type;
        }
         else{
                int size = curlayer->vars.size();
                int preflag = 0;
                for(int i=0; i<size; i++){
                        if(curlayer->vars[i]->var_name == $2->var_name){
                        preflag = 1;
                        }
                }
                if(preflag!=1){
                curlayer->vars.push_back(new variable());
                curlayer->vars.back()->var_name = $2->var_name;
                curlayer->vars.back()->type = $1->type;
                }
    }
        $$ = node;   
}
;

assign 
:   IDENTIFIER LOP_ASSIGN expr {//update the IDTABLE
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
        //搜索ID 在当前层符号表中
        layer* curlayer = layers[layernum];
        int size = curlayer->vars.size();
        //遍历当前层变量
        // TODO assign 后面是表达式的时候会出错,估计是expr当前没有type 没有val的锅
        for(int i=0; i<size; i++){
                if(curlayer->vars[i]->var_name == $1->var_name){
                                if(curlayer->vars[i]->type->type == VALUE_INT){
                                curlayer->vars[i]->int_val = $3->int_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_CHAR){
                                curlayer->vars[i]->ch_val = $3->ch_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_STRING){
                                curlayer->vars[i]->str_val = $3->str_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_BOOL){
                                curlayer->vars[i]->b_val = $3->b_val;
                                }
                        }
                        }
        $$ = node;
}      
;

if_else
: IF bool_statment statement %prec LOWER_THEN_ELSE { 
        //意为前句与LOWER_THEN_ELSE同优先级
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_IF;
        node->addChild($2);
        node->addChild($3);
        $$=node;
}
| IF bool_statment statement ELSE statement {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_IF;
        node->addChild($2);
        node->addChild($3);
        node->addChild($5);
        $$=node;
}
;

while
: WHILE bool_statment statement {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_WHILE;
        node->addChild($2);
        node->addChild($3);
        $$=node;
}
;

printf
: PRINTF LPAREN expr RPAREN {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild($3);
        $$=node;
}
;

scanf
: SCANF LPAREN expr RPAREN {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        $$=node;
}
;

for
: FOR LPAREN declaration SEMICOLON bool_expr SEMICOLON IDENTIFIER SELFADD RPAREN statement{
}
;

bool_statment
: LPAREN bool_expr RPAREN {$$=$2;}
;
expr
:   IDENTIFIER {

        $$ = $1;
}
|   INTEGER {
        $$ = $1;
}
|   CHAR {
        $$ = $1;
}
|   STRING {
        $$ = $1;
}
|   FALSE {
        $$ = $1;
}
|   TRUE {
        $$ = $1;
}
|   expr ADD expr{
        TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
        node->optype = OP_ADD;
        node->type = TYPE_INT;
        node->int_val = $1->int_val + $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MINUS expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MINUS;
        node->type = TYPE_INT;
        node->int_val = $1->int_val - $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MUL expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MUL;
        node->type = TYPE_INT;
        node->int_val = $1->int_val * $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr DIV expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_DIV;
        node->type = TYPE_INT;
        node->int_val = $1->int_val / $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|  expr MOD expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MOD;
        node->type = TYPE_INT;
        node->int_val = $1->int_val % $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
;

bool_expr
: TRUE {$$=$1;}
| FALSE {$$=$1;}
| expr LOP_EQ expr {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_EQ;
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
| NOT bool_expr {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_NOT;
        node->addChild($2);
        $$=node;        
}
;

T
:   T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;} 
|   T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
|   T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
|   T_STRING {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_STRING;}
;

%%


int yyerror(char const* message)
{

  cout << message << " at line " << lineno << endl;
  return -1;
}