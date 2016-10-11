#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VAR_NAME 0
#define IS 1
#define VALUE 2

void define_int(char* command, int len);
void define_charptr(char* command, int len);
void define_value(char* command, int len);
void opening_bracket();
void closing_bracket();
void return_statement(char* command, int len);
void while_loop(char* command, int len);
void print_func(char* command, int len);
void if_statement(char* command, int len);
void if_not_statement(char* command, int len);
void else_statement(char* command, int len);
void else_if_statement(char* command, int len);



int main(void){
	char* hola = "very doge so words";
	//define_charptr(hola, strlen(hola));
	char* hola2 = "very doge so numbr";
	//define_int(hola2, strlen(hola2));
	char* hola3 = "doge is holalalalalla";
	define_value(hola3, strlen(hola3));
	// opening_bracket();
// 	closing_bracket();
// 	printf("\n");
	char* hola4 = "plz hola go to the moon";
	//return_statement(hola4, strlen(hola4));
	
	char* ifstat = "rly doge not true";
	char* ifelsstat = "but rly doge not true";
	char* notif = "notrly hi";
	char* butt = "but helou";
	
	// if_statement(ifstat, strlen(ifstat));
	// else_if_statement(ifelsstat, strlen(ifelsstat));
	// if_not_statement(notif, strlen(notif));
	// else_statement(butt, strlen(butt));
	//
	
	
	return 0;
}

//defines a number
void define_int(char* command, int len){
	int i = 5;
	char* var_name = malloc(len-13);
	int j = 0;
	while(command[i] != ' '){
		var_name[j]=command[i];
		j++;
		i++;
	}
	printf("int %s;\n", var_name);
	free(var_name);
	return;
}


//defines a word
void define_charptr(char* command, int len){
	int i = 5;
	char* var_name = malloc(len-13);
	int j = 0;
	while(command[i] != ' '){
		var_name[j]=command[i];
		j++;
		i++;
	}
	printf("char* %s;\n", var_name);
	free(var_name);
	return;
}


//assigns a word or number to a variable
void define_value(char* command, int len){
	int i=0, j=0;
	int state = VAR_NAME; 
	char* variable = malloc(len - 4);
	char* value = malloc(len - 4);
	
	for(i=0; i < len; i++){
		switch(state){
			case VAR_NAME:
				if(command[i] == ' '){
					state = IS;
				}else{
					variable[j]=command[i];
					j++;
				}
			break;
			case IS:
				i+= 2;
				state = VALUE;
				j=0;
			break;
			case VALUE:
				value[j] = command[i];
				j++;
			break;
			
		}
	}
	printf("%s = %s;\n",variable, value);
	free(value);
	free(variable);
	return;
	
}

void opening_bracket(){
	printf("{");
}

void closing_bracket(){
	printf("}");
}

void return_statement(char* command, int len){
	int i = 4;
	int j=0;
	char* value = malloc(len -18);
	for(i = 4; command[i]!=' '; i++, j++){
		value[j] = command[i];
	}
	printf("return %s;\n", value);
	free(value);
}

void while_loop(char* command, int len){
	printf("while(%s);\n", command+4);
}

void print_func(char* command, int len){
	printf("printf(%s);\n",command+4);
}

void if_statement(char* command, int len){
	printf("if(%s)\n", command+4);
}

void if_not_statement(char* command, int len){
	printf("if(!%s)\n", command+7);
}

void else_statement(char* command, int len){
	printf("else\n");
}

void else_if_statement(char* command, int len){
	printf("else if(%s)\n", command+8);
}
