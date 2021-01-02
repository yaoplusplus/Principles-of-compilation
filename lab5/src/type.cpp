#include "type.h"

Type::Type(ValueType valueType) {
    this->type = valueType;
}

string Type::getTypeInfo() {
    switch(this->type) {
        case VALUE_BOOL:
            return "bool";
        case VALUE_INT:
            return "int";
        case VALUE_CHAR:
            return "char";
        case VALUE_STRING:
            return "string";
        case VALUE_VOID:
            return "void";
        default:
            cerr << "shouldn't reach here, typeinfo";
            assert(0);
    }
    return "?";
}
string printtype(Type* type){
    switch(type->type){
        case VALUE_INT:
            cout<<"int";
            break;
        case VALUE_CHAR:
            cout<<"char";
            break;
        case VALUE_BOOL:
            cout<<"bool";
            break;  
        case VALUE_STRING:
            cout<<"string";
            break;
        case VALUE_VOID:
            cout<<"void";
            break;
        default:
            cout<<"?";
            break;    
        }
}
