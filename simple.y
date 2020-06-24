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
%left '='
%left '*' '/'
%left '+' '-'
     
/* A continuación la gramática */
                                 

%%

program: inicio   

inicio: sumidc funci menu | sumidc menu  | funci menu | menu;
funci: DEF ID '(' ID ')' ':' ID '{' expresiones '}';
expresiones: sumidc senten REGRESA reg';';
reg: sumid | exp;
sumidc: sumid ';' | sumid ';' sumidc;
sumid: ID | sumid '+' sumid | sumid '=' sumid | sumid '-' sumid | sumid '*' sumid | sumid '/' sumid
            | sumid '+' ENTERO | sumid '=' ENTERO | sumid '-' ENTERO | sumid '*' ENTERO | sumid '/' ENTERO
            | ENTERO '+' ENTERO | ENTERO '=' ENTERO | ENTERO '-' ENTERO | ENTERO '*' ENTERO | ENTERO '/' ENTERO
            | ENTERO '+' sumid | ENTERO '=' sumid | ENTERO '-' sumid | ENTERO '*' sumid | ENTERO '/' sumid
exp: ENTERO | exp '+' exp | exp '-' exp | exp '*' exp | exp '/' exp;
evaluar: ope | evaluar AND evaluar | evaluar OR evaluar;
ope: ID MAYOR ENTERO | ID MENOR ENTERO | ID IGUAL ENTERO | ID DIFERENTE ENTERO | ID MENORIG ENTERO | ID MAYORIG ENTERO | 
    ENTERO MAYOR ID | ENTERO MENOR ID | ENTERO IGUAL ID | ENTERO DIFERENTE ID | ENTERO MENORIG ID | ENTERO MAYORIG ID |
    ID MAYOR ID | ID MENOR ID | ID IGUAL ID | ID DIFERENTE ID | ID MENORIG ID | ID MAYORIG ID; 
senten: ssimple | ssimple senten;
ssimple: SI evaluar | SI evaluar REGRESA reg ';' | SI evaluar sumidc REGRESA reg ';' |  SI evaluar mient REGRESA reg ';'
        | SI evaluar sumidc mient REGRESA reg ';' | SI evaluar REGRESA reg ';' OTRO mient | SI evaluar REGRESA reg ';' OTRO sumidc 
        | mient;
mient: MIENTRAS  '(' ope ')' '{' sumidc '}' | MIENTRAS  '(' ope ')' '{' senten '}' | MIENTRAS  '(' ope ')' '{' sumidc senten '}';
menu:'{' contenido'}';
contenido: sumidc senten prototi imp | sumidc prototi senten imp | sumidc senten  imp | imp; 
prototi: proto | proto prototi;
proto: ID '(' reg ')' ';' | ID '=' ID '(' reg ')' ';';
imp: recimp | recimp imp;
recimp:DESPLIEGA '(' CADENA ')' ';'| DESPLIEGA '(' ID ')' ';';







