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
    vector<variables*> lvars;//每一个layer有一个var数组: 按顺序增加的
    //实际上,每一个layer应该有多个var数组
    //尝试修改这个bug,失败使用github desktop回溯版本到 'before debug'
    //两种方案:
    //1.将variable修改为数组,而不是单个元素.每一层有一个变量二维数组,每次进入
    //一个层级,都将符号放在一个新的var数组里(layers[i][i]).
    //2.将layers修改为二维数组.
    //一个layer下一个vars向量，每一个vars都有一堆variable
    layer(){
        // lvars.push_back(new variables());
    };
};