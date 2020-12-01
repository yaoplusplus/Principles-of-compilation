#include "common.h"
enum var_type{
    var_int,
    var_char,
    var_bool,
    var_string
};
struct variable{
    public:
    var_type type;
    int int_value;
    char char_value;
    bool bool_value;
    string str_value;

    string var_name;
    variable(var_type type,string var_name){
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