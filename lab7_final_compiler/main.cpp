#include"main.tab.hh"
#include"common.h"
#include<iostream>
using std::cout;
using std::endl;
TreeNode *root=nullptr;
vector<layer> layers;
layer gblayer;
vector<variable> curlayer;
rodata myrodata;
//初始状态
function myfunc(0, "main");
int layernum = 0;
int main ()
{
    yyparse();
    if(root){
        root->genNodeId();
        root->printAST();
    }
}
int yyerror(char const* message)
{
  cout << message << endl;
  return -1;
}