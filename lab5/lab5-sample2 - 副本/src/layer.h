#include "common.h"
struct variable{
    public:
    Type* type; 
    int int_val;
    char ch_val;
    bool bool_val;
    string str_val;

    string var_name;
    variable(Type* type,string var_name){
        this->type = type;
        this->var_name = var_name;
    };
    variable(){

    };
};
struct layer{
    public:
    vector<variable*> vars;//每一个layer有一个var数组
    layer(){
    };
};