%{
#include<iostream>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "grammer.tab.h"
using namespace std;	
void yyerror(char *);
%}
%%
	/* variables */
[a-z]   {
		yylval = *yytext - 'a';
		return VARIABLE;
	    }
    /* decimal numbers */
[0-9]*.[0-9]+	{
		    yylval = decimal.parse(yytext);
		    return FLOAT;
		}
    /* integers */
[0-9]+    {
		yylval = atoi(yytext);
		return INTEGER;
          }
    /* operators */
[-+()=/*\n] { return *yytext; }
    /* skip whitespace */
[ \t]    ;
    /* anything else is an error */
.		yyerror("invalid character");
%%
int yywrap(void) {
    return 1;
}
