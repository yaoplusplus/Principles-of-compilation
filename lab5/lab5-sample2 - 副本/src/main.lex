%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
#include "tree.h"

int layernum = 0;
vector<TreeNode*> layers(20,nullptr); //每一层都初始化为空指针
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
    layernum++;
    cout<<"in {, layernum++, layernum = "<<layernum<<endl;
    return LBRACE;
}

{RBRACE} {
    layernum--;
    cout<<endl<<"} is in"<<endl;        //右大括号没有进来
    cout<<"out {,layernum--, layernum = "<<layernum<<endl;
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

{IDENTIFIER} {//ID保存在layers里,语法树只是指向它.
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    static int addcount = 0;

    if(layers[layernum] == nullptr)
    {
        layers[layernum] = node;
        cout<<"addcount: "<<++addcount<<" layernum: "<<layernum<<" add successfully "<<layers[layernum]->var_name<<endl;
    }
    else{
        TreeNode*curlayer=layers[layernum];
        while(curlayer->sibling!= nullptr){ //不是没初始化的
            if(curlayer->var_name == string(yytext)){
                cout<<"this add is over"<<endl;
                return IDENTIFIER;
            }
            curlayer = curlayer->sibling;
        }
        if(curlayer->var_name != node->var_name){
            curlayer->sibling= node;
            cout<<"addcount: "<<++addcount<<" layernum: "<<layernum<<" add successfully "<<curlayer->sibling->var_name<<endl;
            
        }
    }
    return IDENTIFIER;
    
}

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%