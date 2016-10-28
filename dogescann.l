%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VAR_NAME 0
#define IS 1
#define VALUE 2

%}

id			[a-zA-Z][0-9a-zA-Z_]*
digit			[0-9]
int			{digit}+
intDefinition		very\ {id}\ so\ numbr
string			\".*\"
stringDefinition	very\ {id}\ so\ words
intAssign		{id}\ is\ {int}
stringAssign		{id}\ is\{string}
arithmeticOperator	(more|less|lots|few)
logicOperator		(not|and|or|bigger|smaller|biggerish|smallerish)
operand			{id}|{int}
logicExpression		{operand}(\ ){logicOperator}(\ ){operand}
returnValue		{operand}|{string}

%%

{intDefinition}				define_int();
{stringDefinition}			define_str();

{id}\ is\ ({int}|{string})		assign_value();

rly\ {logicExpression}			if_statement();
notrly\ {logicExpression} 		if_not_statement();
but\ rly						printf("else if()");
but\ not\ rly					printf("else if(!)");
but								printf("else");
wow								printf("{");
woow							printf("}");
\ next							printf(";");

many\ {logicExpression}			while_loop();
{id}\ {arithmeticOperator}\ {operand}	printf("artmetica\n");

plz\ {returnValue}\ go\ to\ the\ moon	return_statement();

.			;
%%

void define_int(){
        int i = 5;
        char* var_name = malloc(yyleng-13);
        int j = 0;
        while(yytext[i] != ' '){
                var_name[j]=yytext[i];
                j++;
                i++;
        }
        printf("int %s;\n", var_name);
        free(var_name);
        return;
}

void define_str(){
	int i = 5;
	char* var_name = malloc(yyleng-13);
	int j = 0;
	while(yytext[i] != ' '){
		var_name[j]=yytext[i];
		j++;
		i++;
	}
	printf("char* %s;\n", var_name);
	free(var_name);
	return;
}

void assign_value(char* yytext, int yyleng){
	int i=0, j=0;
	int state = VAR_NAME; 
	char* variable = malloc(yyleng - 4);
	char* value = malloc(yyleng - 4);
	
	for(i=0; i < yyleng; i++){
		switch(state){
			case VAR_NAME:
				if(yytext[i] == ' '){
					state = IS;
				}else{
					variable[j]=yytext[i];
					j++;
				}
			break;
			case IS:
				i+= 2;
				state = VALUE;
				j=0;
			break;
			case VALUE:
				value[j] = yytext[i];
				j++;
			break;
			
		}
	}
	printf("%s = %s;\n",variable, value);
	free(value);
	free(variable);
	return;
	
}

void while_loop(){
	printf("while(%s);\n", yytext+4);
}

void if_statement(){
	printf("if(%s)\n", yytext+4);
}

void if_not_statement(){
	printf("if(!%s)\n", yytext+7);
}

void return_statement(){
	int i = 4;
	int j=0;
	char* value = malloc(yyleng -18);
	for(i = 4; yytext[i]!=' '; i++, j++){
		value[j] = yytext[i];
	}
	printf("return %s;\n", value);
	free(value);
}
