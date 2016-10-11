#include <stdio.h>

int main(void){
		
	return 0;
}

//assigns word or number type and prints it in c
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
	return 0;
}

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
	return 0;
}