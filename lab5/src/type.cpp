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
string type2str(Type* type){
    switch(type->type){
        case VALUE_INT:
            return "int";
            break;
        case VALUE_CHAR:
            return "char";
            break;
        case VALUE_BOOL:
            return "bool";
            break;  
        case VALUE_STRING:
            return "string";
            break;
        case VALUE_VOID:
            return "void";
            break;
        default:
            return "?";
            break;    
        }
}
