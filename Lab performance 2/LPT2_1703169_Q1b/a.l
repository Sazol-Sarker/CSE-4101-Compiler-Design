%option noyywrap

%{
  //1703087
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "a.tab.h"
int lineno = 1;
void yyerror();
%}
delim [ \t\n]
alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]
ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
FCONST    {digit}*"."{digit}+
CCONST    (\'{print}\')
STRING    \"{print}*\"

%%
{delim} {}
"let" {return(LET);}
"as" {return(AS);}
"int" {return(INT);}
"until"  {return(UNTIL);}
"do" {return(DO);}
"loop" {return(LOOP);}
{ID}  {return(ID);}
"<" {return(LT);}
"+" {return(ADD);}
{FCONST} {return(FLOAT_NUM);}
"=" {return(EQUAL);}
{ICONST} {return(INT_NUM);}
";" {return(SEMI);}
%%

