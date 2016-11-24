%{
#include <stdio.h>
#include <stdlib.h>
#include "hashmap.h"
//#include "dogescan.h"

extern int yylex();
extern int yylineno;
void yyerror(const char *msg);
void assignWords(char * id, char * s);
void assignNumber(char * id, int number);
void addToMap();
static map_t map;
static int block;

//TODO meter en limitaiciones del informe esto de los mallocs
char* append(char* s1, char* s2){
		char* s = malloc(strlen(s1) + strlen(s2) + 1);
		s[0] = '\0'; //will be overwritten by strcat
		strcat(s, s1);
		strcat(s, s2);
		return s;
}

char* triAppend(char* s1, char* s2, char* s3){
	char* s = malloc(strlen(s1) + strlen(s2) + strlen(s3) + 1);
	s[0] = '\0'; //will be overwritten by strcat
	strcat(s, s1);
	strcat(s, s2);
	strcat(s, s3);
	return s;
}

char* quadAppend(char* s1, char* s2, char* s3, char* s4){
	char* s = malloc(strlen(s1) + strlen(s2) + strlen(s3) + strlen(s4)+ 1);
	s[0] = '\0'; //will be overwritten by strcat
	strcat(s, s1);
	strcat(s, s2);
	strcat(s, s3);
	strcat(s, s4);
	return s;
}

enum var_type {NUM, STR};

typedef union var_content{
	int number;
	char * string;
}var_content;

typedef struct entry_value{
	int block;
	int type;
	var_content content;
}entry_value;


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
%token WORDS
%token NUMBR
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
%token <s> SHH


%type <n> ea ta fa el tl fl logic_exp relational_exp arith_exp
%type <s> command condition els
%left MORE LESS
%left LOTS FEW

%%

program		:	commands gotothemoon	{printf("int main(){%s}", append($1, $2));}
			;

commands	:	command commands	{$$ = append($1, $2);}
			| /*lambda*/
			;

command		:	def  {$$ = $1}
			|	int_assign	{$$ = $1}
			|	string_assign	{$$ = $1}
			|	arith_exp	{$$ = $1}
			|	condition	{$$ = $1}
			|	loop	{$$ = $1}
			|	comment
			;

comment		:	SHH

condition 	:
			RLY logic_exp '{' commands '}'{
					char* aux = triAppend("if(", $2, "){");
					aux = triAppend(aux, $4, "}");
					$$ = aux;
			}

			|

			RLY logic_exp '{' commands '}' BUT els{
				char* aux = triAppend("if(", $2, "){");
				char* aux2 = triAppend($4, "}", "else ");
				aux = triAppend(aux, aux2, $7);
			}
			;

els			:
			condition {
				$$ = $1;
			}
			|
			'{' commands '}' {
				char* aux = triAppend("{", $2, "}");
			}
			| /*lambda*/
			;


loop 		:
			MANY logic_exp '{' commands '}'{
				char* aux = triAppend("while(", $2, "){");
				aux = triAppend(aux, $4, "}");
			}
	 		;

gotothemoon :
			PLZ arith_exp GOTOTHEMOON {
				$$ = triAppend("return ", $2, ";");
			}
			;


def			:
			VERY ID SO WORDS	{
				addToMap($2,1); //TODO verificar que no este ya declarado
				$$ = triAppend("char* ", $2, ";");
				printf("hola dogetype of type words : %s\n", $2);
			}
			|
			VERY ID SO NUMBR	{
				addToMap($2,0);
				$$ = triAppend("int ", $2, ";");
				printf("hola dogetype of type number : %s\n", $2);
			}
			;

int_assign		:
			ID IS arith_exp		{
				assignNumber($1, $3);
				$$ = quadAppend($1, "=", $3, ";");
				printf("hola numeros\n");
			}
			;

string_assign	:
			ID IS STRING	{
				assignWords($1, $3);
				$$ = quadAppend($1, "=", $3, ";");
				;

arith_exp	:	ea	{$$ = $1}
			;

ea		:
		ea MORE ta	{
			$$ = triAppend($1, "+", $3);
		}
		|
		ea LESS ta	{
			$$ = triAppend($1, "-", $3);
		}
		|	ta		{$$ = $1;}
		;

ta		:
		ta LOTS fa	{
			$$ = triAppend($1, "*", $3);
		}
		|
		ta FEW fa	{
			$$ = triAppend($1, "/", $3);
		}
		|	fa		{$$ = $1;}
		;

fa		:	'(' ea ')'	{ $$ = $2;}
		|	NUMBER		{$$ = $1;}
		|	ID			{$$ = $1;}
		;

logic_exp	:	el		{$$ = $1;}
		;

el		:
		el OR tl	{
			$$ = triAppend($1, "||", $3);
		}
		|	tl		{$$ = $1;}
		;

tl		:
		tl AND fl	{
			$$ = triAppend($1, "&&", $3);
		}
		|	fl		{$$ = $1;}
		;

fl		:
		NOT relational_exp	{
			$$ = append("!", $2);
		}
		|	relational_exp		{$$ = $1;}
		|	'(' el ')'		{$$ = $2;}

relational_exp	:
		arith_exp BIGGER arith_exp	{
			$$ = triAppend($1, ">", $3);
		}
		|
		arith_exp SMALLER arith_exp	{
			$$ = triAppend($1, "<", $3);
		}
		|
		arith_exp BIGGERISH arith_exp	{
			$$ = triAppend($1, ">=", $3);
		}
		|
		arith_exp SMALLERISH arith_exp	{
			$$ = triAppend($1, "<=", $3);
		}
		|
		arith_exp SAME arith_exp	{
			$$ = triAppend($1, "==", $3);
		}
		;

%%

/* Called by yyparse on error */
void yyerror(const char *msg){
	fprintf(stderr, "Error at line [%d]: %s\n", yylineno, msg);
	exit(1);
}

int main(void){
	map = hashmap_new();



	yyparse();
	return 0;
}

//TODO
void addToMap(char * id, int type){

	id = "hola";

	entry_value * response;

	entry_value entry;
	entry.block = block;
	entry.type = type;

	printf("el tipo es :       %d\n\n", type);


	printf("%s\n", id);

	if(hashmap_get(map, id, &response) == MAP_OK) {
		yyerror("same variable declared twice :(\n");
	}

	printf("sali\n");


	hashmap_put(map, id, &entry);

	hashmap_get(map, id, &response);

	printf("respuesta: %d\n", response->type);

	printf("map size : %d\n", hashmap_length(map));

}

void assignNumber(char * id, int number) {

	entry_value *entry;

	id = "hola";

	if(hashmap_get(map, id, &entry) == MAP_MISSING) {
		yyerror("the variable does not exist :(\n");
	}


	if(entry->type != 0) {
		yyerror("invalid assignment. Type of variable is not numbr :(\n");
	}

	hashmap_remove(map, id);

	entry->content.number = number;

	hashmap_put(map, id, &entry);

	printf("%s ahora vale : %d", id, number);

}

void assignWords(char * id, char * s) {

	entry_value entry;

	id = "hola";

	if(hashmap_get(map, id, &entry) == MAP_MISSING) {
		yyerror("the variable does not exist :(\n");
	}

	if(entry.type != STR) {
		yyerror("invalid assignment. Type of variable is not words :(\n");
	}

	hashmap_remove(map, id);

	entry.content.number = s;

	hashmap_put(map, id, &entry);

	printf("%s ahora vale : %d", id, s);

}
