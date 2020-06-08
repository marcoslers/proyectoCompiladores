#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "y.tab.h"

YYSTYPE yylval;

int yylex(void); /* prototipo de la función de análisis léxico generada por flex */

string tokname(int tok);
/*char *tokname(inmt*/

string toknames[] = {"REGRESA", "DEF", "DESPLIEGA","SI","OTRO",
                     "MIENTRAS","ASIGNA","IGUAL","DIFERENTE","MAYOR",
                     "MENOR","MAYORIG","MENORIG","AND","OR","ID","ENTERO",
                     "CADENA"};


string tokname(int tok) {
  return tok<258 || tok>299 ? "TOKEN NO VALIDO" : toknames[tok-258];
}

int main(int argc, char **argv) {
 string fname; int tok;
 if (argc!=2) {fprintf(stderr,"uso: driver archivo.simple\n"); exit(1);}
 fname=argv[1];
 EM_reset(fname);
 for(;;) {
   tok=yylex();
   if (tok==0) break;
   else if(tok<=255)
     printf("%c \n",tok);
     else
       switch(tok) {
          //case CADE:
         case ID: 
           printf("%10s %s\n",tokname(tok),yylval.sval);
           break;
         case ENTERO:
           printf("%10s %d\n",tokname(tok),yylval.ival);
           break;
         default:
           printf("%10s\n",tokname(tok));
       }
 }
 return 0;

}
