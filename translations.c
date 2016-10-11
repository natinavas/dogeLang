#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VAR_NAME 0
#define IS 1
#define VALUE 2

void define_int(char* command, int len);
void define_charptr(char* command, int len);
void define_value(char* command, int len);

int main(void){
	char* hola = "very doge so words";
	define_charptr(hola, strlen(hola));
	char* hola2 = "very doge so numbr";
	define_int(hola2, strlen(hola2));
	char* hola3 = "doge is 2";
	define_value(hola3, strlen(hola3));
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
			break;
			case VALUE:
				strcpy(value, command+i);
			break;
			
		}
	}
	printf("%s = %s;\n",variable, value);
	free(value);
	free(variable);
	return;
	
}