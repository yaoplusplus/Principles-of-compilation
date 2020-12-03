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
%token T_CHAR T_INT T_STRING T_BOOL T_VOID
%token IDENTIFIER IDADDR INTEGER CHAR BOOL STRING VOID 
%token MAIN 
%token SEMICOLON COMMA DQUOTATION LBRACE RBRACE LPAREN RPAREN
%token LOP_ASSIGN TAKEADDR
%token ADD MINUS MUL DIV MOD SELFADD SELFMIN NEG 
%token LOG_AND LOG_OR  LESSTHAN MORETHAN LESSTHANEQ MORETHANEQ
//%right *= /= 
%right MINASSIGN ADDASSIGN
%right LOP_ASSIGN
%left LOG_OR
%left LOG_AND
%left LOP_EQ //==
%left LESSTHAN MORETHAN LESSTHANEQ MORETHANEQ
%left ADD MINUS 
%left MUL DIV MOD
%right NOT SELFADD SELFMIN UMINUS TAKEADDR//负号
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
|   LBRACE RBRACE {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
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
                cout<<"IDENTIFIER "<< $2->var_name <<" is still declared"<<endl;
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
| T IDENTIFIERLIST {// declare
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($2);
        //添加的ID 包括$2 (IDENTIFIERLIST) 的兄弟
        //$2指向当前大哥 :即第一个声明的ID
        TreeNode* curid = $2;
        while(curid != nullptr){
                
                layer* curlayer = layers[layernum];
                if(curlayer->vars.size()==0){
                        curlayer->vars.push_back(new variable());
                        curlayer->vars[0]->var_name = curid->var_name;
                        curlayer->vars[0]->type = $1->type;
                }
                else{
                        int size = curlayer->vars.size();
                        int preflag = 0;
                        for(int i=0; i<size; i++){
                                if(curlayer->vars[i]->var_name == curid->var_name){
                                        preflag = 1;
                                        cout<<"IDENTIFIER "<< $2->var_name <<" is still declared"<<endl; 
                                }
                        }
                        if(preflag!=1){
                                curlayer->vars.push_back(new variable());
                                curlayer->vars.back()->var_name = curid->var_name;
                                curlayer->vars.back()->type = $1->type;
                        }
                }
                curid = curid->sibling;
        }
        $$ = node;   
} // 函数声明
| T MAIN LPAREN RPAREN statement {
        TreeNode* node = new TreeNode($2->lineno,NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        // node->addChild($2);暂时不把函数名加入树
        node->addChild($5);
        $$ = node;
}
;

IDENTIFIERLIST
:   IDENTIFIER{$$ = $1;}
|   IDENTIFIERLIST COMMA IDENTIFIER {$$ = $1; $$->addSibling($3);}
;

assign //TODO assign 查找ID时不能只看当前层,需要进一步改进(优先看本层)
:   IDENTIFIER LOP_ASSIGN expr {//update the IDTABLE
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
        //搜索ID 在当前层符号表中
        layer* curlayer = layers[layernum];
        int size = curlayer->vars.size();
        //遍历当前层变量
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
|   IDENTIFIER MINASSIGN expr {
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   IDENTIFIER ADDASSIGN expr {
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
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
: PRINTF LPAREN expr COMMA expr RPAREN {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild($3);
        node->addChild($5);
        $$=node;
}
| PRINTF LPAREN expr RPAREN{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild($3);
        $$=node;
}
;

scanf
: SCANF LPAREN expr COMMA IDENTIFIER RPAREN SEMICOLON{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        
        node->addChild($5);
        cout<<"add str"<<endl;
        $$=node;
}
|SCANF LPAREN expr COMMA IDADDR RPAREN SEMICOLON{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        
        node->addChild($5);
        cout<<"add str"<<endl;
        $$=node;
}
| SCANF LPAREN expr RPAREN SEMICOLON{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        $$=node;
}
;
//
for
: FOR LPAREN declaration SEMICOLON bool_expr SEMICOLON expr RPAREN statement{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_FOR;
        node->addChild($3);
        node->addChild($5);
        node->addChild($7);
        node->addChild($9);
        $$=node;
}
;

// TODO remove add main to the IDtable so main should be a ID and set a flag to
//      make sure that there is only one main

bool_statment
: LPAREN bool_expr RPAREN {$$=$2;}
;
expr
:   IDENTIFIER {
        //expr -> IDENTIFIER 时未查找符号表,实现一个查找
        layer* curlayer = layers[layernum];
        int size = layers[layernum]->vars.size();
        for(int i = 0; i < size; i++){
                if(curlayer->vars[i]->var_name == $1->var_name){
                        $1->int_val = curlayer->vars[i]->int_val;
                }
        }
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
|   MINUS expr %prec UMINUS{
        TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
        node->optype = OP_UMINUS;
        node->type = TYPE_INT;
        node->addChild($2);
        $$ = node;
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
|   expr MOD expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MOD;
        node->type = TYPE_INT;
        node->int_val = $1->int_val % $3->int_val;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   TAKEADDR expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_TAKEADDR;
        node->addChild($2);
}
|   expr SELFADD{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_SELFADD;
        node->addChild($1);
}
|   expr SELFMIN{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_SELFMIN;
        node->addChild($2);        
}
;

bool_expr
:   TRUE {$$=$1;}
|   FALSE {$$=$1;}
|   expr {$$=$1;} //不知道会不会有bug
|   bool_expr LOP_EQ bool_expr {// ==
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_EQ;
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr LOG_AND bool_expr { 
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_LOG_AND;
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr LOG_OR bool_expr{
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
         node->optype=OP_LOG_OR; //合起来好,还是分出来好呢?
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr MORETHAN bool_expr{
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr LESSTHAN bool_expr{
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr MORETHANEQ bool_expr{
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   bool_expr LESSTHANEQ bool_expr{
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild($1);
        node->addChild($3);
        $$=node;
}
|   NOT bool_expr {
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
|   T_VOID {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_VOID;cout<<$$->type->getTypeInfo()<<endl;}
;

%%


int yyerror(char const* message)
{

  cout << message << " at line " << lineno << endl;
  return -1;
}