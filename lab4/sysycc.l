%option noyywrap
%top{       
    //  Lvjianyao 2020/11/02
    //  链表实现符号表
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string.h>
using namespace std;
struct node {
    node(string data)
    {
        no = 0;     //值
        this->data=data;       //yylex
        next=NULL;
    };
    node() {
        no = 0;
        data = "unknown";
        next = NULL;
    }
    //第一个节点不计数，也不保存数据..实际上，这个做法，有点儿憨
    int no;
    string data;
    node* next;
};
//链表类
struct idlist {
    idlist(int idcount){
        this->idcount=idcount;
    };
    int idcount = 0; //表项数
    node head;
    node* add(string data) {
        node* newnode = new node(data);
        if (head.next == NULL) {
            head.next = newnode;
            head.next->no = ++idcount; //序号按进入表的顺序
            return head.next;
        }
        else {
            node* currentnode = head.next;
            while (currentnode->next != NULL) {
                currentnode = currentnode->next;
            }
            node* newnode = new node(data);
            currentnode->next = newnode;
            currentnode->next->no = ++idcount;
            return currentnode->next;       //返回末指针
        }
    }
    int search(string data) {
        node* currentnode = head.next;      //change node -node.next
        //const char* c2_s2 = data.c_str();
        while (currentnode!= NULL)
        {
            //const char* c1_s1 = (currentnode->data).c_str();
            if (data==currentnode->data)
            {
                //匹配到id则返回id序号
                
                return currentnode->no;
            }
            currentnode = currentnode->next;
        }
          node*newnode=add(data);
         
          return newnode->no; 
    }
};
idlist list(0);

}
while "while"
if  "if"
else "else"
main "main"
break "break"
int "int"
return "return"
id [_a-zA-Z][_a-zA-Z0-9]*
num [0-9]+
add \+
sub \-
mul \*
div \/
mod \%
expr =
equal ==
great_equal \>\=
great \>
less_equal \<\=
less \<
n_equal \!\=
lparen \(
rparen \)
lbrace \{
rbrace \}
semi ;
bitor \|
bitand &
or \|\|
and &&
line_anno \/\/[^\n]*
block_anno \/\*(.|\n)*?\*\/
blank [\f\n\r\t\v ]
colo \,   
word    [a-zA-Z]+
line    \n
char    .
lb  (
rb  )
commentbegin "/*"
commentelement .|\n
commentend "*/"

space   [ ]
    //hlbegin "{"


    //hlend   "}"
%x COMMENT
    //定义一个更深层
%x HIGHERLEVEL
    //规则部分
%%
{commentbegin} {BEGIN COMMENT;}
<COMMENT>{commentelement} {}
<COMMENT>{commentend} {BEGIN INITIAL;}
{while}             {cout<<setw(15)<<"WHILE"<<setw(15)<<yytext<<endl;}
{if}                {cout<<setw(15)<<"IF"<<setw(15)<<yytext<<endl;}
{else}              {cout<<setw(15)<<"ELSE"<<setw(15)<<yytext<<endl;}
{int}               {cout<<setw(15)<<"INT"<<setw(15)<<yytext<<endl;}
{main}              {cout<<setw(15)<<"MAIN"<<setw(15)<<yytext<<endl;}
{return}            {cout<<setw(15)<<"RETURN"<<setw(15)<<yytext<<endl;}
{break}             {cout<<setw(15)<<"BREAK"<<setw(15)<<yytext<<endl;}
{id}                {string s(yytext); int tid=list.search(s);cout<<right<<setw(15)<<"ID"<<setw(15)<<yytext<<setw(15)<<tid<<endl;}
{num}				{cout<<setw(15)<<"NUM"<<setw(15)<<yytext<<endl;}
{or}				{cout<<setw(15)<<"OR"<<setw(15)<<yytext<<endl;}
{and}				{cout<<setw(15)<<"AND"<<setw(15)<<yytext<<endl;}
{bitor}				{cout<<setw(15)<<"BIT_OR"<<setw(15)<<yytext<<endl;}
{bitand}			{cout<<setw(15)<<"BIT_AND"<<setw(15)<<yytext<<endl;}
{expr}				{cout<<setw(15)<<"EXPR"<<setw(15)<<yytext<<endl;}
{equal}				{cout<<setw(15)<<"EQ"<<setw(15)<<yytext<<endl;}
{great_equal}		{cout<<setw(15)<<"GREAT_EQ"<<setw(15)<<yytext<<endl;}
{great}				{cout<<setw(15)<<"GREAT"<<setw(15)<<yytext<<endl;}
{less_equal}		{cout<<setw(15)<<"LESS_EQ"<<setw(15)<<yytext<<endl;}
{less}				{cout<<setw(15)<<"LESS"<<setw(15)<<yytext<<endl;}
{n_equal}			{cout<<setw(15)<<"NEQ"<<setw(15)<<yytext<<endl;}
{add}        {cout<<setw(15)<<"ADD"<<setw(15)<<yytext<<endl;}
{sub}        {cout<<setw(15)<<"SUB"<<setw(15)<<yytext<<endl;}
{mul}        {cout<<setw(15)<<"MUL"<<setw(15)<<yytext<<endl;}
{div}        {cout<<setw(15)<<"DIV"<<setw(15)<<yytext<<endl;}
{mod}		 {cout<<setw(15)<<"MOD"<<setw(15)<<yytext<<endl;}
{lparen}	{cout<<setw(15)<<"LPAREN"<<setw(15)<<yytext<<endl;}
{rparen} 	{cout<<setw(15)<<"RPAREN"<<setw(15)<<yytext<<endl;}
{lbrace} 	{cout<<setw(15)<<"LBRACE"<<setw(15)<<yytext<<endl;}
{rbrace}	{cout<<setw(15)<<"RBRACE"<<setw(15)<<yytext<<endl;}
";"           {cout<<setw(15)<<"SEMICOLON\t"<<setw(15)<<yytext<<endl;}
{colo}		{cout<<setw(15)<<"COLOMN"<<setw(15)<<yytext<<endl;}

{line_anno} {}
{block_anno} {}
{blank} {}
%%

    //用户子例程
int main(){

yyFlexLexer lexer;
cout<<setw(15)<<"token"<<setw(15)<<"lexeme"<<setw(15)<<"value"<<endl;
lexer.yylex();
return 0;
}
