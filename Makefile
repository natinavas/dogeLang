.SILENT:

TARGET = dogescan

$(TARGET):

all:
	lex dogescan.l
	yacc -d dogeyacc.y
	cc lex.yy.c y.tab.c ./libs/hashmap.c ./libs/append.c -o dogescan

clean:
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
	rm dogescan
