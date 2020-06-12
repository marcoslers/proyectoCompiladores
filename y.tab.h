#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    ENTERO = 258,
    DESPLIEGA = 259,
    SI = 260,
    OTRO = 261,
    REGRESA	= 262,
    DEF = 263,
    MIENTRAS = 264,
    IGUAL = 265,
    DIFERENTE = 266,
    MAYOR = 267,
    MENOR = 268,
    MAYORIG = 269,
    MENORIG = 270,
    AND = 271,
    OR = 272,
    ID = 273,
    CADENA = 274
  };
#endif
/* Tokens.  */
#define ENTERO 258
#define DESPLIEGA 259
#define SI 260
#define OTRO 261
#define	REGRESA	262
#define	DEF	263
#define MIENTRAS 264
#define IGUAL 265
#define DIFERENTE 266
#define MAYOR 267
#define MENOR 268
#define MAYORIG 269
#define MENORIG 270
#define AND 271
#define OR 272
#define ID 273
#define CADENA 274


/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 24 "simple.y"

    int pos;
    int ival;
    string sval;

#line 75 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
