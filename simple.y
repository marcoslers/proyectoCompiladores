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

%left '='
%left '*' '/'
%left '+' '-'
     
/* A continuación la gramática */
                                 

%%

program: INICIO   

INICIO: COMENTARIO SUMIDC FUNCI MENU | SUMIDC FUNCI MENU | SUMIDC MENU  | FUNCI MENU | MENU;
COMENTARIO: COMENTA;
FUNCI: DEF ID '(' ID ')' ':' ID '{' EXPRESIONES '}';
EXPRESIONES: SUMIDC SENTEN REGRESA REG';';
REG: SUMID | EXP;
SUMIDC: SUMID ';' | SUMID ';' SUMIDC;
SUMID: ID | SUMID '+' SUMID | SUMID '=' SUMID | SUMID '-' SUMID | SUMID '*' SUMID | SUMID '/' SUMID
            | SUMID '+' ENTERO | SUMID '=' ENTERO | SUMID '-' ENTERO | SUMID '*' ENTERO | SUMID '/' ENTERO
            | ENTERO '+' ENTERO | ENTERO '=' ENTERO | ENTERO '-' ENTERO | ENTERO '*' ENTERO | ENTERO '/' ENTERO
            | ENTERO '+' SUMID | ENTERO '=' SUMID | ENTERO '-' SUMID | ENTERO '*' SUMID | ENTERO '/' SUMID
EXP: ENTERO | EXP '+' EXP | EXP '-' EXP | EXP '*' EXP | EXP '/' EXP;
EVALUAR: OPE | EVALUAR AND EVALUAR | EVALUAR OR EVALUAR;
OPE: ID MAYOR ENTERO | ID MENOR ENTERO | ID IGUAL ENTERO | ID DIFERENTE ENTERO | ID MENORIG ENTERO | ID MAYORIG ENTERO | 
    ENTERO MAYOR ID | ENTERO MENOR ID | ENTERO IGUAL ID | ENTERO DIFERENTE ID | ENTERO MENORIG ID | ENTERO MAYORIG ID |
    ID MAYOR ID | ID MENOR ID | ID IGUAL ID | ID DIFERENTE ID | ID MENORIG ID | ID MAYORIG ID; 
SENTEN: SSIMPLE | SSIMPLE SENTEN;
SSIMPLE: SI EVALUAR | SI EVALUAR REGRESA REG ';' | SI EVALUAR SUMIDC REGRESA REG ';' |  SI EVALUAR MIENT REGRESA REG ';'
        | SI EVALUAR SUMIDC MIENT REGRESA REG ';' | SI EVALUAR REGRESA REG ';' OTRO MIENT | SI EVALUAR REGRESA REG ';' OTRO SUMIDC 
        | MIENT;
MIENT: MIENTRAS  '(' OPE ')' '{' SUMIDC '}' | MIENTRAS  '(' OPE ')' '{' SENTEN '}' | MIENTRAS  '(' OPE ')' '{' SUMIDC SENTEN '}';
MENU:'{' CONTENIDO '}';
CONTENIDO: SUMIDC SENTEN PROTOTI IMP | SUMIDC PROTOTI SENTEN IMP | SUMIDC SENTEN  IMP | IMP;
PROTOTI: PROTO | PROTO PROTOTI;
PROTO: ID '(' REG ')' ';' | ID '=' ID '(' REG ')' ';';
IMP: RECIMP | RECIMP IMP;
RECIMP:DESPLIEGA '(' CADENA ')' ';'| DESPLIEGA '(' ID ')' ';';







