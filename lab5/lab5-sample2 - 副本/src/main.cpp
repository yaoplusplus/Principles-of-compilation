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

    // cout<<"the num of the layers: "<<layers.size()<<endl;
    for(int i=0;i<layers.size() &&layers[i]->vars.size()!=0;i++){
        cout<<"layernum: "<<i<<" addr: "<<layers[i];
        if(layers[i]->vars.size()!=0)
        cout<<endl;
            for(int j=0;j<layers[i]->vars.size();j++){
                cout<<" var: "<<layers[i]->vars[j]->var_name;
                if(layers[i]->vars[j]->type->type == VALUE_INT){
                    cout<<" type: int value: "<<layers[i]->vars[j]->int_val;
                }
                else if(layers[i]->vars[j]->type->type == VALUE_CHAR){
                    cout<<" type: char value: "<<layers[i]->vars[j]->ch_val;
                }
                else if(layers[i]->vars[j]->type->type == VALUE_STRING){
                    cout<<" type: string value: "<<layers[i]->vars[j]->str_val;
                }
                else if(layers[i]->vars[j]->type->type == VALUE_BOOL){
                    cout<<" type: bool value: "<<layers[i]->vars[j]->b_val;
                }
                cout<<endl;
            }
        cout<<endl;
    }
    return 0;
}