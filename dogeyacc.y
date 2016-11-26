%{
#include <stdio.h>
#include <stdlib.h>
#include "hashmap.h"
#include <string.h>
//#include "dogescan.h"

extern int yylex();
extern int yylineno;
void yyerror(const char *msg);
void assignWords(char * id, char * s);
void assignNumber(char * id, char * number);
void addToMap();
char* append(char* s1, char* s2);
char* triAppend(char* s1, char* s2, char* s3);
char* quadAppend(char* s1, char* s2, char* s3, char* s4);
static Map map;
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

%token <s> NUMBER
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


%type <s> ea ta fa el tl fl logic_exp relational_exp arith_exp
%type <s> command condition els gotothemoon commands def int_assign string_assign comment loop
%left MORE LESS
%left LOTS FEW

%start program

%%

program		:	commands gotothemoon	{printf("hola main\n");printf("int main(){%s}", append($1, $2));}
			;

commands	:	command commands	{printf("lista de comandos\n");$$ = append($1, $2);}
			| /*lambda*/{
				$$ = "";
			}
			;

command		:	def  {$$ = $1;}
			|	int_assign	{$$ = $1;}
			|	string_assign	{$$ = $1;}
			|	arith_exp	{$$ = $1;}
			|	condition	{$$ = $1;}
			|	loop	{$$ = $1;}
			|	comment
			;

comment		:	SHH
			;

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
			| /*lambda*/ {
				$$ = "";
			}
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
				}
				;

arith_exp	:	ea	{$$ = $1;}
			;

ea		:
		ea MORE ta	{
			printf("moreeee\n");
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
		|	NUMBER		{printf("numerooo %s\n", $1);$$ = $1;}
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
	map = newMap();
	yyparse();
	return 0;
}


void addToMap(char * id, int type){
	//TODO cambiar
	//id = "hola";

	Entry_Value entry_value;


	if(hasKey(map, id)) {
		yyerror("same variable declared twice :(\n");
	}

	addEntry(map, id, block, type, NULL);

	entry_value = getValue(map, id);

	printAllKeys(map);

}

void assignNumber(char * id, char * number) {

	Entry_Value entry_value;

//TODO cambiar
	id = "hola";

	if(!hasKey(map, id)) {
		yyerror("the variable does not exist :(\n");
	}

	entry_value = getValue(map, id);

	if(entry_value->type != 0) {
		yyerror("invalid assignment. Type of variable is not numbr :(\n");
	}

	Var_Content content = (Var_Content) malloc(sizeof(Var_Content));
	content->string = number;

	updateValue(map, id, content);

	printAllKeys(map);

}

void assignWords(char * id, char * s) {

	Entry_Value entry_value;

//TODO cambiar
	//id = "hola";

	if(!hasKey(map, id)) {
		yyerror("the variable does not exist :(\n");
	}

	entry_value = getValue(map, id);

	if(entry_value->type != 1) {
		yyerror("invalid assignment. Type of variable is not numbr :(\n");
	}

	Var_Content content = (Var_Content) malloc(sizeof(Var_Content));
	content->string = s;

	updateValue(map, id, content);


	printAllKeys(map);
}
