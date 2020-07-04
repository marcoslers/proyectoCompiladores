%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"


int yylex(void); /* C necesita conocer el prototipo de la funci�n de  */
                /* An�lisis L�xico                                    */

void yyerror(char *s){
  EM_error(EM_tokPos, "%s", s);
}
%}

%token  REGRESA
%token  DEF
%token  DESPLIEGA
%token  SI
%token  OTRO
%token  MIENTRAS
%token  ASIGNA
%token  IGUAL
%token  DIFERENTE
%token  MAYOR
%token  MENOR
%token  MAYORIG
%token  MENORIG
%token  AND
%token  OR 
%token  ID 
%token  ENTERO 
%token  CADENA

%token INT

%union{
  int ival;
  char *sval;
};
        
%start program

/* A continuaci�n la gram�tica */
                                 
%%

program: sent

sent: DESPLIEGA '(' exp ')'
    | SI '(' exp ')' sent %prec SI
    | SI '(' exp ')' sent OTRO sent
    ;

exp: INT
   ;

