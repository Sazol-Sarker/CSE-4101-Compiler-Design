%{
    #include<stdio.h>
    #include <stdlib.h>
	#include <string.h>
    void yyerror (char *s);
    int yylex();
    extern int lineno;
%}

%token LET INT AS UNTIL DO LOOP ID LT ADD FLOAT_NUM EQUAL INT_NUM SEMI


%start prog


%%
prog: LET ID AS INT EQUAL INT_NUM SEMI DO ID EQUAL ID ADD INT_NUM LOOP UNTIL ID LT EQUAL FLOAT_NUM SEMI  {printf("parsing matched\n");}
   ;
%%

int main (){
    yyparse();
    printf("parsing finished");
    return 0;
}

 void yyerror (char *s)
 {
    printf("Syntax error at line %d\n", lineno);
 }