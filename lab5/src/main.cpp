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
// print the IDtable
    // cout<<"the num of the layers: "<<layers.size()<<endl;
    // for(int i=0; i<layers.size(); i++){
    //     cout<<"layernum: "<<i<<endl;
    //     if(layers[i]->vars.size()!=0){
    //         cout<<endl;
    //     }
    //     for(int j=0;j<layers[i]->vars.size();j++){
    //         if(layers[i]->vars[j]->type->type == VALUE_INT){
    //             cout<<left<<setw(10)<<"int"<<setw(10)<<layers[i]->vars[j]->var_name;
    //             cout<<left<<setw(10)<<layers[i]->vars[j]->int_val;
    //         }
    //         else if(layers[i]->vars[j]->type->type == VALUE_CHAR){
    //             cout<<left<<setw(10)<<"char"<<setw(10)<<layers[i]->vars[j]->var_name;
    //             cout<<left<<setw(10)<<layers[i]->vars[j]->int_val;
    //         }
    //         else if(layers[i]->vars[j]->type->type == VALUE_STRING){
    //             cout<<left<<setw(10)<<"string"<<setw(10)<<layers[i]->vars[j]->var_name;
    //             cout<<left<<setw(10)<<layers[i]->vars[j]->int_val;
    //         }
    //         else if(layers[i]->vars[j]->type->type == VALUE_BOOL){
    //             cout<<left<<setw(10)<<"bool"<<setw(10)<<layers[i]->vars[j]->var_name;
    //             cout<<left<<setw(10)<<layers[i]->vars[j]->int_val;
    //         }
    //         cout<<endl;
    // }
    // cout<<endl;
    // }
    
    return 0;
}