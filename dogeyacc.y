%{
#include <stdio.h>
#include <stdlib.h>
//#include "dogescan.h"

extern int yylex();
%}

%union{
	int f;
	char* s;
}

%token <f> NUMBER
%type <f> E F
%left '+' '-'
%left '*' '/'

%%

S:	E	//{printf("%f\n", $1);};




E:	E '*' E	{$$ = $1 * $3;}
	|	E '/'	E	{$$ = $1 / $3;}	
	|	E '-' E {$$ = $1 - $3;}
	|	E '+' E {$$ =$1 + $3;}
	|	F	{$$ =$1;}
	;
/*E:	E 'less' T	{$$ = $1 - $3;}
	|	E 'more' T {$$ = $1 + $3;}
	|	T {$$ = $1;}
	;

T: 	T 'lots' F {$$ = $1 * $3;}
	|	E 'few' T {$$ = $1 / $3;}
	|	F {$$ = $1;}
	;
*/

F: '(' E ')' { $$ = $2;}
	| '-' F {$$ = -$2;}
	| NUMBER {$$ = $1;}
	;

%%

/* Called by yyparse on error */
/*void yyerror(char *msg){
	fprintf(stderr, "%s\n", msg);
	exit(1);
}*/

int main(void){
	yyparse();
	return 0;
}