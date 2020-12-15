/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "src/main.y" /* yacc.c:339  */

    #include "common.h"
    #define YYSTYPE TreeNode *  //此处定义了$$的类型
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
    extern int layernum;
    vector<layer*> layers(1,new layer()); //layer array

#line 77 "src/main.tab.cpp" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "main.tab.h".  */
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

/* Copy the second part of user declarations.  */

#line 181 "src/main.tab.cpp" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  45
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   310

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  53
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  16
/* YYNRULES -- Number of rules.  */
#define YYNRULES  62
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  122

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   307

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    35,    35,    38,    39,    43,    44,    45,    46,    47,
      48,    49,    50,    51,    52,    53,    57,   116,   151,   161,
     162,   166,   193,   200,   210,   218,   229,   239,   246,   255,
     263,   271,   284,   300,   303,   314,   317,   320,   323,   330,
     339,   348,   357,   366,   375,   380,   385,   393,   394,   395,
     396,   403,   410,   417,   424,   431,   438,   445,   454,   455,
     456,   457,   458
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IF", "ELSE", "WHILE", "FOR", "PRINTF",
  "SCANF", "TRUE", "FALSE", "T_CHAR", "T_INT", "T_STRING", "T_BOOL",
  "T_VOID", "IDENTIFIER", "IDADDR", "INTEGER", "CHAR", "BOOL", "STRING",
  "VOID", "MAIN", "SEMICOLON", "COMMA", "DQUOTATION", "LBRACE", "RBRACE",
  "LPAREN", "RPAREN", "LOP_ASSIGN", "TAKEADDR", "ADD", "MINUS", "MUL",
  "DIV", "MOD", "SELFADD", "SELFMIN", "NEG", "LOG_AND", "LOG_OR",
  "LESSTHAN", "MORETHAN", "LESSTHANEQ", "MORETHANEQ", "MINASSIGN",
  "ADDASSIGN", "LOP_EQ", "NOT", "UMINUS", "LOWER_THEN_ELSE", "$accept",
  "program", "statements", "statement", "declaration", "IDENTIFIERLIST",
  "assign", "if_else", "while", "printf", "scanf", "for", "bool_statment",
  "expr", "bool_expr", "T", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307
};
# endif

