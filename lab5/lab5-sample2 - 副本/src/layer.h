#include "common.h"
struct variable{
    public:
    Type* type; 
    int int_val;
    char ch_val;
    bool b_val;

    string str_val;

    string var_name;
    variable(Type* type,string var_name){
        this->type = type;
        this->var_name = var_name;
    };
    variable(){

    };
};
// struct variables{
//     public:
//     vector<variable*> vars;
// };
struct layer{
    public:
    vector<variable*> vars;//每一个layer有一个var数组: 
    //实际上,每一个layer应该有多个var数组
    //尝试修改这个bug,失败使用github desktop回溯版本到 before debug
    //两种方案:
    //1.将variable修改为数组,而不是单个元素.每一层有一个变量二维数组,每次进入
    //一个层级,都将符号放在一个新的var数组里(layers[i][i]).
    //2.将layers修改为二维数组.
    //
    
    layer(){
    };
};