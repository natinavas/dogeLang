#include <stdio.h>
#include <stdlib.h>
#include "hashmap.h"
#include <string.h>

Node newNode(char* key, Entry_Value ev);
Entry_Value newEntryValue(int block, int type, Var_Content content);
Entry_Value getValueRec(char* key, Node node);
Node removeByKeyRec(char* key, Node node, Map m);
void printAllKeysRec(Node node);
Node removeByBlockRec(int block, Node node, Map m);
void updateValue(Map map, char * key, Var_Content content);
void updateValueRec(Var_Content content, char * key, Node node);

Map newMap(){
	Map ret = (Map) malloc(sizeof(Map));
	if(ret == NULL)
		return NULL;

	ret->size = 0;
	ret->first = NULL;
	return ret;
}

int addEntry(Map map, char* key, int block, int type, Var_Content content){
	if(map == NULL)
		return -1;

	if(hasKey(map, key))
		return 0;

	Entry_Value ev = newEntryValue(block, type, content);
	if(ev == NULL)
		return -1;

	Node node = newNode(key, ev);
	if(node == NULL)
		return -1;

	node->next = map->first;
	map->first = node;
	map->size++;
	return 1;
}

Node newNode(char* key, Entry_Value ev){
	Node ret = (Node) malloc(sizeof(Node));
	if(ret == NULL){
		return NULL;
	}

	ret->key = key;
	ret->value = ev;
	return ret;
}

Entry_Value newEntryValue(int block, int type, Var_Content content){
	Entry_Value ret = (Entry_Value) malloc(sizeof(Entry_Value));
	if(ret == NULL){
		return NULL;
	}

	ret->block = block;
	ret->type = type;
	ret->content = content;
	return ret;
}

Entry_Value getValue(Map map, char* key){
	if(map == NULL || map->size == 0)
		return NULL;
	return getValueRec(key, map->first);
}

Entry_Value getValueRec(char* key, Node node){
	if(node == NULL)
		return NULL;

	if(strcmp(key, node->key) == 0){
		return node->value;
	}

	return getValueRec(key, node->next);
}

int hasKey(Map m, char* key){
	if(getValue(m,key) == NULL)
		return 0;
	return 1;
}

void removeByKey(Map m, char* key){
	if(m == NULL || m->size == 0)
		return;
	m->first = removeByKeyRec(key, m->first, m);
}

Node removeByKeyRec(char* key, Node node, Map m){
	if(node == NULL)
		return NULL;

	if(strcmp(key, node->key) == 0){
		Node aux = node;
		free(aux->value);
		free(aux);
		m->size--;
		return node->next;
	}

	node->next = removeByKeyRec(key, node->next, m);
	return node;
}

void printAllKeys(Map m){
	if(m == NULL)
		return;
	printAllKeysRec(m->first);
}

void printAllKeysRec(Node node){
	if(node == NULL)
		return;
	printf("%s\n", node->key);
	printAllKeysRec(node->next);
}

void removeByBlock(Map m, int block){
	if(m == NULL || m->size == 0)
		return;
	m->first = removeByBlockRec(block, m->first, m);
}

Node removeByBlockRec(int block, Node node, Map m){
	if(node == NULL){
		return NULL;
	}

	if(node->value->block == block){
		Node aux = node;
		Node ret = removeByBlockRec(block, node->next, m);
		free(aux->value);
		free(aux);
		m->size--;
		return ret;
	}

	node->next = removeByBlockRec(block, node->next, m);
	return node;
}

void updateValue(Map map, char * key, Var_Content content){
	if(map == NULL || map->size == 0)
		return;
	updateValueRec(content, key, map->first);
}

void updateValueRec(Var_Content content, char * key, Node node){
	if(node == NULL)
		return;
	if(strcmp(node->key, key) == 0){
		node->value->content = content;
		return;
	}
	updateValueRec(content, key, node->next);
}

int isNumber(Map map, char* key){
	Entry_Value ret = getValue(map, key);
	if(ret == NULL)
		return 0;
	return ret->type == T_NUMBER;
}

int isString(Map map, char* key){
	Entry_Value ret = getValue(map, key);
	if(ret == NULL)
		return 0;
	return ret->type == T_STRING;
}
