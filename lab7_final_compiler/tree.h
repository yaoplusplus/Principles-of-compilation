#pragma once
#include<vector>
#include<string>
using namespace std;
enum NodeType
{
    NODE_PROG,
    NODE_STMT,
    NODE_OP,
    NODE_TYPE,
    NODE_BOOL,
    NODE_CONINT,
    NODE_CONCHAR,
    NODE_CONSTR,
    NODE_FEXPR,
    NODE_WEXPR,
    NODE_VAR,
    NODE_FUNC,
    NODE_ASSIGN,
    NODE_STRDEF
};
enum OPType
{
    OP_ADD, OP_MINUS, OP_MULTI, OP_DIV, OP_MOD,
    OP_SADD, OP_SMIN, OP_UMIN,
    OP_NOT, OP_AND, OP_OR,
    OP_EQ, OP_LT, OP_LE, OP_BT, OP_BE, OP_NE
};
enum STMTType
{
    STMT_IF,
    STMT_WHILE,
    STMT_FOR,
    STMT_DECL,
    STMT_ASSIGN,
    STMT_PRINTF,
    STMT_SCANF
};
enum VarType
{
    VAR_VOID,
    VAR_BOOLEAN,
    VAR_INTEGER,
    VAR_CHAR,
    VAR_STR
};
enum VarFlag
{
    VAR_COMMON,
    VAR_ADDRESS,
    VAR_POINTER
};
static int NodeId = 0;
class TreeNode
{
public:
    TreeNode(int NodeType);
    void addChild(TreeNode *child);     
    void addSibling(TreeNode *sibling); 
    void genNodeId();                   
    void printAST();                                       
    TreeNode *getChild(int index);      
    int childNum();
    int nodetype, nodeId;
    int optype, stype;
    int vartype, int_val, varflag;
    bool bool_val;
    string str_val;
    string var_name;                     // 属性，看你心情
private:
    vector<TreeNode *> CHILDREN;        // 孩子
    vector<TreeNode *> SIBLING;         // 兄弟
                                        // 因为左孩子右兄弟结构太麻烦了而且容易出错，所以干脆这么玩
};