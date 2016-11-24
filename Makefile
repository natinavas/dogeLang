.SILENT:

TARGET = dogescan

$(TARGET):

all:
	lex dogescan.l
	yacc -Wno -d dogeyacc.y
	cc lex.yy.c y.tab.c hashmap.c -o dogescan

clean:
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
	rm dogescan


