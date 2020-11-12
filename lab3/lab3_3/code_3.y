%{
/*************************
code_3.y
YACC file
Date: 2020/10/19
Jianyao Lv <1811400>
*************************/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif 
char idStr[50];
char numStr[50];
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s );
%}

%token NUMBER
%token ID
%token ADD
%token MINUS
%token MUL
%token DIV
%token UMINUS
%token LBRACKET RBRACKET

%left ADD MINUS
%left MUL DIV
%right UMINUS 


%%


lines   :   lines expr '\n' { printf("%s\n", $2); }
        |   lines '\n'
        |
        ;

expr    :   expr ADD expr { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1);strcat($$,$3); strcat($$,"+");} /* malloc 动态分配内存*/
            
        |   expr MINUS expr { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1);strcat($$,$3); strcat($$,"- ");}
            
        |    NUMBER        { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1); strcat($$," ");} //实际上也只有$1

        |   ID            { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1);strcat($$," ");}
        |   UMINUS        {

        }

        |   expr MUL expr { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1);strcat($$,$3); strcat($$,"* ");
        }

        |   expr DIV expr { $$ = (char*)malloc(50*sizeof(char));
            strcpy($$,$1);strcat($$,$3); strcat($$,"/ ");
        }

        |   MINUS expr %prec UMINUS { $$ = (char*)malloc(50*sizeof(char));
            $$ = strcpy($$,$2); $$ =strcat($$,"- "); }
        ;

        |   LBRACKET expr RBRACKET { $$ = (char*)malloc(50*sizeof(char));
            $$ = strcpy($$,$2);
        }
        

%%


int yylex()
{ 
    int t;
    while(1){
        t = getchar();
       if (t == ' ' || t == '\t') {
            ;
        }
        else if ((t<='9'&&t>='0')){
            int ti=0;
            while((t<='9'&&t>='0'))
            {
                numStr[ti]=t; //数字暂存
                t=getchar();
                ti++;
            }
            numStr[ti]='\0';
            yylval=numStr;
            ungetc(t,stdin);
            return NUMBER; //返回给NUMBER进行处理
        }
        else if ((t>='a'&& t<='z')||(t>='A'&& t<='Z')||(t=='_')){
            int ti=0;
            while((t>='a'&& t<='z')||(t>='A'&& t<='Z')||(t=='_')
            ||(t>='0' && t<='9'))
            {
            idStr[ti]=t;
            t=getchar();
            ti++;
            }
            idStr[ti]='\0';
            yylval=idStr;
            ungetc(t,stdin);
            return ID;
        }
        else if (t == '+'){
            return ADD;
        }
        else if (t == '-'){
            return MINUS;
        }
        else if(t == '*'){
            return MUL; 
        }
        else if(t == '/'){
            return DIV; 

        }
        else if(t == '('){
            return LBRACKET; 

        }
         else if(t == ')'){
            return RBRACKET; 
        }
        else{
            return t;
        }
    }
    // place your token retrieving code here
    return getchar ();
}

int main(void)
{
    yyin = stdin ; 
    do {
            yyparse();
    } while (! feof(yyin)); 
    return 0;
}
void yyerror(const char* s) { 
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}
