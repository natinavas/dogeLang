%{
#include <stdio.h>
#include <stdlib.h>
#include "hashmap.h"
//#include "dogescan.h"

extern int yylex();
void yyerror(const char *msg);
void addToMap();
static map_t map;

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


%type <n> ea ta fa el tl fl logic_exp relational_exp arith_exp
%left MORE LESS
%left LOTS FEW

%%

def		:	VERY ID SO DOGETYPE		{addToMap($2,$4); printf("hola dogetype of type %s\n", $4);}
		;
		
int_assign	:	ID IS arith_exp		{addToMap();printf("hola numeros\n");}
		;


	
string_assign	:	ID IS STRING	{addToMap();printf("hola\n");}
		;
	



arith_exp	:	ea	{printf("resultado : %d\n", $1);}
		;

		
ea		:	ea MORE ta	{$$ =$1 + $3; }
		|	ea LESS ta	{$$ = $1 - $3;}
		|	ta			{$$ = $1;} 
		;
		
ta		:	ta LOTS fa	{$$ = $1 * $3;}
		|	ta FEW fa	{$$ = $1 / $3;}	
		|	fa			{$$ = $1;}
		;
		
fa		:	'(' ea ')'	{ $$ = $2;}
		|	NUMBER		{$$ = $1;}
//		|	ID
		;

logic_exp	:	el		{$$ = $1; printf("resultado : %d\n", $1);}
		;
el		:	el OR tl	{$$ = $1 || $3}
		|	tl		{$$ = $1}
		;
tl		:	tl AND fl	{$$ = $1 && $3}
		|	fl		{$$ = $1}
		;
fl		:	NOT relational_exp	{$$ = !$2}
		|	relational_exp		{$$ = $1}
		|	'(' el ')'		{$$ = $2}

relational_exp	:	arith_exp BIGGER arith_exp	{$$ = $1 > $3}
		|	arith_exp SMALLER arith_exp	{$$ = $1 < $3}
		|	arith_exp BIGGERISH arith_exp	{$$ = $1 >= $3}
		|	arith_exp SMALLERISH arith_exp	{$$ = $1 <= $3}
		|	arith_exp SAME arith_exp	{$$ = $1 == $3}
		;

%%

/* Called by yyparse on error */
void yyerror(const char *msg){
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int main(void){
	map = hashmap_new();

	

	yyparse();
	return 0;
}

//TODO
void addToMap(char * id, char * type){
	hashmap_put(map, id, type);

	char * response;

	hashmap_get(map, id, &response);

	printf("respuesta: %s\n", response);
}