#define YYPACT_NINF -62

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-62)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     160,     5,     5,    15,    17,    19,   -62,   -62,   -62,   -62,
     -62,    16,   -62,   -62,   -62,   -62,   100,    24,    24,    49,
     160,   -62,   -62,    41,   -62,   -62,    42,    43,   -62,   188,
      34,    52,   160,   160,    64,    24,    24,    24,    24,    24,
     -62,   130,   -62,   -15,   -15,   -62,   -62,   -62,   -62,   -62,
     -62,    24,    24,    24,    24,    24,   -62,   -62,    38,    54,
      35,   -62,   -62,    52,   271,   165,    68,   -62,    52,   210,
     225,   271,   271,   271,   -62,    53,    53,   -15,   -15,   -15,
      24,    55,   -62,    66,   -62,   -62,    52,    52,    52,    52,
      52,    52,    52,   160,   156,    24,   -62,   -13,   -62,   195,
     160,   -62,   -34,   254,   -62,   -62,   -62,   -62,   145,   -62,
      24,   235,    57,   245,   -62,   -62,   255,   -62,   -62,   -62,
     160,   -62
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,    59,    58,    61,    60,
      62,    34,    35,    36,    37,     5,     0,     0,     0,     0,
       2,     3,     6,     0,    11,    12,     0,     0,    15,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       9,     0,    34,    44,    38,     1,     4,     7,    14,    13,
      10,     0,     0,     0,     0,     0,    45,    46,    19,     0,
       0,    47,    48,     0,    49,     0,    24,    26,     0,     0,
       0,    21,    22,    23,     8,    39,    40,    41,    42,    43,
       0,     0,    17,     0,    57,    33,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    28,     0,    31,     0,
       0,    20,    51,    52,    54,    53,    56,    55,    50,    25,
       0,     0,     0,     0,    16,    18,     0,    27,    30,    29,
       0,    32
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -62,   -62,    78,   -19,    62,   -62,   -62,   -62,   -62,   -62,
     -62,   -62,    96,     0,   -61,   -62
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    19,    20,    21,    22,    60,    23,    24,    25,    26,
      27,    28,    32,    64,    65,    30
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      29,    46,    84,    42,   112,    12,    13,    94,    14,    88,
      89,    90,    91,    66,    67,    92,    29,    43,    44,    17,
      29,    18,    46,    56,    57,   102,   103,   104,   105,   106,
     107,   108,    29,    29,    31,    69,    70,    71,    72,    73,
      42,    29,    12,    13,    34,    14,    35,    37,    36,    45,
      58,    75,    76,    77,    78,    79,    17,    59,    18,    82,
      83,    61,    62,    38,    39,    47,    48,    49,    42,    80,
      12,    13,    93,    14,   109,     6,     7,     8,     9,    10,
      99,   115,   101,    81,    17,   100,    18,   118,    53,    54,
      55,    56,    57,    29,    41,   111,    68,   113,    33,     0,
      29,   121,    63,     1,     0,     2,     3,     4,     5,     0,
     116,     6,     7,     8,     9,    10,    11,     0,    12,    13,
      29,    14,     0,     0,    15,     0,     0,    16,    40,     0,
       0,     0,    17,     1,    18,     2,     3,     4,     5,     0,
       0,     6,     7,     8,     9,    10,    11,     0,    12,    13,
       0,    14,     0,     0,    15,     0,     0,    16,    74,     0,
       0,     0,    17,     1,    18,     2,     3,     4,     5,     0,
       0,     6,     7,     8,     9,    10,    11,     0,    12,    13,
     110,    14,     0,     0,    15,     0,     0,    16,    88,    89,
      90,    91,    17,     0,    18,    85,     0,    86,    87,    88,
      89,    90,    91,     0,     0,    92,    86,    87,    88,    89,
      90,    91,    50,     0,    92,     0,     0,     0,     0,   114,
       0,    51,    52,    53,    54,    55,    56,    57,    51,    52,
      53,    54,    55,    56,    57,    95,     0,     0,     0,     0,
      96,     0,     0,    51,    52,    53,    54,    55,    56,    57,
      97,     0,     0,     0,     0,    98,     0,     0,    51,    52,
      53,    54,    55,    56,    57,   117,     0,     0,    51,    52,
      53,    54,    55,    56,    57,   119,     0,     0,    51,    52,
      53,    54,    55,    56,    57,   120,     0,     0,    51,    52,
      53,    54,    55,    56,    57,    86,     0,    88,    89,    90,
      91,     0,     0,    92,    51,    52,    53,    54,    55,    56,
      57
};

