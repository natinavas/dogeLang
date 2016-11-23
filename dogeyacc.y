%{
#include <stdio.h>
#include <stdlib.h>
//#include "dogescan.h"

extern int yylex();
void yyerror(const char *msg);
void addToMap();

%}

%union{
	int n;
	char* s;
}

%token <n> NUMBER
%token <s> ID
%token <s> STRING
%token VERY
%token SO
%token <s> DOGETYPE
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


%type <n> E T F
%left MORE LESS
%left LOTS FEW

%%

def		:	VERY ID SO DOGETYPE		{addToMap(); printf("hola dogetype of type %s\n", $4);}
		;
		
int_assign	:	ID IS arith_exp		{addToMap();printf("hola numeros\n");}
		;


	
string_assign	:	ID IS STRING	{addToMap();printf("hola\n");}
		;
	



arith_exp	:	E	{printf("resultado : %d\n", $1);}
		;

		
E		:	E MORE T	{$$ =$1 + $3; }
		|	E LESS T	{$$ = $1 - $3;}
		|	T			{$$ = $1;} 
		;
		
T		:	T LOTS F	{$$ = $1 * $3;}
		|	T FEW F		{$$ = $1 / $3;}	
		|	F			{$$ = $1;}
		;
		
F		:	'(' E ')'	{ $$ = $2;}
		|	NUMBER		{$$ = $1;}
//		|	ID
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

//TODO
void addToMap(){
}
