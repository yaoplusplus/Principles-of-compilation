#ifndef TREE_H
#define TREE_H

#include "pch.h"
#include "type.h"

enum NodeType
{
    NODE_CONST, 
    NODE_VAR,
    NODE_EXPR,
    NODE_TYPE, //节点的类型是类型
    NODE_STMT,
    NODE_PROG,
    NODE_FUNC,
    NODE_BOOL
};

enum OperatorType
{
    OP_EQ,     // ==
    OP_ADD,    // +
    OP_MINUS,  // -
    OP_MUL,    // \*
    OP_DIV,    // \/
    OP_MOD,
    OP_SELFADD,
    OP_SELFMIN,
    OP_NOT,
    OP_TAKEADDR,
    OP_LOG_AND,
    OP_LOG_OR,
    OP_COMP,
    OP_UMINUS //负号
};

enum StmtType {
    STMT_SKIP,// 空语句
    STMT_DECL,//声明语句
    STMT_IF, 
    STMT_WHILE,
    STMT_ASSIGN,
    STMT_SCANF,
    STMT_PRINTF,
    STMT_FOR
}
;

enum FuncType {
    FUNC_VOID
};

static int nodecount=0;

struct TreeNode {
public:
    int nodeID;  // 用于作业的序号输出
    int lineno;
    NodeType nodeType;

    TreeNode* child = nullptr;
    TreeNode* sibling = nullptr;

    void addChild(TreeNode*);
    void addSibling(TreeNode*);
    
    void printNodeInfo();
    void printChildrenId();

    void printAST(); // 先输出自己 + 孩子们的id；再依次让每个孩子输出AST。
    void printSpecialInfo();

    void genNodeId();

public:
    OperatorType optype;    // 如果是操作符节点:那么是什么操作符在此处
    Type* type;             // NODE_TYPE :bool,int,...
    StmtType stype;         //NODE_STMT 语句类型：跳转、循环、
    FuncType ftype;
    int int_val;
    char ch_val;
    bool b_val;
    string str_val;
    string var_name;        //NODE_VAR
public:
    static string nodeType2String (NodeType type);
    static string opType2String (OperatorType type);
    static string sType2String (StmtType type);

public:
    TreeNode(int lineno, NodeType type);
    TreeNode();
};

#endif