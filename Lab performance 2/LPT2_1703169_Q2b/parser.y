%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    #include "symtab.c"
	void yyerror();
	extern int lineno;
	extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
}

%token LET INT AS UNTIL DO LOOP ID LT ADD  EQUAL  SEMI
%token<str_val> ID
%token ICONST
%token FCONST
%type<int_val> type exp constant

%start code

%%
code: statements;

statements: statements statement | ;

statement:  declaration
           | if_statement
            ;

declaration: LET ID AS INT  EQUAL ICONST SEMI
            {
                //printf("%s\n", $2);
                //printf("%d\n", $1);
                insert($2, $4);
            }

type: INT {$$=INT_TYPE;}
    | DOUBLE {$$=REAL_TYPE;}
    | CHAR {$$=CHAR_TYPE;}
    ;

exp: constant
    {
        $$ = $1;
    }
    | ID 
      {
        if(idcheck($1))
        {
            $$ = gettype($1);
        }
      }
    | 
    {
        //printf("%d\n", $1);
        //printf("%d\n", $3);
        $$ = typecheck($1, $3);
    }
    |exp LT EQUAL exp
    {
        //printf("%d\n", $1);
        //printf("%d\n", $3);
        $$ = typecheck($1, $3);
    }
    ;

constant: ICONST {$$=INT_TYPE;}
        | FCONST {$$=REAL_TYPE;}
        ;

if_statement: DO ID {
        if(idcheck($2))
        {
            $$ = gettype($2);
        }
      }
       EQUAL ID
        {
        if(idcheck($4))
        {
            $$ = gettype($4);
        }
      }  ADD INT_NUM LOOP UNTIL
       ID
       {
        if(idcheck($6))
        {
            $$ = gettype($6);
        }
        }
         LT EQUAL FLOAT_NUM
         {
        if(idcheck($9))
        {
            $$ = gettype($9);
        } SEMI    ;

%%

void yyerror ()
{
	printf("Syntax error at line %d\n", lineno);
	exit(1);
}

int main (int argc, char *argv[])
{
	yyparse();
	printf("Parsing finished!\n");	
	return 0;
}
