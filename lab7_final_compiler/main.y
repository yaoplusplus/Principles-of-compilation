%{
    #include"common.h"
    extern TreeNode * root;
    int yylex();
    int yyerror( char const * );
    //分作用域放置变量
    extern vector<layer> layers;
    //全局变量
    extern vector<variable> gblayer;
    //当前可访问到的变量
    extern vector<variable> curlayer;
    
    extern int layernum;
    extern rodata myrodata;
    extern function myfunc;
    int tmpdecla = 1;
    bool defflag = 0;
    bool scanflag = 0;
    bool whileflag = 0;
    bool for_decla = 0;
    bool for_bool = 0;
    bool for_assign = 0;
    vector<string> whileasm;
    vector<string> forasm;
    int curlabel;
    vector<int> label;
    int if_lev = 0;
    int whilecounter = 0;
    int forcounter = 0;
    int bool_label = 0;
    vector<tmpvariable> forvars;
    int forlevel = 0;
    bool retflag = 0;
%}
%defines

%start program

%token ID IDadd INTEGER CHARACTER STRING
%token IF ELSE WHILE FOR RETURN
%token INT VOID CHAR STR
%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE COMMA SEMICOLON
%token TRUE FALSE
%token ADD MINUS MULTI DIV MOD SELFADD SELFMIN UMINUS
%token ASSIGN ADDASSIGN MINASSIGN MULASS DIVASS MODASS
%token EQUAL NEQUAL MORETHAN MOREEQUAL LESSTHAN LESSEQUAL NOT AND OR
%token PRINTF SCANF

%right ASSIGN ADDASSIGN MINASSIGN MULASS DIVASS MODASS
%right SELFADD SELFMIN
%right OR
%left ADD MINUS
%left MULTI DIV MOD
%left EQUAL NEQUAL MORETHAN MOREEQUAL LESSTHAN LESSEQUAL
%right AND
%right NOT
%right UMINUS 
%right LPAREN RPAREN 
%nonassoc LOWER_THEN_ELSE
%nonassoc ELSE 
%%
program
    : statements {
        root=new TreeNode(NODE_PROG);
        root->addChild($1);
        if(!retflag)
        {
            myrodata.output();
            myfunc.output();
            printf("\t.section\t.note.GNU-stack,\"\",@progbits\n\n");
        }
    }
    ;
statements
    : statement {$$=$1;}
    | statements statement{$$=$1;$$->addSibling($2);}
    ;
statement
    : declaration {$$=$1;}
    | if_else {$$=$1;}
    | while {$$=$1;}
    | for {$$=$1;}
    | LBRACE statements RBRACE {
        $$=$2;
        vector<variable> var = layers[layers.size()-1].vars;
        while(curlayer.size()!=var.size())
        {
            if(curlayer[curlayer.size()-1].type != 4) myfunc.addAsmcode("\taddl\t$4, %esp\n");
            curlayer.pop_back();
        }
        layers.pop_back();
        layernum--;
    }
    | call_func {$$=$1;}
    | printf SEMICOLON {$$=$1;}
    | scanf SEMICOLON {$$=$1;}
    | RETURN INTEGER SEMICOLON {
        vector<variable> var = layers[layers.size()-1].vars;
        while(curlayer.size()!=var.size())
        {
            if(curlayer[curlayer.size()-1].type != 4) myfunc.addAsmcode("\taddl\t$4, %esp\n");
            curlayer.pop_back();
        }
        myfunc.setret($2->int_val);
        myrodata.output();
        myfunc.output();
        printf("\t.section\t.note.GNU-stack,\"\",@progbits\n\n");
        retflag = 1;
    }
    ;
