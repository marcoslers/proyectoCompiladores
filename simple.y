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

inicio: funcion_recurs_asignacion funcion_recurs menu 
        | funcion_recurs menu 
        | menu
        ;
        
funcion_recurs_asignacion:recursivo_asignacion 
        | recursivo_asignacion funcion_recurs_asignacion
        ;

recursivo_asignacion: ID '=' exp ';';

exp: ENTERO
    | ID 
    |exp '*' exp 
    | exp '-' exp 
    | exp '/' exp 
    | exp '+' exp
    |exp IGUAL exp
    | exp DIFERENTE exp 
    | exp MAYOR exp 
    | exp MENOR exp 
    | exp MAYORIG exp 
    | exp MENORIG exp
    ;

funcion_recurs: seccion_funciones 
        | seccion_funciones funcion_recurs
        ;

seccion_funciones: DEF ID '(' ID ')' ':' ID '{' instrucciones REGRESA exp ';' '}' 
        | DEF ID '(' ID ')' ':' ID '{'funcion_recurs_asignacion REGRESA exp ';' '}'
        ;
        
instrucciones: funcion_recurs_asignacion recurs_sentencias 
        | recurs_sentencias
        ;
        
recurs_sentencias: recursivo_sentencia 
        | recursivo_sentencia recurs_sentencias
        ;

recursivo_sentencia: SI '(' funcion_evaluacion')' '{' instrucciones '}' 
        | SI '(' funcion_evaluacion')' '{' instrucciones REGRESA exp';' '}' 
        | SI '(' funcion_evaluacion')' '{' REGRESA exp';' '}' 
        | SI '(' funcion_evaluacion')' '{' funcion_recurs_asignacion '}' 
        | OTRO '{' funcion_recurs_asignacion '}' 
        | OTRO '{' instrucciones '}' 
        | MIENTRAS '(' funcion_evaluacion ')' '{' instrucciones '}' 
        | MIENTRAS '(' funcion_evaluacion ')' '{' funcion_recurs_asignacion'}'
        ;
        
funcion_evaluacion: recusivo_evaluacion 
        | recusivo_evaluacion funcion_evaluacion
        ;
        
recusivo_evaluacion: exp 
        | exp AND exp 
        | exp AND exp AND 
        | exp AND exp OR 
        | exp OR exp 
        | exp OR exp OR 
        | exp OR exp AND
        ;
        
menu:'{' contendio_menu '}'
        ;

contendio_menu: recursivo_asignacion funcion_recurs_prototipo recurs_sentencias funcion_recurs_imprimir
                | recursivo_asignacion recurs_sentencias funcion_recurs_prototipo funcion_recurs_imprimir
                | recursivo_asignacion funcion_recurs_prototipo funcion_recurs_imprimir
                | recursivo_asignacion recurs_sentencias funcion_recurs_imprimir
                | recursivo_asignacion funcion_recurs_imprimir
                | funcion_recurs_imprimir
                ;
                
funcion_recurs_prototipo: recursivo_prototipo 
                | recursivo_prototipo funcion_recurs_prototipo
                ;
                
recursivo_prototipo: ID '=' ID'(' exp ')' ';'
                ;
                
funcion_recurs_imprimir: imprimir 
                | imprimir funcion_recurs_imprimir
                ;
                
imprimir: DESPLIEGA '(' CADENA ')' ';' 
                | DESPLIEGA '(' ID ')' ';'
                ;





