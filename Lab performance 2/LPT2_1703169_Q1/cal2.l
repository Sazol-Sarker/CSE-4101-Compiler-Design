%option noyywrap

%{
  #include<stdio.h>
//Roll Number: 1703169
%}
delim [ \t]
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
"let" {printf("%s -> LET\n", yytext);}
"as" {printf("%s -> AS\n", yytext);}
"int" {printf("%s -> INT_TYPE\n", yytext);}
"until"  {printf("%s -> UNTIL\n", yytext);}
"do" {printf("%s -> DO\n", yytext);}
"loop" {printf("%s -> LOOP\n", yytext);}
{ID}  {printf("%s -> ID\n", yytext);}
"<" {printf("%s -> LT\n", yytext);}
"+" {printf("%s -> ADD\n", yytext);}
{FCONST} {printf("%s -> FLOAT_NUM\n", yytext);}
"=" {printf("%s -> EQUAL\n", yytext);}
{ICONST} {printf("%s -> INT_NUM\n", yytext);}
";" {printf("%s -> SEMI\n", yytext);}
%%

int main()
{
  yylex();
  return 0;
}