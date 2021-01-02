#include "common.h"
struct variable{
    public:
    Type* type; 
    string var_name;
    int int_val;
    char ch_val;
    bool b_val;
    string str_val;

    variable(){
        var_name ="";
    };
    variable(Type* type,string var_name){
        this->type = type;
        this->var_name = var_name;
    };
    variable(Type* type,string var_name,int value){
        this->type = type;
        this->var_name = var_name;
        this->int_val = value;
    };
    variable(Type* type,string var_name,char value){
        this->type = type;
        this->var_name = var_name;
        this->ch_val = value;
    };
    variable(Type* type,string var_name,bool value){
        this->type = type;
        this->var_name = var_name;
        this->b_val = value;
    };
    variable(Type* type,string var_name,string value){
        this->type = type;
        this->var_name = var_name;
        this->str_val = value;
    };
};
// struct variables{
//     public:
//     vector<variable*> vars;
// };
struct variables{
vector<variable*>vars;
variables(){
    //初始化一个，方便第一次加
    // vars.push_back(new variable());
}
};
struct layer{
    public:
    vector<variables*> lvars;
    layer(){
        // lvars.push_back(new variables());
    };
    void printlayer(){
        int lvars_size = lvars.size();
        // cout<<"total lvars num: "<<lvars_size<<endl;
    for(int i=0;i<lvars_size;i++){
            if(lvars[i]->vars.size()!=0){
                cout<<"current lvar: "<<i+1<<endl;
                int vars_size = lvars[i]->vars.size();
                for(int j=0;j<vars_size;j++){
                    variable* curvar = this->lvars[i]->vars[j];
                    switch(curvar->type->type){

                        case VALUE_STRING:
                            cout<<setw(10)<<left<<"string"<<setw(10)<<curvar->var_name
                            <<setw(10)<<curvar->str_val<<endl;
                            break;

                        case VALUE_INT:
                            cout<<setw(10)<<left<<"int"<<setw(10)<<curvar->var_name
                            <<setw(10)<<curvar->int_val<<endl;
                            break;

                        case VALUE_CHAR:
                            cout<<setw(10)<<left<<"char"<<setw(10)<<curvar->var_name
                            <<setw(10)<<curvar->ch_val<<endl;
                            break;
                    
                        case VALUE_BOOL:
                            cout<<setw(10)<<left<<"bool"<<setw(10)<<curvar->var_name
                            <<setw(10)<<curvar->b_val<<endl;
                            break;
                        default:
                            break;
                    }
                }
                cout<<endl;
            }
    }
    cout<<"-------------------------------------";
    }
};
