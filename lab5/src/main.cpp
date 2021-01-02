#include "common.h"
#include <fstream>
extern int layercount; 
extern TreeNode *root;
extern FILE *yyin;
extern int yyparse();
extern vector<layer*> layers;
extern int layernum;
using namespace std;
int main(int argc, char *argv[])
{
    if (argc == 2)
    {
        FILE *fin = fopen(argv[1], "r");
        if (fin != nullptr)
        {
            yyin = fin;
        }
        else
        {
            cerr << "failed to open file: " << argv[1] << endl;
        }
    }
    yyparse();
    if(root != NULL) {
        root->genNodeId();
        root->printAST();
    }
    cout<<"---------------------------------------------------"<<endl;
    // 输出符号表有效层
    cout<<"layers size:"<<layers.size()<<endl;
    
    for(int i=0; i<layers.size(); i++){
        if(layers[i]->lvars.size()!=0){
            layercount++;
        }
    }

    cout<<"total layers with value: "<<layercount<<endl;
    cout<<"-------------------------------------";
    for(int i=0; i<layers.size(); i++){
        
        if(layers[i]->lvars.size()!=0){
            cout<<"\nlayer: "<<i+1<<"\n";
            layers[i]->printlayer();
        }
    }
    return 0;
}