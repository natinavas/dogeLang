#include <stdio.h>
#include <stdlib.h>
#include "hashmap.h"

int main()
{

	Map m = newMap();
	printf("Estoy aca 0\n");
	Var_Content content = (Var_Content) malloc(sizeof(Var_Content));
	printf("Estoy aca 0.5\n");
	content->number = 5;

	printf("Estoy aca 1\n");

	int ret = addEntry(m, "key", 0, 5, content);
	printf("Estoy aca 2\n");
	int ret2 = addEntry(m, "key2", 1, 6, content);
	printf("Estoy aca 3\n");
	int ret5 = addEntry(m, "key5", 3, 8, content);
	int ret3 = addEntry(m, "key3", 2, 7, content);
	printf("Estoy aca 4\n");
	int ret4 = addEntry(m, "key4", 3, 8, content);

	printf("Aca encontre %d\n", getValue(m,"key3")->block);

	printAllKeys(m);
	printf("\n\n");
	removeByBlock(m, 3);
	printAllKeys(m);
	printf("\n\n");
	


	return 0;
}