assign
    : IDS ASSIGN expr{
        string index;
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->addChild($1);
        node->addChild($3);
        // if($1->vartype != $3->vartype)
        // {
        //     printf("INVALID type assign type error\n");
        //     // exit(1);
        // }
        if($3->vartype == VAR_STR)
            goto END1;
        if($1->str_val != "gb"){
            if($1->int_val == -1)
                index = to_string(4*(tmpdecla++));
            else 
                index = to_string(4*$1->int_val);
            if(layernum!=0)
            {
                if(for_assign)
                {
                    forasm.push_back("\tpopl\t%eax\n");
                    forasm.push_back("\tmovl\t%eax, -"+index+"(%ebp)\n");
                }
                else
                {
                    myfunc.addAsmcode("\tpopl\t%eax\n");
                    myfunc.addAsmcode("\tmovl\t%eax, -"+index+"(%ebp)\n");
                }
                if(defflag) myfunc.addAsmcode("\tsubl\t$4, %esp\n");
            }
        }
        else{
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tmovl\t%eax, " + $1->var_name + "\n");
        }
        END1:$$=node;
    }
    | IDS ADDASSIGN expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_ADD;
        node->addChild($1);
        node->addChild($3);
        // if($1->vartype != -1 && $1->vartype != $3->vartype)
        // {
        //     printf("INVALID type\n");
        //     exit(1);
        // }
        if($1->str_val != "gb"){
            string str = "\tpopl\t%eax\n";
            str += "\taddl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
            str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        else
        {
            string str = "\tpopl\t%eax\n";
            str += "\taddl\t" + $1->var_name + ", %eax\n";
            str += "\tmovl\t%eax, " + $1->var_name + "\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        $$=node;
    }
    | IDS MINASSIGN expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        // if($1->vartype != -1 && $1->vartype != $3->vartype)
        // {
        //     printf("INVALID type\n");
        //     exit(1);
        // }
        if($1->str_val != "gb"){
            string str = "\tpopl\t%eax\n";
            str += "\tsubl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
            str += "\tmovl\t$-1, %ebx\n";
            str += "\timull\t%ebx\n";
            str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        else{
            string str = "\tpopl\t%eax\n";
            str += "\tsubl\t" + $1->var_name + ", %eax\n";
            str += "\tmovl\t$-1, %ebx\n";
            str += "\timull\t%ebx\n";
            str += "\tmovl\t%eax, " + $1->var_name + "\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        $$=node;
    }
    | IDS MULASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_MULTI;
        node->addChild($1);
        node->addChild($3);
        // if($1->vartype != -1 && !($1->vartype == $3->vartype && $1->vartype == VAR_INTEGER))
        // {
        //     printf("INVALID type\n");
        //     exit(1);
        // }
        if($1->str_val != "gb")
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
            str += "\timull\t%ebx\n";
            str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        else
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t" + $1->str_val + ", %eax\n";
            str += "\timull\t%ebx\n";
            str += "\tmovl\t%eax, "+$1->str_val+"\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        $$=node;
    }
    | IDS DIVASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_DIV;
        node->addChild($1);
        node->addChild($3);
        if($1->str_val != "gb")
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
            str += "\tcltd\n";
            str += "\tidivl\t%ebx\n";
            str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        else
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t" + $1->str_val + ", %eax\n";
            str += "\tcltd\n";
            str += "\tidivl\t%ebx\n";
            str += "\tmovl\t%eax, "+$1->str_val+"\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        $$=node;
    }
    | IDS MODASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_MOD;
        node->addChild($1);
        node->addChild($3);
        if($1->str_val != "gb")
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
            str += "\tcltd\n";
            str += "\tidivl\t%ebx\n";
            str += "\tmovl\t%edx, -"+to_string(4*$1->int_val)+"(%ebp)\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        else
        {
            string str = "\tpopl\t%ebx\n";
            str += "\tmovl\t" + $1->str_val + ", %eax\n";
            str += "\tcltd\n";
            str += "\tidivl\t%ebx\n";
            str += "\tmovl\t%edx, "+$1->str_val+"\n";
            if(for_assign)
            {
                forasm.push_back(str);
            }
            else
            {
                myfunc.addAsmcode(str);
            }
        }
        $$=node;
    }
    | IDS SELFADD {
        TreeNode *node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_SADD;
        node->addChild($1);
        string str = "\tmovl\t$1, %eax\n";
        str += "\taddl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
        str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node; 
    }
    | IDS SELFMIN {
        TreeNode *node=new TreeNode(NODE_ASSIGN);
        node->optype=OP_SMIN;
        node->addChild($1);
        $$=node; 
        string str = "\tmovl\t$-1, %eax\n";
        str += "\taddl\t-" + to_string(4*$1->int_val) + "(%ebp), %eax\n";
        str += "\tmovl\t%eax, -"+to_string(4*$1->int_val)+"(%ebp)\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
    }
    ;