static const yytype_int8 yycheck[] =
{
       0,    20,    63,    16,    17,    18,    19,    68,    21,    43,
      44,    45,    46,    32,    33,    49,    16,    17,    18,    32,
      20,    34,    41,    38,    39,    86,    87,    88,    89,    90,
      91,    92,    32,    33,    29,    35,    36,    37,    38,    39,
      16,    41,    18,    19,    29,    21,    29,    31,    29,     0,
      16,    51,    52,    53,    54,    55,    32,    23,    34,    24,
      25,     9,    10,    47,    48,    24,    24,    24,    16,    31,
      18,    19,     4,    21,    93,    11,    12,    13,    14,    15,
      80,   100,    16,    29,    32,    30,    34,    30,    35,    36,
      37,    38,    39,    93,    16,    95,    34,    97,     2,    -1,
     100,   120,    50,     3,    -1,     5,     6,     7,     8,    -1,
     110,    11,    12,    13,    14,    15,    16,    -1,    18,    19,
     120,    21,    -1,    -1,    24,    -1,    -1,    27,    28,    -1,
      -1,    -1,    32,     3,    34,     5,     6,     7,     8,    -1,
      -1,    11,    12,    13,    14,    15,    16,    -1,    18,    19,
      -1,    21,    -1,    -1,    24,    -1,    -1,    27,    28,    -1,
      -1,    -1,    32,     3,    34,     5,     6,     7,     8,    -1,
      -1,    11,    12,    13,    14,    15,    16,    -1,    18,    19,
      24,    21,    -1,    -1,    24,    -1,    -1,    27,    43,    44,
      45,    46,    32,    -1,    34,    30,    -1,    41,    42,    43,
      44,    45,    46,    -1,    -1,    49,    41,    42,    43,    44,
      45,    46,    24,    -1,    49,    -1,    -1,    -1,    -1,    24,
      -1,    33,    34,    35,    36,    37,    38,    39,    33,    34,
      35,    36,    37,    38,    39,    25,    -1,    -1,    -1,    -1,
      30,    -1,    -1,    33,    34,    35,    36,    37,    38,    39,
      25,    -1,    -1,    -1,    -1,    30,    -1,    -1,    33,    34,
      35,    36,    37,    38,    39,    30,    -1,    -1,    33,    34,
      35,    36,    37,    38,    39,    30,    -1,    -1,    33,    34,
      35,    36,    37,    38,    39,    30,    -1,    -1,    33,    34,
      35,    36,    37,    38,    39,    41,    -1,    43,    44,    45,
      46,    -1,    -1,    49,    33,    34,    35,    36,    37,    38,
      39
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     5,     6,     7,     8,    11,    12,    13,    14,
      15,    16,    18,    19,    21,    24,    27,    32,    34,    54,
      55,    56,    57,    59,    60,    61,    62,    63,    64,    66,
      68,    29,    65,    65,    29,    29,    29,    31,    47,    48,
      28,    55,    16,    66,    66,     0,    56,    24,    24,    24,
      24,    33,    34,    35,    36,    37,    38,    39,    16,    23,
      58,     9,    10,    50,    66,    67,    56,    56,    57,    66,
      66,    66,    66,    66,    28,    66,    66,    66,    66,    66,
      31,    29,    24,    25,    67,    30,    41,    42,    43,    44,
      45,    46,    49,     4,    67,    25,    30,    25,    30,    66,
      30,    16,    67,    67,    67,    67,    67,    67,    67,    56,
      24,    66,    17,    66,    24,    56,    66,    30,    30,    30,
      30,    56
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    53,    54,    55,    55,    56,    56,    56,    56,    56,
      56,    56,    56,    56,    56,    56,    57,    57,    57,    58,
      58,    59,    59,    59,    60,    60,    61,    62,    62,    63,
      63,    63,    64,    65,    66,    66,    66,    66,    66,    66,
      66,    66,    66,    66,    66,    66,    66,    67,    67,    67,
      67,    67,    67,    67,    67,    67,    67,    67,    68,    68,
      68,    68,    68
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     1,     2,     3,     2,
       2,     1,     1,     2,     2,     1,     5,     3,     5,     1,
       3,     3,     3,     3,     3,     5,     3,     6,     4,     6,
       6,     4,     8,     3,     1,     1,     1,     1,     2,     3,
       3,     3,     3,     3,     2,     2,     2,     1,     1,     1,
       3,     3,     3,     3,     3,     3,     3,     2,     1,     1,
       1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 35 "src/main.y" /* yacc.c:1646  */
    {root = new TreeNode(0, NODE_PROG); root->addChild((yyvsp[0]));}
#line 1383 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 3:
#line 38 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[0]);}
#line 1389 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 4:
#line 39 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[-1]);(yyval)->addSibling((yyvsp[0]));}
#line 1395 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 5:
#line 43 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_STMT); (yyval)->stype = STMT_SKIP;}
#line 1401 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 6:
#line 44 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[0]);}
#line 1407 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 7:
#line 45 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-1]);}
#line 1413 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 8:
#line 46 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-1]);}
#line 1419 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 9:
#line 47 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_STMT); (yyval)->stype = STMT_SKIP;}
#line 1425 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 10:
#line 48 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-1]);}
#line 1431 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 11:
#line 49 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[0]);}
#line 1437 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 12:
#line 50 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[0]);}
#line 1443 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 13:
#line 51 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-1]);}
#line 1449 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 14:
#line 52 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-1]);}
#line 1455 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 15:
#line 53 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[0]);}
#line 1461 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 16:
#line 57 "src/main.y" /* yacc.c:1646  */
    {// declare and init
        TreeNode* node = new TreeNode((yyvsp[-4])->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild((yyvsp[-4]));
        node->addChild((yyvsp[-3]));
        node->addChild((yyvsp[-1]));
        layer* curlayer = layers[layernum];
        if(curlayer->vars.size()==0){
        curlayer->vars.push_back(new variable());
        curlayer->vars[0]->var_name = (yyvsp[-3])->var_name;
        curlayer->vars[0]->type = (yyvsp[-4])->type;
        // cout<< $1->type->type <<endl; $1->type->type = 1 (VALUE_INT)
        if((yyvsp[-4])->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curlayer->vars[0]->int_val = (yyvsp[-1])->int_val;
                //cout<< curlayer->vars[0]->int_val<<endl;
                }
        else if((yyvsp[-4])->type->type == VALUE_CHAR){
                curlayer->vars[0]->ch_val = (yyvsp[-1])->ch_val;
                }
        else if((yyvsp[-4])->type->type == VALUE_STRING){
                curlayer->vars[0]->str_val = (yyvsp[-1])->str_val;
                }
        else if((yyvsp[-4])->type->type == VALUE_BOOL){
                curlayer->vars[0]->b_val = (yyvsp[-1])->b_val;
                }      
        }
    else{
        int size = curlayer->vars.size();
        int preflag = 0;
        for(int i=0; i<size; i++){
            if(curlayer->vars[i]->var_name == (yyvsp[-3])->var_name){
                preflag = 1;
                cout<<"IDENTIFIER "<< (yyvsp[-3])->var_name <<" is still declared"<<endl;
            }
        }
        if(preflag!=1){
            curlayer->vars.push_back(new variable());
            curlayer->vars.back()->var_name = (yyvsp[-3])->var_name;
            curlayer->vars.back()->type = (yyvsp[-4])->type;
            if((yyvsp[-4])->type->type == VALUE_INT){
                //cout<<"it's int"<<endl;
                curlayer->vars.back()->int_val = (yyvsp[-1])->int_val;
                //cout<< curlayer->vars.back()->int_val<<endl;
                }
        else if((yyvsp[-4])->type->type == VALUE_CHAR){
                curlayer->vars.back()->ch_val = (yyvsp[-1])->ch_val;
                }
        else if((yyvsp[-4])->type->type == VALUE_STRING){
                curlayer->vars.back()->str_val = (yyvsp[-1])->str_val;
                }
        else if((yyvsp[-4])->type->type == VALUE_BOOL){
                cout<<"it's bool"<<endl;
                curlayer->vars.back()->b_val = (yyvsp[-1])->b_val;
                }
        }
    }
        (yyval) = node;   
}
#line 1525 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 17:
#line 116 "src/main.y" /* yacc.c:1646  */
    {// declare
        TreeNode* node = new TreeNode((yyvsp[-2])->lineno, NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[-1]));
        //添加的ID 包括$2 (IDENTIFIERLIST) 的兄弟
        //$2指向当前大哥 :即第一个声明的ID
        TreeNode* curid = (yyvsp[-1]);
        while(curid != nullptr){
                
                layer* curlayer = layers[layernum];
                if(curlayer->vars.size()==0){
                        curlayer->vars.push_back(new variable());
                        curlayer->vars[0]->var_name = curid->var_name;
                        curlayer->vars[0]->type = (yyvsp[-2])->type;
                }
                else{
                        int size = curlayer->vars.size();
                        int preflag = 0;
                        for(int i=0; i<size; i++){
                                if(curlayer->vars[i]->var_name == curid->var_name){
                                        preflag = 1;
                                        cout<<"IDENTIFIER "<< (yyvsp[-1])->var_name <<" is still declared"<<endl; 
                                }
                        }
                        if(preflag!=1){
                                curlayer->vars.push_back(new variable());
                                curlayer->vars.back()->var_name = curid->var_name;
                                curlayer->vars.back()->type = (yyvsp[-2])->type;
                        }
                }
                curid = curid->sibling;
        }
        (yyval) = node;   
}
#line 1565 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 18:
#line 151 "src/main.y" /* yacc.c:1646  */
    { //TODO bug
        TreeNode* node = new TreeNode((yyvsp[-4])->lineno,NODE_STMT);
        node->stype = STMT_DECL;
        node->addChild((yyvsp[-4]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1577 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 19:
#line 161 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[0]);}
#line 1583 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 20:
#line 162 "src/main.y" /* yacc.c:1646  */
    {(yyval) = (yyvsp[-2]); (yyval)->addSibling((yyvsp[0]));}
#line 1589 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 21:
#line 166 "src/main.y" /* yacc.c:1646  */
    {//update the IDTABLE
        TreeNode* node = new TreeNode((yyvsp[-2])->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        //搜索ID 在当前层符号表中
        layer* curlayer = layers[layernum];
        int size = curlayer->vars.size();
        //遍历当前层变量
        for(int i=0; i<size; i++){
                if(curlayer->vars[i]->var_name == (yyvsp[-2])->var_name){
                                if(curlayer->vars[i]->type->type == VALUE_INT){
                                curlayer->vars[i]->int_val = (yyvsp[0])->int_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_CHAR){
                                curlayer->vars[i]->ch_val = (yyvsp[0])->ch_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_STRING){
                                curlayer->vars[i]->str_val = (yyvsp[0])->str_val;
                                }
                                else if(curlayer->vars[i]->type->type == VALUE_BOOL){
                                curlayer->vars[i]->b_val = (yyvsp[0])->b_val;
                                }
                        }
                        }
        (yyval) = node;
}
#line 1621 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 22:
#line 193 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode* node = new TreeNode((yyvsp[-2])->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1633 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 23:
#line 200 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode* node = new TreeNode((yyvsp[-2])->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1645 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 24:
#line 210 "src/main.y" /* yacc.c:1646  */
    { 
        //意为前句与LOWER_THEN_ELSE同优先级
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_IF;
        node->addChild((yyvsp[-1]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1658 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 25:
#line 218 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_IF;
        node->addChild((yyvsp[-3]));
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1671 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 26:
#line 229 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_WHILE;
        node->addChild((yyvsp[-1]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1683 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 27:
#line 239 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild((yyvsp[-3]));
        node->addChild((yyvsp[-1]));
        (yyval)=node;
}
#line 1695 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 28:
#line 246 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_PRINTF;
        node->addChild((yyvsp[-1]));
        (yyval)=node;
}
#line 1706 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 29:
#line 255 "src/main.y" /* yacc.c:1646  */
    {
        // cout<<"2 arg1"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild((yyvsp[-3]));
        node->addChild((yyvsp[-1]));
        (yyval)=node;
}
#line 1719 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 30:
#line 263 "src/main.y" /* yacc.c:1646  */
    {
        // cout<<"2 arg2"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_SCANF;
        node->addChild((yyvsp[-3]));
        node->addChild((yyvsp[-1]));
        (yyval)=node;
}
#line 1732 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 31:
#line 271 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        // cout<<"one arg"<<endl;
        node->stype=STMT_SCANF;
        // cout<<"one arg"<<endl;
        node->addChild((yyvsp[-1]));
        // cout<<"one arg"<<endl;
        (yyval)=node;
        
}
#line 1747 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 32:
#line 284 "src/main.y" /* yacc.c:1646  */
    {
        //cout<<"?"<<endl;
        TreeNode *node=new TreeNode(lineno,NODE_STMT);
        node->stype=STMT_FOR;
        node->addChild((yyvsp[-5]));
        node->addChild((yyvsp[-4]));
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1762 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 33:
#line 300 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[-1]);}
#line 1768 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 34:
#line 303 "src/main.y" /* yacc.c:1646  */
    {
        //expr -> IDENTIFIER 时未查找符号表,实现一个查找
        layer* curlayer = layers[layernum];
        int size = layers[layernum]->vars.size();
        for(int i = 0; i < size; i++){
                if(curlayer->vars[i]->var_name == (yyvsp[0])->var_name){
                        (yyvsp[0])->int_val = curlayer->vars[i]->int_val;
                }
        }
        (yyval) = (yyvsp[0]);
}
#line 1784 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 35:
#line 314 "src/main.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
}
#line 1792 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 36:
#line 317 "src/main.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
}
#line 1800 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 37:
#line 320 "src/main.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
}
#line 1808 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 38:
#line 323 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode* node = new TreeNode((yyvsp[-1])->lineno, NODE_EXPR);
        node->optype = OP_UMINUS;
        node->type = TYPE_INT;
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1820 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 39:
#line 330 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode* node = new TreeNode((yyvsp[-2])->lineno, NODE_EXPR);
        node->optype = OP_ADD;
        node->type = TYPE_INT;
        node->int_val = (yyvsp[-2])->int_val + (yyvsp[0])->int_val;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1834 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 40:
#line 339 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-2])->lineno,NODE_EXPR);
        node->optype = OP_MINUS;
        node->type = TYPE_INT;
        node->int_val = (yyvsp[-2])->int_val - (yyvsp[0])->int_val;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1848 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 41:
#line 348 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-2])->lineno,NODE_EXPR);
        node->optype = OP_MUL;
        node->type = TYPE_INT;
        node->int_val = (yyvsp[-2])->int_val * (yyvsp[0])->int_val;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1862 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 42:
#line 357 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-2])->lineno,NODE_EXPR);
        node->optype = OP_DIV;
        node->type = TYPE_INT;
        node->int_val = (yyvsp[-2])->int_val / (yyvsp[0])->int_val;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1876 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 43:
#line 366 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-2])->lineno,NODE_EXPR);
        node->optype = OP_MOD;
        node->type = TYPE_INT;
        node->int_val = (yyvsp[-2])->int_val % (yyvsp[0])->int_val;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval) = node;
}
#line 1890 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 44:
#line 375 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-1])->lineno,NODE_EXPR);
        node->optype = OP_TAKEADDR;
        node->addChild((yyvsp[0]));
}
#line 1900 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 45:
#line 380 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-1])->lineno,NODE_EXPR);
        node->optype = OP_SELFADD;
        node->addChild((yyvsp[-1]));
}
#line 1910 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 46:
#line 385 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode*node = new TreeNode((yyvsp[-1])->lineno,NODE_EXPR);
        node->optype = OP_SELFMIN;
        node->addChild((yyvsp[0]));        
}
#line 1920 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 47:
#line 393 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[0]);}
#line 1926 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 48:
#line 394 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[0]);}
#line 1932 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 49:
#line 395 "src/main.y" /* yacc.c:1646  */
    {(yyval)=(yyvsp[0]);}
