#include "common.h"
#include <fstream>

extern TreeNode *root;
extern FILE *yyin;
extern int yyparse();
extern vector<TreeNode*> layers;
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
    //遍历
    // for(int i=0;i<layers.size();i++){
    //     if(layers[i]->layerflag == 0)
    //     i = i + 1;
    //     else{
    //         cout<<"layernum: "<<i<<" var_name: "<<layers[i]->var_name<<endl;
    //         TreeNode*curlayer = layers[i];
    //         while(curlayer->layerflag!=0)
    //         {
    //             cout<<"layernum: "<<i<<" var_name: "<<curlayer->var_name<<endl;
    //             curlayer = curlayer->sibling;
    //         }
    //     }
    // }
    // cout<<"layernum: "<<0<<" var_name: "<<layers[0]->var_name<<endl;
    // cout<<"layernum: "<<0<<" var_name: "<<layers[0]->sibling->var_name<<endl;
    // cout<<"layernum: "<<0<<" var_name: "<<layers[0]->sibling->sibling->var_name<<endl;
    // cout<<"layernum: "<<1<<" var_name: "<<layers[1]->var_name<<endl;
    // cout<<"layernum: "<<1<<" var_name: "<<layers[1]->sibling->var_name<<endl;
    // cout<<"layernum: "<<1<<" var_name: "<<layers[1]->sibling->sibling->var_name<<endl;
    

    return 0;
}