args
    : IDS {
        $$=$1; 
        string index;
        //临时索引
        if($1->int_val == -1)
            index = to_string(4*(tmpdecla++));
        else
            index = to_string(4*$1->int_val);
        //全局变量
        if(layernum!=0)
        {
            myfunc.addAsmcode("\tmovl\t$0, -"+index+"(%ebp)\n"); 
            if(defflag) myfunc.addAsmcode("\tsubl\t$4, %esp\n");
        }
    }
    | assign {

        $$=$1;
        $$->str_val = "gb";
        
    }
    | args COMMA IDS {
        $$=$1;
        $$->addSibling($3);
        string index;
        if($1->int_val == -1)
            index = to_string(4*(tmpdecla++));
        else
            index = to_string(4*$3->int_val);
        if(layernum!=0)
        {
            myfunc.addAsmcode("\tmovl\t$0, -"+index+"(%ebp)\n"); 
            if(defflag) myfunc.addAsmcode("\tsubl\t$4, %esp\n");
        }
    }
    | args COMMA assign {$$=$1; $$->addSibling($3);}
    ;
call_args
    : expr {$$=$1;}
    | IDadd {$$=$1;}
    | call_args COMMA expr {$$=$1; $$->addSibling($3);}
    | call_args COMMA IDadd {$$=$1; $$->addSibling($3);}
    ;
call_func
    : type ID LPAREN call_args RPAREN statement {
        TreeNode *node=new TreeNode(NODE_FUNC);
        node->addChild($1);
        node->addChild($2);
        node->addChild($4);
        node->addChild($6);
        $$=node;
    }
    | type ID LPAREN RPAREN statement {
        TreeNode *node=new TreeNode(NODE_FUNC);
        node->addChild($1);
        node->addChild($2);
        node->addChild($5);
        myfunc.set($1->vartype, $2->var_name);
        $$=node;
    }
    ;
_else
    : ELSE
    {
        curlabel = label[if_lev-1];
        string lb1 = "LB" + to_string(curlabel) + to_string(if_lev - 1);
        string lb2 = "LB" + to_string(curlabel-1) + to_string(if_lev - 1);
        myfunc.addAsmcode("\tjmp\t" + lb1 + "\n");
        myfunc.addAsmcode(lb2 + ":\n");
        label.push_back(curlabel);
        curlabel = 0;
    }
    ;
iftest
    : IF bool_statment
    {
        myfunc.addAsmcode("\tpopl\t%eax\n");
        myfunc.addAsmcode("\tcmp\t$1, %eax\n");
        string lb = "LB" + to_string(curlabel++) + to_string(if_lev++);
        myfunc.addAsmcode("\tjne\t"+lb+"\n");
        label.push_back(curlabel);
        curlabel = 0;
        $$=$2;
    }
    ;
if_else
    : iftest statement %prec LOWER_THEN_ELSE {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_IF;
        node->addChild($1);
        node->addChild($2);
        curlabel = label[if_lev-1];
        string lb = "LB" + to_string(curlabel-1) + to_string(--if_lev);
        myfunc.addAsmcode(lb + ":\n");
        label.pop_back();
        $$=node;
    }
    | iftest statement _else statement {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_IF;
        node->addChild($1);
        node->addChild($2);
        node->addChild($4);
        curlabel = label[if_lev-1];
        string lb = "LB" + to_string(curlabel) + to_string(--if_lev);
        myfunc.addAsmcode(lb + ":\n");
        label.pop_back();
        $$=node;
    }
    ;
_while
    : WHILE {
        whileflag = 1;
    }
while_bool
    : _while bool_statment {
        TreeNode *node=new TreeNode(NODE_WEXPR);
        node->int_val=whilecounter;
        node->addChild($2);
        myfunc.addAsmcode("WS"+to_string(whilecounter)+":\n");
        for(int i = 0;i < whileasm.size();i++)
        {
            myfunc.addAsmcode(whileasm[i]);
        }
        whileasm.clear();
        myfunc.addAsmcode("\tpopl\t%eax\n");
        myfunc.addAsmcode("\tcmpl\t$1, %eax\n");
        myfunc.addAsmcode("\tjne\tWE"+to_string(whilecounter++)+"\n");
        whileflag = 0;
        $$=node;
    }
while
    : while_bool statement {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_WHILE;
        node->addChild($1);
        node->addChild($2);
        myfunc.addAsmcode("\tjmp\tWS"+to_string($1->int_val)+"\n");
        myfunc.addAsmcode("WE"+to_string($1->int_val)+":\n");
        $$=node;
    }
    ;