#line 1938 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 50:
#line 396 "src/main.y" /* yacc.c:1646  */
    {// ==
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_EQ;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1950 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 51:
#line 403 "src/main.y" /* yacc.c:1646  */
    { 
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_LOG_AND;
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1962 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 52:
#line 410 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
         node->optype=OP_LOG_OR; //合起来好,还是分出来好呢?
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1974 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 53:
#line 417 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1986 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 54:
#line 424 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 1998 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 55:
#line 431 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 2010 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 56:
#line 438 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_COMP; 
        node->addChild((yyvsp[-2]));
        node->addChild((yyvsp[0]));
        (yyval)=node;
}
#line 2022 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 57:
#line 445 "src/main.y" /* yacc.c:1646  */
    {
        TreeNode *node=new TreeNode(lineno,NODE_EXPR);
        node->optype=OP_NOT;
        node->addChild((yyvsp[0]));
        (yyval)=node;        
}
#line 2033 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 58:
#line 454 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_TYPE); (yyval)->type = TYPE_INT;}
#line 2039 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 59:
#line 455 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_TYPE); (yyval)->type = TYPE_CHAR;}
#line 2045 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 60:
#line 456 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_TYPE); (yyval)->type = TYPE_BOOL;}
#line 2051 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 61:
#line 457 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_TYPE); (yyval)->type = TYPE_STRING;}
#line 2057 "src/main.tab.cpp" /* yacc.c:1646  */
    break;

  case 62:
#line 458 "src/main.y" /* yacc.c:1646  */
    {(yyval) = new TreeNode(lineno, NODE_TYPE); (yyval)->type = TYPE_VOID;}
#line 2063 "src/main.tab.cpp" /* yacc.c:1646  */
    break;


#line 2067 "src/main.tab.cpp" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 461 "src/main.y" /* yacc.c:1906  */



int yyerror(char const* message)
{

  cout << message << " at line " << lineno << endl;
  return -1;
}
