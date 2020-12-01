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
%token IF ELSE WHILE PRINTF SCANF
%token T_CHAR T_INT T_STRING T_BOOL 
%token IDENTIFIER INTEGER CHAR BOOL STRING

%token SEMICOLON LBRACE RBRACE LPAREN RPAREN
%token LOP_ASSIGN 
%token ADD MINUS MUL DIV //MOD SELFADD SELFMIN NEG

%left LOP_EQ //==
%left ADD MINUS 
%left MUL DIV
%right NOT

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
                cout<<"initial the curlayer!"<<endl;
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
                cout<<"the id is not the same"<<endl;
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
:   IDENTIFIER LOP_ASSIGN expr {
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);

        $$ = node;
}
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
|   expr ADD expr{
        TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
        node->optype = OP_ADD;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MINUS expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MUL expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MUL;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr DIV expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_DIV;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
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