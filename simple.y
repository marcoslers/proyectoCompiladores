%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"


int yylex(void); /* C necesita conocer el prototipo de la funci�n de  */
		 /* An�lisis L�xico                                    */

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
%token  DESPLIEGA
%nonassoc  SI
%nonassoc  OTRO

%left '*' '/'
%left '+' '-'

        
/* A continuaci�n la gram�tica */
                                 
%%

program:    sent

sent:   DESPLIEGA '(' exp ')'
    | SI '(' exp ')' sent %prec SI
    | SI '(' exp ')' sent OTRO sent
    |exp ';'
    ;
    
exp: ENTERO
    | exp '-' exp 
    | exp '*' exp
    | exp '+' exp
    | exp '/' exp
    ;

