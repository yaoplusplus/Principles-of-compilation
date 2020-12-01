#include "common.h"
#include <fstream>

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

    cout<<"the num of the layers: "<<layers.size()<<endl;
    for(int i=0;i<layers.size();i++){
        cout<<"layernum: "<<i<<" addr: "<<layers[i];
        if(layers[i]->vars.size()!=0)
        cout<<" vars: ";
            for(int j=0;j<layers[i]->vars.size();j++){
                cout<<layers[i]->vars[j]->var_name<<" ";
            }
        cout<<endl;
    }
    return 0;
}