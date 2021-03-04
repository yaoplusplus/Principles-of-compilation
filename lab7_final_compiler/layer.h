#pragma once
#include<string>
#include<vector>
using namespace std;
class variable
{
public:
    int type;
    string name;
    //变量序号
    int rodata_index;
    variable()
    {   
        //VAR_VOID
        this->type = 0;
        this->name = "";
    }
    variable(const variable& v)
    {
        this->type = v.type;
        this->name = v.name;
    }
    variable(int type, string name)
    {
        this->type = type;
        this->name = name;
    }
    variable(string name, int rodata_index)
    {
        //VAR_STR
        this->type = 4;
        this->rodata_index = rodata_index;
        this->name = name;
    }
};
class tmpvariable
{
public:
    variable v;
    int l;
    // 用变量来初始化临时变量
    tmpvariable(variable v, int l)
    {
        this->v = variable(v.type, v.name);
        this->l = l;
    }
};
class layer
{
public:
    // 变量
    vector<variable> vars;
    // 行号
    int index;
    void print()
    {
        for(int i = 0;i < vars.size();i++)
        {
            // 输出表中变量名与序号
            printf("%s  %d\n", vars[i].name.c_str(), index);
        }
    }
    layer(){

    }
    layer(vector<variable> vars, int index)
    {
        this->vars = vars;
        this->index = index;
    }
};
