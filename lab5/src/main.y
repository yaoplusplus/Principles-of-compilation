%{
    #include "common.h"
    #define YYSTYPE TreeNode *  //此处定义了$$的类型
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
    extern int layernum;
    vector<layer*> layers(1,new layer()); //layer array
    int for_stmt_flag = 0;
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
|   declaration {$$ = $1;}
|   assign SEMICOLON {$$ = $1;}
|   LBRACE statements RBRACE {$$ = $2;}
|   LBRACE RBRACE {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
|   expr SEMICOLON {$$ = $1;} //
|   if_else {$$ = $1;}
|   while {$$ = $1;}
|   scanf SEMICOLON{$$ = $1;}
|   printf SEMICOLON{$$ = $1;}
|   for {$$ = $1;}
;

declaration
: T IDENTIFIER LOP_ASSIGN expr  SEMICOLON{// declare and init
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($2);
        node->addChild($4);
        layer* curlayer = layers[layernum];

        if(curlayer->lvars.size()==0){//第一次加入变量
        curlayer->lvars.push_back(new variables());//增加一个变量域
        variables* curlvars = curlayer->lvars[0];
        curlvars->vars.push_back(new variable());
        variable* curvar = curlvars->vars[0];
        curvar->type = $1->type;
        curvar->var_name = $2->var_name;
        
        if($1->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curvar->int_val = $4->int_val;
                //cout<< curlayer->vars[0]->int_val<<endl;
                }
        else if($1->type->type == VALUE_CHAR){
                curvar->ch_val = $4->ch_val;
                }
        else if($1->type->type == VALUE_STRING){
                curvar->str_val = $4->str_val;
                }
        else if($1->type->type == VALUE_BOOL){
                curvar->b_val = $4->b_val;
                }      
        }
    else{
        int lvars_size = curlayer->lvars.size();
        if(!lvars_size){//如果当前层暂无lvars
                curlayer->lvars.push_back(new variables());
        }
        //当前变量所处的本层作用域
        variables *curlvars = curlayer->lvars[lvars_size-1];
        //当前变量群，之间不可访问
        int vars_size = curlvars->vars.size();
        int preflag = 0;//判断是否重复声明
        //遍历较低层所有变量群

        for(int i=0; i<=layernum; i++){
                int lvars_size = layers[i]->lvars.size();
                for(int j=0; j<lvars_size; j++){
                        int vars_size = layers[i]->lvars[j]->vars.size();
                        for(int k=0; k<vars_size; k++){
                                if(layers[i]->lvars[j]->vars[k]->var_name == $2->var_name){
                                        preflag = 1;
                                }
                        }
                }
        }
        if(preflag!=1){
                
                curlvars->vars.push_back(new variable($1->type,$2->var_name));
                variable *curvar = curlvars->vars[vars_size];
                if($1->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curvar->int_val = $4->int_val;
                //cout<< curlayer->vars.back()->int_val<<endl;
                }
                else if($1->type->type == VALUE_CHAR){
                curvar->ch_val = $4->ch_val;
                }
                else if($1->type->type == VALUE_STRING){
                curvar->str_val = $4->str_val;
                }
                else if($1->type->type == VALUE_BOOL){
                cout<<"it's bool"<<endl;
                curvar->b_val = $4->b_val;
                }
        }
    }
        $$ = node;   
} 
| T IDENTIFIERLIST  SEMICOLON {// declare
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($2);
        //添加的ID 包括$2 (IDENTIFIERLIST) 的兄弟
        //$2指向当前大哥 :即第一个声明的ID
        TreeNode* curid = $2;
        while(curid != nullptr){
                
                layer* curlayer = layers[layernum];
                if(curlayer->lvars.size()==0){
                        // curlayer->vars.push_back(new variable());
                        // curlayer->vars[0]->var_name = curid->var_name;
                        // curlayer->vars[0]->type = $1->type;
                        curlayer->lvars.push_back(new variables());//增加一个变量域
                        variables* curlvars = curlayer->lvars[0];
                        curlvars->vars.push_back(new variable());
                        variable* curvar = curlvars->vars[0];
                        curvar->type = $1->type;
                        curvar->var_name = curid->var_name;
                }
                else{
                        int lvars_size = curlayer->lvars.size();
                        if(!lvars_size){//如果当前层lvars是空的
                                curlayer->lvars.push_back(new variables());
                        }
                        //当前变量所处的本层作用域
                        variables *curlvars = curlayer->lvars[lvars_size-1];
                        //当前变量群，之间不可访问
                        int vars_size = curlvars->vars.size();
                        int preflag = 0;//判断是否重复声明
                        //遍历较低层所有变量群
                        for(int i=0; i<=layernum; i++){
                                int lvars_size = layers[i]->lvars.size();
                                for(int j=0; j<lvars_size; j++){
                                        int vars_size = layers[i]->lvars[j]->vars.size();
                                        for(int k=0; k<vars_size; k++){
                                                if(layers[i]->lvars[j]->vars[k]->var_name == curid->var_name){
                                                        preflag = 1;
                                                }
                                        }
                                }
                        }
                        if(preflag!=1){
                               curlvars->vars.push_back(new variable($1->type,$2->var_name));
                        }
                }
                curid = curid->sibling;
        }
        $$ = node;   
} // 函数声明
| T MAIN LPAREN RPAREN statement { //TODO bug
        TreeNode* node = new TreeNode($1->lineno,NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild($1);
        node->addChild($5);
        $$ = node;
}
;

IDENTIFIERLIST
:   IDENTIFIER{$$ = $1;}
|   IDENTIFIERLIST COMMA IDENTIFIER {$$ = $1; $$->addSibling($3);}
;

assign //TODO assign 
:   IDENTIFIER LOP_ASSIGN expr {//update the IDTABLE
        cout<<"in the assign"<<endl;
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
        //当前层
        layer* curlayer = layers[layernum];
        cout<<"curlayer "<<layernum+1<<endl;
        //当前层一共几个变量集合
        int lvars_size = curlayer->lvars.size();
        cout<<"curlayer->lvars.size "<<lvars_size<<endl;
        if(lvars_size == 0){
               
                goto search_lower_layer;
        }
        //遍历当前lvars
        else{
                variables*curlvars = curlayer->lvars[lvars_size-1];
                int vars_size = curlvars->vars.size();
                if(vars_size){
                        cout<<"assign_var_name "<<$1->var_name<<endl;
                        for(int i=0; i<vars_size; i++){
                                cout<<curlvars->vars[i]->var_name<<endl;
                                // && $1->type->type == curlvars->vars[i]->type->type
                                if($1->var_name == curlvars->vars[i]->var_name){
                                        ValueType temptype = $3->type->type;
                                        if(curlvars->vars[i]->type->type == temptype){
                                                if(temptype == VALUE_INT){
                                                        curlvars->vars[i]->int_val = $3->int_val;
                                                }
                                                else if(temptype == VALUE_CHAR){
                                                        curlvars->vars[i]->ch_val = $3->ch_val;
                                                }
                                                else if(temptype == VALUE_STRING){
                                                        curlvars->vars[i]->str_val = $3->str_val;
                                                }
                                                else if(temptype == VALUE_BOOL){
                                                        curlvars->vars[i]->b_val = $3->b_val;
                                                }
                                                else{}
                                                goto    Over;
                                        }
                                        else{
                                                cout<<"can't convert"<<endl;
                                                goto    Over;
                                        }
                                }         
                        }
                }
        }
                //遍历较低层
search_lower_layer:
        cout<<"search_lower_layer"<<endl;
        for(int i=0;i<layernum;i++){
                cout<<"i "<<i<<endl;
                int lvars_size = layers[i]->lvars.size();
                if(lvars_size!=0)
                for(int j=0; j<=lvars_size; j++){
                        int vars_size = layers[i]->lvars[j]->vars.size();
                        if(vars_size)
                        for(int k=0; k<vars_size; k++){
                                
                                variable* curvar = layers[i]->lvars[j]->vars[k];
                                cout<<curvar->var_name<<endl; //么进来
                              if(curvar->var_name == $1->var_name){
                                      cout<<"get it!"<<endl;
                                      ValueType temptype = $3->type->type;
                                //       if($3->type->type == VALUE_STRING)
                                //       cout<<"ok"<<endl;
                                      // 检查赋值语句的合法性
                                      if(curvar->type->type == temptype){
                                                cout<<"get it!"<<endl;
                                                if(temptype == VALUE_INT){
                                                        curvar->int_val = $3->int_val;
                                                }
                                                else if(temptype == VALUE_CHAR){
                                                        curvar->ch_val = $3->ch_val;
                                                }
                                                else if(temptype == VALUE_STRING){
                                                        curvar->str_val = $3->str_val;
                                                }
                                                else if(temptype == VALUE_BOOL){
                                                        curvar->b_val = $3->b_val;
                                                }
                                                goto Over;
                                        }
                                        else{
                                                cout<<"can't convert"<<endl;
                                                goto Over;
                                        }
                                }  
                        }

                }
        }
Over:
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

scanf //TODO bug
: SCANF LPAREN expr COMMA expr RPAREN{
        // cout<<"2 arg1"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        node->addChild($5);
        $$=node;
}
|SCANF LPAREN expr COMMA IDADDR RPAREN{
        // cout<<"2 arg2"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        node->addChild($5);
        $$=node;
}
| SCANF LPAREN expr RPAREN{
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        // cout<<"one arg"<<endl;
        node->stype=STMT_SCANF;
        // cout<<"one arg"<<endl;
        node->addChild($3);
        // cout<<"one arg"<<endl;
        $$=node;
        
}
;
 // expr 后面时候加分号也要具体到位置
for //expr - SELFADD
: FOR LPAREN declaration bool_expr SEMICOLON expr RPAREN statement{
        for_stmt_flag = 1; //设置标识位置.
        //cout<<"?"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_FOR;
        node->addChild($3);
        node->addChild($4);
        node->addChild($6);
        node->addChild($8);
        $$=node;
        for_stmt_flag = 0;
}
;

// TODO remove add main to the IDtable so main should be a ID and set a flag to
//      make sure that there is only one main

bool_statment
: LPAREN bool_expr RPAREN {$$=$2;}
;
expr
:   IDENTIFIER {
        // //expr -> IDENTIFIER 时未查找符号表,实现一个查找
        // layer* curlayer = layers[layernum];
        // int lvars_size = curlayer->lvars.size();
        // // if(lvars_size == 0){
        // //         printf("line %s,the ID %s hasn't be defined\n",lineno,$1->var_name);
        // // }
        // //遍历当前层以及较低层
        // for(int i=0;i++;i<layernum){
        //         int lvars_size = layers[i]->lvars.size();

        //         for(int j=0;j++;j<=lvars_size){
        //                 int vars_size = layers[i]->lvars[j]->vars.size();
        //                 for(int k=0;k++;k<vars_size){
        //                       if(layers[i]->lvars[j]->vars[k]->var_name == $1->var_name){
        //                               $1->int_val = layers[i]->lvars[j]->vars[k]->int_val;
        //                         }  
        //                 }

        //         }
        // }
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
|   T_VOID {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_VOID;}
;

%%


int yyerror(char const* message)
{

  cout << message << " at line " << lineno << endl;
  return -1;
}