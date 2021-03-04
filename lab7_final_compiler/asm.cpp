#include"asm.h"
void rodata::output()
{
    {
        printf("\n\t.bss\n");
        for (vector<string>::iterator it = _bss.begin(); it != _bss.end(); it++)
        {
            printf("\t.align\t4\n%s:\n\t.zero\t4\n", (*it).c_str());
        }
        int i = 0;
        printf("\n\t.text\n\t.section\t.rodata\n");
        for (vector<string>::iterator it = _rodata.begin(); it != _rodata.end(); it++, i++)
        {
            printf("STR%d:\n\t.string \"%s\"\n", i, (*it).c_str());
        }
      
    }
}
void rodata::push_back(string str)
{
    _rodata.push_back(str);
}
int rodata::size()
{
    return _rodata.size();
}

function::function(int _funcType, string name)
{
    funcType = _funcType;
    this->name = name;
    ret = 0;
    buf = false;
}
void function::set(int _funcType, string name)
{
    funcType = _funcType;
    this->name = name;
}
void function::setret(int ret){
    this->ret = ret;
}
void function::output()
{   // 输出一些个体相同的函数汇编信息
    name = "main";
    printf("\t.text\n");
    printf("\t.globl\t%s\n", name.c_str());
    printf("\t.type\t%s, @function\n", name.c_str());

    printf("%s:\n", name.c_str());
    printf("\tpushl\t%%ebp\n");
    printf("\tmovl\t%%esp, %%ebp\n");
    for (vector<string>::iterator it = asmcode.begin(); it != asmcode.end(); it++)
    {
    //     if(*(it) == "\tpushl\t%eax\n" && *(it+1) == "\tpopl\t%eax\n")
    //     {
    //         it += 2;
    //     }
    //     if(*(it) == "\tpushl\t%ebx\n" && *(it+1) == "\tpopl\t%ebx\n")
    //     {
    //         it += 2;
    //     }
        printf("%s", (*it).c_str());
    }
    // 输出一些个体相同的函数汇编信息
    printf("\tpopl\t%%ebp\n");
    printf("\tmovl\t$%d, %%eax\n", ret);
    printf("\tret\n");
}
void function::addAsmcode(string _code)
{
    asmcode.push_back(_code);
}
string function::delCode()
{
    string str = asmcode[asmcode.size() - 1];
    asmcode.pop_back();
    return str;
}
void function::resetCode(string _code)
{
    asmcode[asmcode.size() - 1] = _code;
}