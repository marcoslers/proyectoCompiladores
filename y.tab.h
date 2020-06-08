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
#define ASIGNA			264
#define IGUAL			265
#define DIFERENTE		266
#define MAYOR			267
#define MENOR           268
#define MAYORIG         269
#define MENORIG         270
#define AND             271
#define OR              272
#define ID              273
#define ENTERO          274
#define CADENA          275
extern YYSTYPE yylval;
#endif


