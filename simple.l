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

%x	comentario str

%%

" "				{adjust(); continue;}
\n       	  	{adjust(); EM_newline(); continue;}
\t              {adjust(); EM_newline(); continue;} 
,				{adjust(); return ',';}
regresa		   	{adjust(); return REGRESA;}
def 			{adjust(); return DEF;}
despliega 		{adjust(); return DESPLIEGA;}
si 				{adjust(); return SI;}
otro			{adjust(); return OTRO;}
mientras		{adjust(); return MIENTRAS;}

;				{adjust(); return ';';}			
\{				{adjust(); return '{';}
\}				{adjust(); return '}';}
=				{adjust(); return ASIGNA;}
\(				{adjust(); return '(';}
\)				{adjust(); return ')';}	
:				{adjust(); return ':';}
\+				{adjust(); return '+';}	
\-				{adjust(); return '-';}	
\*				{adjust(); return '*';}
\/				{adjust(); return '/';}
==				{adjust(); return IGUAL;}
\<\>			{adjust(); return DIFERENTE;}
\>				{adjust(); return MAYOR;}
\<				{adjust(); return MENOR;}
\>=				{adjust(); return MAYORIG;}
\<=				{adjust(); return MENORIG;}
\&				{adjust(); return AND;}
\|				{adjust(); return OR;}

[a-zA-Z_]+[a-zA-Z0-9_]*		{adjust(); yylval.sval=String(yytext); return ID;}
[0-9]+		  				{adjust(); yylval.ival=atoi(yytext); return ENTERO;}

\-+{3}						{adjust();BEGIN(comentario);};
<comentario>[^\-]*			{adjust(); continue;}		
<comentario>\-+{3}			{adjust(); BEGIN(INITIAL);};

'				{
					adjust();
					string_buf_ptr = string_buf; 
					BEGIN(str);
				}

<str>'	 		{
					adjust();
					BEGIN(INITIAL); 
					(*string_buf_ptr) = '\0';
					printf("%s\n",string_buf);
					return CADENA;
				}

<str>\n 		{	
					EM_error(EM_tokPos, "salto de linea en cadena invalido\n");
					exit(0);
				}

<str>\\[^'nt\\]*  {	
					EM_error(EM_tokPos, "secuencia de escape invalida\n");
					exit(0);
				}

<str>\\n        {	
					adjust();
					*string_buf_ptr++='\n';
				}

<str>\\t 		{
					adjust();
					*string_buf_ptr++='\t';
				}

<str>\\' 		{
					adjust();
					*string_buf_ptr++='\'';
				}	

<str>\\\\ 		{
					adjust();
					*string_buf_ptr++='\\';
				}	

<str>[^\\'\n]+	{
					adjust();
					yylval.sval=String(yytext);
					char *yptr = yytext;
					while ( *yptr )
						*string_buf_ptr++ = *yptr++;
				}

<<EOF>>       	{printf("Fin de Archivo encontrado.\n"); exit(0);}

.             	{adjust(); EM_error(EM_tokPos, "token ilegal\n");}
