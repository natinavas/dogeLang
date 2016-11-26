#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//TODO meter en limitaiciones del informe esto de los mallocs
char* append(char* s1, char* s2){
		char* s = malloc(strlen(s1) + strlen(s2) + 1);
		s[0] = '\0'; //will be overwritten by strcat

		strcat(s, s1);
		strcat(s, s2);
		return s;
}

char* biAppend(char* s1, char* s2){
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
