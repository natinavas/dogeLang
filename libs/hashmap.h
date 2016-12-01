union Pvar_content{
	int number;
	char * string;
};

typedef union Pvar_content * Var_Content;

struct Pentry_value{
	int block;
	int type;
	Var_Content content;
};

typedef struct Pentry_value * Entry_Value;

struct Pnode{
	char* key;
	Entry_Value value;
	struct Pnode* next;
};

typedef struct Pnode * Node;

struct PMap{
	int size;
	Node first;
};

typedef struct PMap * Map;


#define T_NUMBER 0
#define T_STRING 1

Map newMap();

int addEntry(Map map, char* key, int block, int type, Var_Content content);

Entry_Value getValue(Map map, char* key);

int hasKey(Map m, char* key);

void removeByKey(Map m, char* key);

void removeByBlock(Map m, int block);

void printAllKeys(Map m);

void updateValue(Map m, char* key, Var_Content content);

int isNumber(Map map, char* key);

int isString(Map map, char* key);
