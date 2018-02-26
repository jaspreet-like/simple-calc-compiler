%token INTEGER VARIABLE FLOAT
%left '+' '-'
%left '*' '/'

%{
#include <iostream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
void yyerror(char *);
int yylex(void);
int sym[26];
int dc[1000];
%}

%%
program:
	program statement '\n'
	|
	;
statement:
	expr			{ cout << $1 <<endl;
				  cout << "did it"<<endl;
				}
	| VARIABLE '=' expr	{ sym[$1] = $3; }
	| type VARIABLE		{ dc[$2] = $1;}
	| type VARIABLE '=' expr { dc[$2] = $1;
				   sym[$2] = $4;}
	;
type:
	INTEGER		
	FLOAT
	;
expr:
	INTEGER
	|FLOAT
	| VARIABLE	{ $$ = sym[$1];
			}
	| expr '+' expr	{ $$ = $1 + $3; }
	| expr '-' expr	{ $$ = $1 - $3; }
	| expr '*' expr	{ $$ = $1 * $3; }
	| expr '/' expr	{ $$ = $1 / $3; }
	| '(' expr ')'  { $$ = $2; }
	;


%%
extern FILE *yyin;
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv){
    yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}
