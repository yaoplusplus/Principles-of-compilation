#include "tree.h"
void TreeNode::addChild(TreeNode* child) {
    if (this->child == nullptr) {
        this->child = child;
    }
    else {
        this->child->addSibling(child);
    }
}

void TreeNode::addSibling(TreeNode* sibling) {
    TreeNode* currentsib = this->sibling;
    if (currentsib == nullptr)
        this->sibling = sibling;
    else {
        while (currentsib->sibling != nullptr) {

            currentsib = currentsib->sibling;
        }
        currentsib->sibling = sibling;
    }
}

TreeNode::TreeNode(int lineno, NodeType type) {
    this->lineno = lineno;
    this->nodeType = type;
    this->nodeID = nodecount++; //先不管
}
TreeNode::TreeNode() {
    this->lineno = lineno;
    this->nodeID = nodecount++;
}

void TreeNode::genNodeId() {//按行遍历
    // if (this == nullptr)
    //     return;
    // this->printNodeInfo();
    // this->child->printAST();
    // this->sibling->printAST();
}

void TreeNode::printNodeInfo() {
    if (this == nullptr)
        return;
    switch (this->nodeType) {
        case NODE_PROG:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " program";
            this->printChildrenId();
            cout << endl;
            break;
        case NODE_CONST:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " const type: ";
            switch(this->type->type){

                case VALUE_STRING:
                    cout<<this->str_val<<endl;
                    break;

                case VALUE_INT:
                    cout<<this->int_val<<endl;
                    break;

                case VALUE_CHAR:
                    cout<<this->ch_val<<endl;
                    break;
            
                case VALUE_BOOL:
                    cout<<this->b_val<<endl;
                    break;
                default:
                    break;
            }
            break;

        case NODE_VAR:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " variable varname: " << this->var_name;
            cout << endl;
            break;

        case NODE_EXPR:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " expression";
            this->printChildrenId();
            cout<<" expr:"<<this->opType2String(this->optype)<<endl;
            break;

        case NODE_STMT:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " " << "statement";
            this->printChildrenId();
            //print statement type
            std::cout << " stmt:" << this->sType2String(this->stype);
            cout << endl;
            break;

        case NODE_TYPE:
            std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
                << " type type:" << this->type->getTypeInfo();
            cout << endl;
            break;

        default:
            break;
    }
}

void TreeNode::printChildrenId() {
    if (this->child == nullptr)
        return;
    //child
    else {
        std::cout << " children: [";
        std::cout << this->child->nodeID << " ";
        if (this->child->sibling == nullptr){
            cout << " ]";
            return;
        }
        //sibling
        else {
            std::cout << this->child->sibling->nodeID << " ";
            TreeNode* currentsib = this->child->sibling->sibling;
            while (currentsib != nullptr)
            {
                std::cout << currentsib->nodeID << " ";
                currentsib = currentsib->sibling;
            }
        }
        std::cout << " ]";
    }
    return;
}

void TreeNode::printAST() {// father first
    if (this == nullptr)
        return;
    this->printNodeInfo();
    this->child->printAST();
    this->sibling->printAST();
}

// You can output more info...
void TreeNode::printSpecialInfo() {
    switch (this->nodeType) {
    case NODE_CONST:
        break;
    case NODE_VAR:
        break;
    case NODE_EXPR:
        break;
    case NODE_STMT:
        break;
    case NODE_TYPE:
        break;
    default:
        break;
    }
}

string TreeNode::sType2String(StmtType type) {
    switch (type) {
    case STMT_SKIP:
        return"skip";
        break;
    case STMT_DECL:
        return "decl";
        break;
    case STMT_ASSIGN:
        return "assign";
        break;
    case STMT_WHILE:
        return "while";
        break;
    case STMT_IF:
        return "if";
        break;
    case STMT_SCANF:
        return "scanf";
        break;
    case STMT_PRINTF:
        return "printf";
        break;
    case STMT_FOR:
        return "for";
        break;
    default:
        break;
    }
    return "?";
}

string TreeNode::nodeType2String(NodeType type) {
    switch (type) {
    case NODE_CONST:
        return"const";
        break;
    case NODE_VAR:
        return "variable";
        break;
    case NODE_EXPR:
        return "expression";
        break;
    case NODE_TYPE:
        return "type";
        break;
    case NODE_STMT:
        return "statement";
        break;
    case NODE_PROG:
        return "program";
        break;
    default:
        return"block";
        break;
    }
}
string TreeNode::opType2String(OperatorType type) {
    switch (type) {
    case OP_ADD:
        return"add";
        break;
    case OP_MINUS:
        return "minus";
        break;
    case OP_MUL:
        return "mul";
        break;
    case OP_DIV:
        return "div";
        break;
    case OP_EQ:
        return "bool_eq";
        break;
    case OP_UMINUS:
        return "uminus";
        break;
    case OP_MOD:
        return "mod";
        break;
    case OP_TAKEADDR:
        return "take_addr";
        break;
    case OP_SELFADD:
        return "selfadd";
        break;
    case OP_SELFMIN:
        return "selfmin";
        break;
    case OP_LOG_AND:
        return "log_and";
        break;
    case OP_LOG_OR:
        return "log_or";
        break;
    case OP_COMP:
        return "comp";
        break;
    case OP_NOT:
        return "not";
        break;
    default:
        return"?";
        break;
    }
}