for
    : _for for_expr statement{
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_FOR;
        node->addChild($2);
        node->addChild($3);
        $$=node;
        while(forvars[forvars.size()-1].l == forlevel)
        {
            curlayer.pop_back();
            forvars.pop_back();
        }
        forlevel--;
        for(int i = 0;i < forasm.size();i++)
        {
            myfunc.addAsmcode(forasm[i]);
        }
        forasm.clear();
        myfunc.addAsmcode("\tjmp\tFS"+to_string($2->getChild(0)->int_val)+"\n");
        myfunc.addAsmcode("FE"+to_string($2->getChild(0)->int_val)+":\n");
    }
    ;
_for
    : FOR
    {
        $$=$1;
        for_decla = 1;
        for_bool = 0;
        for_assign = 0;
    }
for_expr
    : for_expr1 for_expr2 {
        TreeNode *node=new TreeNode(NODE_FEXPR);
        node->int_val = forcounter;
        node->addChild($1);
        node->addChild($2);
        $$ = node;
    }
for_expr1
    : LPAREN declaration bool_expr SEMICOLON {
        TreeNode *node=new TreeNode(NODE_FEXPR);
        node->int_val = forcounter;
        node->addChild($2);
        node->addChild($3);
        for(int i = 0;i < forasm.size();i++)
        {
            myfunc.addAsmcode(forasm[i]);
        }
        forasm.clear();
        myfunc.addAsmcode("\tpopl\t%eax\n");
        myfunc.addAsmcode("\tcmpl\t$1, %eax\n");
        myfunc.addAsmcode("\tjne\tFE"+to_string(forcounter)+"\n");
        for_bool = 0;
        for_assign = 1;
        $$=node;
    }
for_expr2
    : assign RPAREN {
        TreeNode *node=new TreeNode(NODE_FEXPR);
        node->int_val = forcounter++;
        node->addChild($1);
        for_assign = 0;
        $$ = node;
        forlevel++;
    }
bool_statment
    : LPAREN bool_expr RPAREN {$$=$2;}
    ;
declaration
    : type args SEMICOLON {
        // cout<<"ok"<<endl;
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_DECL;
        node->addChild($1);
        node->addChild($2);

        int vtype = $1->vartype;
        $$=node;
        int preflag = 0;
        vector<variable> lastlayer;
        if(!layers.empty())
        {
            lastlayer = layers[layers.size()-1].vars;
        }
        for(int i = 1;i < node->childNum();i++)
        {
            TreeNode* cld = node->getChild(i);
            // if(cld->childNum() != 0 && cld->getChild(1)->vartype != vtype)
            // {
            //     printf("INVALID type\n");
            //     exit(1);
            // }
            for(int j = lastlayer.size();j < curlayer.size();j++)
            {
                if(curlayer[j].name == (cld->nodetype==NODE_ASSIGN?cld->getChild(0)->var_name:cld->var_name))
                {
                    printf("ParseError(Same Variable)\n");
                    // layer(curlayer, layernum).print();
                    preflag = 1;
                    break;
                }
            }
            if(!preflag)
            {
                if(vtype == VAR_STR)
                {
                    if(cld->childNum() == 0)
                    {
                        printf("STRING NOT CONSTANT\n");
                        exit(1);
                    }
                    curlayer.push_back(variable(cld->getChild(0)->var_name, myrodata.size()));
                    myrodata.push_back(cld->getChild(1)->str_val);
                    if(for_decla) forvars.push_back(tmpvariable(variable(cld->getChild(0)->var_name, myrodata.size()), forlevel));
                    goto Over;
                }
                if(layernum == 0){
                    if(cld->childNum()!=0)
                    {
                        myrodata._bss.push_back(cld->getChild(0)->var_name);
                        variable var($1->vartype,cld->getChild(0)->var_name);
                        gblayer.push_back(var);
                    }
                    else{
                        myrodata._bss.push_back(cld->var_name);
                        variable var($1->vartype,cld->var_name);
                        gblayer.push_back(var);
                    }
                    
                }
                else{
                    curlayer.push_back(variable($1->vartype, cld->nodetype==NODE_ASSIGN?cld->getChild(0)->var_name:cld->var_name));
                    if(for_decla) forvars.push_back(tmpvariable(variable($1->vartype, cld->nodetype==NODE_ASSIGN?cld->getChild(0)->var_name:cld->var_name), forlevel));
                }
            }
            Over:preflag = 0;
        }
        if(for_decla) 
        {
            for_bool = 1;
            myfunc.addAsmcode("FS" + to_string(forcounter) + ":\n");
        }
        for_decla = 0;
        defflag = 0;
        tmpdecla = curlayer.size() + 1;
        // 确实添加进符号表了
        // vector<variable>::iterator it = curlayer.begin();
        // while(it!=curlayer.end()){
        //     cout<<(*it).name<<endl;
        //     it++;
        // }
    }
    | args SEMICOLON {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_ASSIGN;
        node->addChild($1);
        // for(int i = 0;i < node->childNum();i++)
        // {
        //     TreeNode* cld = node->getChild(i);
        //     if(cld->childNum() != 1 && cld->getChild(0)->vartype != cld->getChild(1)->vartype)
        //     {
        //         printf("INVALID type\n");
        //         exit(1);
        //     }
        // }
        $$=node;  
    }
    ;
