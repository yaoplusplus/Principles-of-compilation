%option noyywrap
%{
    #include"common.h"
    #include"main.tab.hh"
    extern vector<layer> layers;
    extern vector<variable> curlayer;
    extern int layernum;
%}

INTEGER 0|[1-9][0-9]*
CHARACTER \'(.*)\'
STRING \"(.*)\"
ID [[:alpha:]_][[:alpha:][:digit:]_]*
IDadd \&[[:alpha:]_][[:alpha:][:digit:]_]*

EOL (\r\n|\n)
WHITE [\t ]

BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
%x LONGCOMMENT
%x SHORTCOMMENT

%%
{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */
"true" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = true;
    yylval = node;
    return TRUE;
}
"false" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = false;
    yylval = node;
    return FALSE;
}
"return" return RETURN;
"int" return INT;
"void" return VOID;
"char" return CHAR;
"string" return STR;
 
"for" return FOR;
"if" return IF;
"while" return WHILE;
"else" return ELSE;

"printf" return PRINTF;
"scanf" return SCANF;

"=" return ASSIGN;
"+=" return ADDASSIGN;
"-=" return MINASSIGN;
"*=" return MULASS;
"/=" return DIVASS;
"%=" return MODASS;

"++" return SELFADD;
"--" return SELFMIN;
"+" return ADD;
"-" return MINUS;
"*" return MULTI;
"/" return DIV;
"%" return MOD;

"!" return NOT;
"&&" return AND;
"||" return OR;
"==" return EQUAL;
"!=" return NEQUAL;
">" return MORETHAN;
">=" return MOREEQUAL;
"<" return LESSTHAN;
"<=" return LESSEQUAL;

"," return COMMA;
";" return SEMICOLON;
"(" return LPAREN;
")" return RPAREN;
"[" return LBRACK;
"]" return RBRACK;
"{" {
    layers.push_back(layer(curlayer, layernum++));
    return LBRACE;
}
"}" return RBRACE;

{INTEGER} {
    TreeNode *node = new TreeNode(NODE_CONINT);
    node->int_val = atoi(yytext);
    node->vartype = VAR_INTEGER;
    yylval = node;
    return INTEGER;
}
{CHARACTER} {
    TreeNode *node = new TreeNode(NODE_CONCHAR);
    if(string(yytext)[1] == '\\')
    {
        if(string(yytext)[2] == 't')
        {
            node->int_val = int('\t');
        }
        else if(string(yytext)[2] == 'n')
        {
            node->int_val = int('\n');
        }
    }
    else
    {
        node->int_val = int(string(yytext)[1]);
    }
    node->vartype = VAR_CHAR;
    yylval = node;
    return CHARACTER;
}
{STRING} {
    TreeNode *node = new TreeNode(NODE_CONSTR);
    string str = string(yytext);
    // 删去双引号
    str.erase(0,str.find_first_not_of("\""));
    str.erase(str.find_last_not_of("\"") + 1);
    node->str_val = str;
    node->vartype = VAR_STR;
    yylval = node;
    return STRING;
}
{ID} {
    TreeNode *node = new TreeNode(NODE_VAR);
    node->var_name = string(yytext);
    vector<variable>::reverse_iterator it = curlayer.rbegin();
    while(it != curlayer.rend())
    {
        if((*it).name == node->var_name)
        {
            node->vartype = (*it).type;
            break;
        }
        it++;
    }
    yylval = node;
    return ID;
}
{IDadd} {
    TreeNode *node = new TreeNode(NODE_VAR);
    string str = string(yytext);
    // 删去&
    str.erase(str.begin());
    node->var_name = str;
    node->varflag = VAR_ADDRESS;
    vector<variable>::reverse_iterator it = curlayer.rbegin();
    while(it != curlayer.rend())
    {
        if((*it).name == node->var_name)
        {
            node->vartype = (*it).type;
            break;
        }
        it++;
    }
    yylval = node;
    return ID;
}
{EOL}
{WHITE}


%%