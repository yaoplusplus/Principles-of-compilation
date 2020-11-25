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
    this->nodeID = nodecount++;
}

void TreeNode::genNodeId() {//按行遍历

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
            << " const type: " << this->type->type;
        cout << endl;
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
        cout << endl;
        break;

    case NODE_STMT:
        std::cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " " << "statement";
        this->printChildrenId();
        //print statement type
        // std::cout << " stmt:" << this->type->type;
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
        if (this->child->sibling == nullptr)
            return;
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
}

void TreeNode::printAST() {// father first
    if (this == nullptr)
        return;
    this->printNodeInfo();
    if (this->child == nullptr)
        return;
    this->child->printAST();
    if (this->child->sibling == nullptr)
        return;
    this->child->sibling->printAST();
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
        return"<>";
        break;
    }
}

// int main() {
//     TreeNode* fa = new TreeNode(0,NODE_PROG);
//     TreeNode* child= new TreeNode(1, NODE_STMT);
//     TreeNode* sib1 = new TreeNode(2, NODE_STMT);
//     TreeNode* sib2 = new TreeNode(3, NODE_STMT);
//     fa->addChild(child);
//     fa->addChild(sib1);
//     fa->printNodeInfo();
//     fa->printAST();
//     return 0;
// }