printf
    : PRINTF LPAREN STRING COMMA call_args RPAREN {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild($3);
        node->addChild($5);
        myrodata.push_back($3->str_val);

        vector<int> control;
        string str = $3->str_val;
        for(int i = 0;i < str.length();i++)
        {
            if(str[i] == '%')
            {
                if(i+1 == str.length())
                {
                    printf("INVALID CONTROL\n");
                    exit(1);
                }
                switch(str[i+1])
                {
                    case 'd':
                        control.push_back(VAR_INTEGER);
                        break;
                    case 'c':
                        control.push_back(VAR_CHAR);
                        break;
                    case 's':
                        control.push_back(VAR_STR);
                        break;
                    default:
                        printf("INVALID CONTROL.\n");
                        exit(1);
                }
            }
        }
        if(control.size()+1 != node->childNum())
        {
            printf("INVALID SCANF.\n");
            exit(1);
        }
        vector<string> tmpv;
        for(int i = 0;i < control.size();i++)
        {
            TreeNode* cld = node->getChild(i+1);
            // if(control[i] != cld->vartype)
            // {
            //     printf("INVALID type\n");
            //     exit(1);
            // }
            tmpv.push_back(myfunc.delCode());
        }
        for(int i = 0;i < tmpv.size();i++)
        {
            myfunc.addAsmcode(tmpv[i]);
        }
        myfunc.addAsmcode("\tsubl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\tpushl\t$STR"+to_string(myrodata.size()-1)+"\n");
        myfunc.addAsmcode("\tcall\tprintf\n");
        myfunc.addAsmcode("\taddl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\taddl\t$"+to_string(control.size()*4+4)+", %esp\n");
        $$=node;
    }
    | PRINTF LPAREN STRING RPAREN{
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild($3);
        myrodata.push_back($3->str_val);
        myfunc.addAsmcode("\tsubl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\tpushl\t$STR"+to_string(myrodata.size()-1)+"\n");
        myfunc.addAsmcode("\tcall\tprintf\n");
        myfunc.addAsmcode("\taddl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\taddl\t$4, %esp\n");
        $$=node;
    }
    ;
_SCANF
    : SCANF
    {
        scanflag = 1;
    }
scanf
    : _SCANF LPAREN STRING COMMA call_args RPAREN {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild($3);
        node->addChild($5);
        myrodata.push_back($3->str_val);
        //check type
        vector<int> control;
        string str = $3->str_val;
        for(int i = 0;i < str.length();i++)
        {
            if(str[i] == '%')
            {
                if(i+1 == str.length())
                {
                    printf("INVALID CONTROL\n");
                    exit(1);
                }
                switch(str[i+1])
                {
                    case 'd':
                        control.push_back(VAR_INTEGER);
                        break;
                    case 'c':
                        control.push_back(VAR_CHAR);
                        break;
                    case 's':
                        control.push_back(VAR_STR);
                        break;
                    default:
                        printf("INVALID CONTROL.\n");
                        exit(1);
                }
            }
        }
        if(control.size()+1 != node->childNum())
        {
            printf("INVALID SCANF.\n");
            exit(1);
        }
        vector<string> tmpv;
        for(int i = 0;i < control.size();i++)
        {
            TreeNode* cld = node->getChild(i+1);
            if(control[i] != cld->vartype)
            {
                printf("INVALID type scanf type error\n");
                // exit(1);
            }
            tmpv.push_back(myfunc.delCode());
        }
        for(int i = 0;i < tmpv.size();i++)
        {
            string str = tmpv[i].substr(7);
            str = "\tleal\t" + str.substr(0, str.find("\n")) + ", %eax\n";
            myfunc.addAsmcode(str);
            myfunc.addAsmcode("\tpushl\t%eax\n");
        }
        myfunc.addAsmcode("\tsubl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\tpushl\t$STR"+to_string(myrodata.size()-1)+"\n");
        myfunc.addAsmcode("\tcall\tscanf\n");
        myfunc.addAsmcode("\taddl\t$"+to_string(curlayer.size()*4)+", %ebp\n");
        myfunc.addAsmcode("\taddl\t$"+to_string(control.size()*4+4)+", %esp\n");
        $$=node;
        scanflag = 0;
    }
    ;
