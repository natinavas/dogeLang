%{
#include <stdio.h>
#include <stdlib.h>
#include "./libs/hashmap.h"
#include "./libs/append.h"
#include <string.h>
//#include "dogescan.h"

extern int yylex();
extern FILE *yyin;
void yyerror(const char *msg);
void assignWords(char * id, char * s);
void assignNumber(char * id, char * number);
void addToMap();
void compile(char * program);
void deleteVariablesInBlock();

static Map map;
static int block;
static char * outputfile = "a.out";

%}

%union{
	int n;
	char* s;
}

%token <s> NUMBER
%token <s> ID
%token <s> STRING
%token OPENBRACKET
%token CLOSEBRACKET
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
%token BUT
%token MANY
%token NOT
%token AND
%token OR
%token BIGGER
%token SMALLER
%token BIGGERISH
%token SMALLERISH
%token SAME
%token WOW
%token WANT
%token <s> SHH

%type <s> ea ta fa el tl fl logic_exp relational_exp arith_exp open_block close_block
%type <s> command condition els gotothemoon commands def int_assign string_assign comment loop print
%left MORE LESS
%left LOTS FEW




%start program

%%

program		:	commands gotothemoon	{compile(append($1, $2));}
					;

commands	:	command commands	{$$ = append($1, $2);}
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
			|	comment	{$$ = $1;}
			|	print	{$$ = $1;}
			;

comment		:	SHH {$$ = triAppend("/*", $1, "*/");}
					;

condition 	:
			RLY logic_exp open_block commands close_block{
				char* aux = triAppend("if(", $2, "){");
				aux = triAppend(aux, $4, "}");
				$$ = aux;
			}
			|
			RLY logic_exp open_block commands close_block BUT els {
				char* aux = triAppend("if(", $2, "){");
				char* aux2 = triAppend($4, "}", "else ");
				aux = triAppend(aux, aux2, $7);
				$$ = aux;
			}
			;

els			:
			condition {
				$$ = $1;
			}
			|
			open_block commands close_block {
				char* aux = triAppend("{", $2, "}");
				$$ = aux;
			}
/*			|  {
				char aux = "{}";
				$$ = aux;
			}*/
			;

open_block	:
			OPENBRACKET {
				block++;
			}

close_block	:
			CLOSEBRACKET {
				deleteVariablesInBlock();
				block--;
			}


loop 		:
			MANY logic_exp open_block commands close_block{
				char* aux = triAppend("while(", $2, "){");
				aux = triAppend(aux, $4, "}");
				$$ = aux;
			}
	 		;

gotothemoon :
			PLZ arith_exp GOTOTHEMOON {
				$$ = triAppend("return ", $2, ";");
			}
			;

print :
			WOW arith_exp WOW	{
				if(isString(map, $2)){
					$$ = triAppend("printf(\"%s\",", $2, ");");
				}else{
					$$ = triAppend("printf(\"%d\",", $2, ");");
				}
			}
			|
			WOW STRING WOW {
				$$ = triAppend("printf(\"%s\",", $2, ");");
			}
			;

def			:
			VERY ID SO WORDS	{
				addToMap($2,T_STRING);
				$$ = triAppend("char* ", $2, ";");
			}
			|
			VERY ID SO NUMBR	{
				addToMap($2,T_NUMBER);
				$$ = triAppend("int ", $2, ";");
			}
			;

int_assign		:
			ID IS arith_exp		{
				assignNumber($1, $3);
				$$ = quadAppend($1, "=", $3, ";");
			}
			|
			ID IS WANT NUMBR		{
				assignNumber($1, 0);
				$$ = biAppend($1, "= getint(\"\");");
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
			$$ = triAppend("!(", $2, ")");
		}
		|	relational_exp		{$$ = $1;}
		|	'(' el ')'		{$$ = $2;}
		;

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
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int main(int argc,char *argv[]){

	switch (argc) {
		case 3:
			outputfile = argv[2];
			break;
		default:
			printf("wrong number of arguments\n");
			return 0;
	}

	int l = strlen(argv[1]);
	if(strcmp(argv[1] + l - 5, ".doge")) {
		printf("Source file does not have doge extension\n");
		return 0;
	}

	if ( (yyin = fopen(argv[1],"r")) == 0 ) {
		 perror(argv[1]);
		 exit(1);
	 }

	map = newMap();
	block = 0;
	yyparse();
	return 0;
}


void addToMap(char * id, int type){

	Entry_Value entry_value;

	if(hasKey(map, id)) {
		yyerror("same variable declared twice\n");
	}

	addEntry(map, id, block, type, NULL);

	entry_value = getValue(map, id);
}

void assignNumber(char * id, char * number) {

	Entry_Value entry_value;

	if(!hasKey(map, id)) {
		yyerror("the variable does not exist\n");
	}

	entry_value = getValue(map, id);


	if(entry_value->type != T_NUMBER) {
		yyerror("invalid assignment. Type of variable is not numbr\n");
	}

	Var_Content content = (Var_Content) malloc(sizeof(Var_Content));
	content->string = number;

	updateValue(map, id, content);
}

void assignWords(char * id, char * s) {

	Entry_Value entry_value;

	if(!hasKey(map, id)) {
		yyerror("the variable does not exist\n");
	}

	entry_value = getValue(map, id);

	if(entry_value->type != T_STRING) {
		yyerror("invalid assignment. Type of variable is not words\n");
	}

	Var_Content content = (Var_Content) malloc(sizeof(Var_Content));
	content->string = s;

	updateValue(map, id, content);
}

void deleteVariablesInBlock() {
		removeByBlock(map, block);
}

void compile(char * program) {
	FILE *f = fopen("file.c", "w+");

	fprintf(f, "#include <stdio.h>\n");

	fprintf(f, "int main(void){");
	fprintf(f, "%s", program);
	fprintf(f, "}");

	fclose(f);
	char * command = "gcc -o ";
	command = append(command, outputfile);
	command = append(command, " ./libs/getnum.c file.c");
	system(command);
	system("rm file.c");
}
