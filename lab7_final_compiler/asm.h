#pragma once
#include<iostream>
#include<string>
#include<vector>
#include"tree.h"
using namespace std;
class rodata{
private:
    vector<string> _rodata;
public:
    vector<string> _bss;
    void output();
    void push_back(string str);
    int size();
};
class function{
private:
    int funcType;
    bool buf;
    // 保存汇编信息
    vector<string> asmcode;
    vector<string> codebuf;
    string name;
    int ret;
public:
    function(int _funcType, string _name);
    void set(int _funcType, string _name);
    void setret(int ret);
    void output();
    void addAsmcode(string _code);
    string delCode();
    void resetCode(string _code);
};