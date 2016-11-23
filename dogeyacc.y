%{
#include <stdio.h>
#include <stdlib.h>
//#include "dogescan.h"

extern int yylex();
void yyerror(const char *msg);
void addToMap();

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


%type <f> E T F
//%type <s> 
%left MORE LESS
%left LOTS FEW

%%
/*
def		:	VERY ID SO DOGETYPE		{addToMap();}
		;
		
int_assign	:	ID IS arith_exp
		;
		
string_assign	:	ID IS STRING
		;

arith_exp	:	E
		;*/
		
E		:	E MORE T	{$$ =$1 + $3;}
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
