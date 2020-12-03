/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_MAIN_TAB_H_INCLUDED
# define YY_YY_SRC_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    WHILE = 260,
    FOR = 261,
    PRINTF = 262,
    SCANF = 263,
    TRUE = 264,
    FALSE = 265,
    T_CHAR = 266,
    T_INT = 267,
    T_STRING = 268,
    T_BOOL = 269,
    T_VOID = 270,
    IDENTIFIER = 271,
    IDADDR = 272,
    INTEGER = 273,
    CHAR = 274,
    BOOL = 275,
    STRING = 276,
    VOID = 277,
    MAIN = 278,
    SEMICOLON = 279,
    COMMA = 280,
    DQUOTATION = 281,
    LBRACE = 282,
    RBRACE = 283,
    LPAREN = 284,
    RPAREN = 285,
    LOP_ASSIGN = 286,
    TAKEADDR = 287,
    ADD = 288,
    MINUS = 289,
    MUL = 290,
    DIV = 291,
    MOD = 292,
    SELFADD = 293,
    SELFMIN = 294,
    NEG = 295,
    LOG_AND = 296,
    LOG_OR = 297,
    LESSTHAN = 298,
    MORETHAN = 299,
    LESSTHANEQ = 300,
    MORETHANEQ = 301,
    MINASSIGN = 302,
    ADDASSIGN = 303,
    LOP_EQ = 304,
    NOT = 305,
    UMINUS = 306,
    LOWER_THEN_ELSE = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_MAIN_TAB_H_INCLUDED  */
