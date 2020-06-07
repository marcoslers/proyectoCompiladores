#ifndef Y_TAB_H
#define Y_TAB_H
typedef union {
   int pos;
   int ival;
   string sval;
} YYSTYPE;
#define	REGRESA			258
#define	DEF				259
#define	DESPLIEGA		260
#define	SI 				261
#define OTRO       		262
#define MIENTRAS      	263
extern YYSTYPE yylval;
#endif