bool_expr
    : TRUE {
        $$=$1; 
        $$->vartype = VAR_BOOLEAN; 
        if(whileflag)
        {
            whileasm.push_back("\tpushl\t$1\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpushl\t$1\n");
        }
        else
        {
            myfunc.addAsmcode("\tpushl\t$1\n");
        }
    }
    | FALSE {
        $$=$1; 
        $$->vartype = VAR_BOOLEAN; 
        if(whileflag)
        {
            whileasm.push_back("\tpushl\t$0\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpushl\t$0\n");
        }
        else
        {
            myfunc.addAsmcode("\tpushl\t$0\n");
        }
    }
    | expr EQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_EQ;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != $3->vartype)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        string str = "\tpopl\t%eax\n"; 
        str += "\tpopl\t%ebx\n";
        str += "\tcmpl\t%eax, %ebx\n";
        str += "\tjne\t.BB" + to_string(bool_label++) + "\n";
        str += "\tpushl\t$1\n";
        str += "\tjmp\t.BB" + to_string(bool_label++) + "\n";
        str += ".BB" + to_string(bool_label-2) + ":\n";
        str += "\tpushl\t$0\n";
        str += ".BB" + to_string(bool_label-1) + ":\n";
        if(whileflag)
        {
            whileasm.push_back(str);
        }
        else if(for_bool)
        {
            forasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;
    }
    | expr NEQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_NE;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != $3->vartype)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\tcmpl\t%eax, %ebx\n");
            whileasm.push_back("\tje\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\tcmpl\t%eax, %ebx\n");
            forasm.push_back("\tje\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tcmpl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tje\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
        $$=node;
    }
    | expr MORETHAN expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_BT;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        $$=node;
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\tcmpl\t%eax, %ebx\n");
            whileasm.push_back("\tjle\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\tcmpl\t%eax, %ebx\n");
            forasm.push_back("\tjle\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tcmpl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tjle\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
    }
    | expr MOREEQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_BE;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        $$=node;
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\tcmpl\t%eax, %ebx\n");
            whileasm.push_back("\tjl\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\tcmpl\t%eax, %ebx\n");
            forasm.push_back("\tjl\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tcmpl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tjl\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
    }
    | expr LESSTHAN expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_LT;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\tcmpl\t%eax, %ebx\n");
            whileasm.push_back("\tjge\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\tcmpl\t%eax, %ebx\n");
            forasm.push_back("\tjge\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tcmpl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tjge\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
        $$=node;
    }
    | expr LESSEQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_LE;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\tcmpl\t%eax, %ebx\n");
            whileasm.push_back("\tjg\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\tcmpl\t%eax, %ebx\n");
            forasm.push_back("\tjg\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tcmpl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tjg\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
        $$=node;
    }
    | bool_expr AND bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_AND;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_BOOLEAN || $3->vartype != VAR_BOOLEAN)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\taddl\t%eax, %ebx\n");
            whileasm.push_back("\tmovl\t$2, %eax\n");
            whileasm.push_back("\tcmpl\t%ebx, %eax\n");
            whileasm.push_back("\tjne\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\taddl\t%eax, %ebx\n");
            forasm.push_back("\tmovl\t$2, %eax\n");
            forasm.push_back("\tcmpl\t%ebx, %eax\n");
            forasm.push_back("\tjne\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\taddl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tmovl\t$2, %eax\n");
            myfunc.addAsmcode("\tcmpl\t%ebx, %eax\n");
            myfunc.addAsmcode("\tjne\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
        $$=node;
    }
    | bool_expr OR bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_OR;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_BOOLEAN;
        // if($1->vartype != VAR_BOOLEAN || $3->vartype != VAR_BOOLEAN)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        if(whileflag)
        {
            whileasm.push_back("\tpopl\t%eax\n");
            whileasm.push_back("\tpopl\t%ebx\n");
            whileasm.push_back("\taddl\t%eax, %ebx\n");
            whileasm.push_back("\tmovl\t$0, %eax\n");
            whileasm.push_back("\tcmpl\t%ebx, %eax\n");
            whileasm.push_back("\tje\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back("\tpushl\t$1\n");
            whileasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            whileasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            whileasm.push_back("\tpushl\t$0\n");
            whileasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else if(for_bool)
        {
            forasm.push_back("\tpopl\t%eax\n");
            forasm.push_back("\tpopl\t%ebx\n");
            forasm.push_back("\taddl\t%eax, %ebx\n");
            forasm.push_back("\tmovl\t$0, %eax\n");
            forasm.push_back("\tcmpl\t%ebx, %eax\n");
            forasm.push_back("\tje\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back("\tpushl\t$1\n");
            forasm.push_back("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            forasm.push_back(".BB" + to_string(bool_label-2) + ":\n");
            forasm.push_back("\tpushl\t$0\n");
            forasm.push_back(".BB" + to_string(bool_label-1) + ":\n");
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%eax\n");
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\taddl\t%eax, %ebx\n");
            myfunc.addAsmcode("\tmovl\t$0, %eax\n");
            myfunc.addAsmcode("\tcmpl\t%ebx, %eax\n");
            myfunc.addAsmcode("\tje\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode("\tpushl\t$1\n");
            myfunc.addAsmcode("\tjmp\t.BB" + to_string(bool_label++) + "\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-2) + ":\n");
            myfunc.addAsmcode("\tpushl\t$0\n");
            myfunc.addAsmcode(".BB" + to_string(bool_label-1) + ":\n");
        }
        $$=node;
    }
    | NOT bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_NOT;
        node->addChild($2);
        node->vartype=VAR_BOOLEAN;
        // if($2->vartype != VAR_BOOLEAN)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        string str = "\tpopl\t%eax\n";
        str += "\tcmpl\t$0, %eax\n";
        str += "\tjne\t.BB" + to_string(bool_label++) + "\n";
        str += "\tpushl\t$1\n";
        str += "\tjmp\t.BB" + to_string(bool_label++) + "\n";
        str += ".BB" + to_string(bool_label-2) + ":\n";
        str += "\tpushl\t$0\n";
        str += ".BB" + to_string(bool_label-1) + ":\n";
        if(whileflag)
        {
            whileasm.push_back(str);
        }
        else if(for_bool)
        {
            forasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;        
    }
    | expr
    {
        $$=$1;
        string str = "\tpopl\t%eax\n";
        str += "\tcmpl\t$0, %eax\n";
        str += "\tje\t.BB" + to_string(bool_label++) + "\n";
        str += "\tpushl\t$1\n";
        str += "\tjmp\t.BB" + to_string(bool_label++) + "\n";
        str += ".BB" + to_string(bool_label-2) + ":\n";
        str += "\tpushl\t$0\n";
        str += ".BB" + to_string(bool_label-1) + ":\n";
        myfunc.addAsmcode(str);
    }
    | LPAREN bool_expr RPAREN
    {
        $$ = $2;
    }
    ;
expr
    : IDS {
        
        $$=$1;
        vector<variable>::reverse_iterator it = curlayer.rbegin();
        int i = 0;
        int gbl_size = gblayer.size();
        while(it != curlayer.rend())
        {
            if((*it).name == $$->var_name)
            {
                string code = "\tpushl\t";
                if($$->vartype == VAR_STR)
                    code += "$STR" + to_string($$->int_val) + "\n";
                else
                    code += "-" + to_string(4*(curlayer.size()-i)) + "(%ebp)\n";
                if(whileflag)
                {
                    whileasm.push_back(code);
                }
                else if(for_bool || for_assign)
                {
                    forasm.push_back(code);
                }
                else
                {
                    myfunc.addAsmcode(code);
                }
                goto searend;
            }
            it++;
            i++;
        }
        if(gbl_size){
            for(int i=0; i<gbl_size; i++){
                if(gblayer[i].name == $1->var_name){
                //
                    string code = "\tpushl\t";
                    code += $1->var_name + "\n";
                    if(whileflag)
                    {
                        whileasm.push_back(code);
                    }
                    else if(for_bool || for_assign)
                    {
                        forasm.push_back(code);
                    }
                    else
                    {
                        myfunc.addAsmcode(code);
                    }
                    break;
                    goto searend;
                }
            }
        }
        searend:1;
    }
    | INTEGER {
        $$=$1;
        if(layernum!=0)
        {
            if(whileflag)
            {
                whileasm.push_back("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
            else if(for_bool || for_assign)
            {
                forasm.push_back("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
            else
            {
                myfunc.addAsmcode("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
        }
    }
    | CHARACTER {
        $$=$1;
        if(layernum!=0)
        {
            if(whileflag)
            {
                whileasm.push_back("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
            else if(for_bool || for_assign)
            {
                forasm.push_back("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
            else
            {
                myfunc.addAsmcode("\tpushl\t$" + to_string($$->int_val) + "\n");
            }
        }
    }
    | STRING {$$=$1;}
    | expr ADD expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_ADD;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_INTEGER;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     // exit(1);
        // } 
        string str = "\tpopl\t%ebx\n\tpopl\t%eax\n\taddl\t%eax, %ebx\n\tpushl\t%ebx\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else if(whileflag)
        {
            whileasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;   
    }
    | expr MINUS expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_INTEGER;
        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }
        string str = "\tpopl\t%eax\n\tpopl\t%ebx\n\tsubl\t%eax, %ebx\n\tpushl\t%ebx\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else if(whileflag)
        {
            whileasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;   
    }
    | expr MULTI expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_MULTI;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_INTEGER;

        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }

        string str = "\tpopl\t%ebx\n\tpopl\t%eax\n\timull\t%ebx\n\tpushl\t%eax\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else if(whileflag)
        {
            whileasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;   
    }
    | expr DIV expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_DIV;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_INTEGER;

        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }

        string str = "\tpopl\t%ebx\n\tpopl\t%eax\n\tcltd\n\tidivl\t%ebx\n\tpushl\t%eax\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else if(whileflag)
        {
            whileasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;   
    }
    | expr MOD expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_MOD;
        node->addChild($1);
        node->addChild($3);
        node->vartype=VAR_INTEGER;

        // if($1->vartype != VAR_INTEGER || $3->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE\n");
        //     exit(1);
        // }

        string str = "\tpopl\t%ebx\n\tpopl\t%eax\n\tcltd\n\tidivl\t%ebx\n\tpushl\t%edx\n";
        if(for_assign)
        {
            forasm.push_back(str);
        }
        else if(whileflag)
        {
            whileasm.push_back(str);
        }
        else
        {
            myfunc.addAsmcode(str);
        }
        $$=node;   
    }
    | MINUS expr %prec UMINUS {
        TreeNode *node=new TreeNode(NODE_OP);
        node->optype=OP_UMIN;
        node->addChild($2);
        node->vartype=VAR_INTEGER;
        
        // if($2->vartype != VAR_INTEGER)
        // {
        //     printf("INVALID TYPE need UMINUS INTEGER\n");
        // }

        TreeNode* cld = node->getChild(0);
        if(cld->var_name == "#")
        {
            if(cld->int_val<0)
                myfunc.resetCode("\tpushl\t$" + to_string(cld->int_val) + "\n");
            else{
                myfunc.resetCode("\tpushl\t$-" + to_string(cld->int_val) + "\n");
            }
        }
        else
        {
            myfunc.addAsmcode("\tpopl\t%ebx\n");
            myfunc.addAsmcode("\tmovl\t$-1, %eax\n");
            myfunc.addAsmcode("\timull\t%ebx\n");
            myfunc.addAsmcode("\tpushl\t%eax\n");
        }
        $$=node; 
    }
    | LPAREN expr RPAREN
    {
        $$ = $2;
    }
    ;
type
    : INT {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->vartype=VAR_INTEGER;
        defflag = 1;
        $$=node; 
    }
    | VOID {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->vartype=VAR_VOID;
        defflag = 1;
        $$=node;         
    }
    | CHAR {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->vartype=VAR_CHAR;
        defflag = 1;
        $$=node;
    }
    | STR {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->vartype=VAR_STR;
        defflag = 1;
        $$=node;
    }
    ;
IDS 
    : ID {
        // cout<<"name "<<$1->var_name<<endl;
        if($1->int_val == -1)
        {
            vector<variable>::reverse_iterator it1 = curlayer.rbegin();
            int i = 0;
            while(it1 != curlayer.rend())
            {
                if((*it1).name == $$->var_name)
                {
                    $1->vartype = (*it1).type;
                    break;
                }
                it1++;
                i++;
            }
            if(!defflag) $1->int_val = curlayer.size() - i;
            if($1->vartype == VAR_STR) $1->int_val = (*it1).rodata_index;
            //global variable
            vector<variable>::iterator it2 = gblayer.begin();
            while(it2 != gblayer.end())
            {
                if((*it2).name == $1->var_name)
                {
                    $1->str_val = "gb";
                    break;
                }
                it2++;
            }
        }

        $$=$1;
    }
%%