%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
#include "tree.h"
vector<TreeNode*> layers(1,new TreeNode());
int layernum = 0;
int lineno=1;
%}

BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

INTEGER [0-9]+
CHAR \'.?\'
STRING \".+\"
IDENTIFIER [[:alpha:]_][[:alpha:][:digit:]_]*
LBRACE \{
RBRACE \}

%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */

"int" return T_INT;
"bool" return T_BOOL;
"char" return T_CHAR;
"string" return T_STRING;

"if" return IF;
"while" return WHILE;
"else" return ELSE;

"printf" return PRINTF;
"scanf" return SCANF;

"==" return LOP_EQ;
"=" return LOP_ASSIGN;
"+" return ADD;
"-" return MINUS;
"*" return MUL;
"/" return DIV;
"!" return NOT;

";" return  SEMICOLON;
"(" return LPAREN;
")" return RPAREN;

{LBRACE} {
    layers.push_back(new TreeNode());
    layernum++;
    cout<<setw(5)<<left<<"in"<<"{, layernum++, layernum = "<<layernum<<endl;
    return LBRACE;
}

{RBRACE} {
    layernum--;
    cout<<setw(5)<<left<<"out"<<"{,layernum--, layernum = "<<layernum<<endl;
    return RBRACE;
}

{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    //change1
    const char*val=yytext;
    node->int_val = atoi(val);
    yylval = node;
    return INTEGER;
}

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->ch_val = yytext[1]; 
    yylval = node;
    return CHAR;
}
{STRING} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_STRING;
    const char*val=yytext;
    node->str_val=val;
    yylval = node;
    return STRING;
}

{IDENTIFIER} {//需要另起炉灶
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    TreeNode*curlayer = layers[layernum];
    while(curlayer->sibling!=nullptr){
        curlayer = curlayer->sibling;
    }
    curlayer->sibling = node;
    curlayer->sibling->sibling = nullptr;
    return IDENTIFIER;
}

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%