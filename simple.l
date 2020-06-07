%{
	#include <string.h>
	#include "util.h"
	#include "y.tab.h"
	#include "errormsg.h"

	int charPos=1;

	extern YYSTYPE yylval;

	int yywrap(void){
 		charPos=1;
 		return 1;
	}

	void adjust(void){
 		EM_tokPos=charPos;
 		charPos+=yyleng;
	}

	#define MAX_STR_CONST   256
	char string_buf[MAX_STR_CONST];
	char *string_buf_ptr;

%}

%%

" "				{adjust(); continue;}
\n       	  	{adjust(); EM_newline(); continue;}

regresa		   	{adjust(); return REGRESA;}
def 			{adjust(); return DEF;}
despliega 		{adjust(); return DESPLIEGA;}
si 				{adjust(); return SI;}
otro			{adjust(); return OTRO;}
mientras		{adjust(); return MIENTRAS;}

";"				{adjust(); return ';';}			
"{"				{adjust(); return '{';}
"}"				{adjust(); return '}';}
"="				{adjust(); return ASIGNA;}
"("				{adjust(); return '(';}
")"				{adjust(); return ')';}	
":"				{adjust(); return ':';}
"+"				{adjust(); return '+';}	
"-"				{adjust(); return '-';}	
"*"				{adjust(); return '*';}
"/"				{adjust(); return '/';}
==				{adjust(); return IGUAL;}
<>				{adjust(); return DIFERENTE;}
">"				{adjust(); return MAYOR;}
"<"				{adjust(); return MENOR;}
>=				{adjust(); return MAYORIG;}
<=				{adjust(); return MENORIG;}
"&"				{adjust(); return AND;}
"|"				{adjust(); return OR;}

[a-zA-Z_]+[a-zA-Z0-9_]*			  {adjust(); yylval.sval=String(yytext); return ID;}
[0-9]+		  {adjust(); yylval.ival=atoi(yytext); return ENTERO;}

<<EOF>>       {printf("\nFin de Archivo encontrado."); exit(0); }

.             {adjust(); EM_error(EM_tokPos, "token ilegal\n");}
