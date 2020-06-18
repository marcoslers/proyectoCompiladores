%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"


int yylex(void); /* C necesita conocer el prototipo de la función de  */
		 /* Análisis Léxico                                    */

void yyerror(char *s)
{
  EM_error(EM_tokPos, "%s", s);
}
%}

%union{
  int pos;
   int ival;
   string sval;
   string cc;
};

%token ENTERO
%token DESPLIEGA
%nonassoc SI
%nonassoc OTRO
%nonassoc REGRESA
%token DEF
%nonassoc MIENTRAS
%nonassoc IGUAL
%nonassoc DIFERENTE
%nonassoc MAYOR
%nonassoc MENOR
%nonassoc MAYORIG
%nonassoc MENORIG
%nonassoc AND
%nonassoc OR
%token ID
%token CADENA 
%token COMENTA

%left '*' '/'
%left '+' '-'
     
/* A continuación la gramática */
                                 

%%

program: INICIO   

INICIO: COMENTARIO DEFI FUNCI | DEFI FUNCI;  
COMENTARIO: COMENTA;
DEFI: DEFINI | DEFINI DEFI;
DEFINI: ID '=' ENTERO';';
FUNCI: DEF ID '(' ID ')' ':' ID '{' EXPRESIONES '}';
EXPRESIONES: DEFI SI EVALUAR REGRESA ENTERO';' OTRO EXPREM REGRESA ID ';';
EVALUAR: OPE | EVALUAR AND EVALUAR | EVALUAR OR EVALUAR;
OPE: ID MAYOR ENTERO | ID MENOR ENTERO | ID IGUAL ENTERO | ID DIFERENTE ENTERO | ID MENORIG ENTERO | ID MAYORIG ENTERO | 
    ENTERO MAYOR ID | ENTERO MENOR ID | ENTERO IGUAL ID | ENTERO DIFERENTE ID | ENTERO MENORIG ID | ENTERO MAYORIG ID |
    ID MAYOR ID | ID MENOR ID | ID IGUAL ID | ID DIFERENTE ID | ID MENORIG ID | ID MAYORIG ID; 
EXPREM: MIENTRAS '(' OPE ')' '{' '}';





