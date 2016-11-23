%{
#include <stdio.h>
#include <stdlib.h>
//#include "dogescan.h"

extern int yylex();
void yyerror(const char *msg);
%}

%union{
	int f;
	char* s;
}

%token <f> NUMBER
%token <s> ID
%token <s> STRING
%token VERY
%token SO
%token DOGETYPE
%token IS
%token MORE
%token LESS
%token LOTS
%token FEW
%token PLZ
%token GOTOTHEMOON
%token RLY
%token NOTRLY
%token BUT
%token MANY
%token NEXT
%token NOT
%token AND
%token OR
%token BIGGER
%token SMALLER
%token BIGGERISH
%token SMALLERISH
%token SAME


%type <f> E F
%left '+' '-'
%left '*' '/'

%%

S:	E	//{printf("%f\n", $1);};




E:	E MANY E {$$ = $1 * $3;}
	|	E FEW E	{$$ = $1 / $3;}	
	|	E LESS E {$$ = $1 - $3;}
	|	E MORE E {$$ =$1 + $3;}
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
	| NUMBER {$$ = $1;}
	;




%%

/* Called by yyparse on error */
void yyerror(const char *msg){
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int main(void){
	yyparse();
	return 0;
}