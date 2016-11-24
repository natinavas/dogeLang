%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}
%option nounistd
%option noyywrap
%option yylineno
number					[0-9]+
id						[a-zA-Z][0-9a-zA-Z_]*
string					\".*\"
space					\ 
whitespace				[\ \t\n\v\f]
wss						{whitespace}*
shh						shh.*shh

%%

{wss}very{wss}			return VERY;
{wss}so{wss}			return SO;
{wss}words{wss}			yylval.s=yytext; return WORDS;
{wss}numbr{wss}			yylval.s=yytext; return NUMBR;
{wss}is{wss}			return IS;

{wss}more{wss}			printf("MOOORE\n"); return MORE;
{wss}less{wss}			return LESS;
{wss}lots{wss}			return LOTS;
{wss}few{wss}			return FEW;

{wss}plz{wss}			return PLZ;
{wss}go{wss}to{wss}the{wss}moon{wss}	return GOTOTHEMOON;

{wss}rly{wss}			return RLY;
{wss}notrly{wss}		return NOTRLY;
{wss}but{wss}			printf("butttttt\n");return BUT;
{wss}many{wss}			return MANY;

{wss}not{wss}			return NOT;
{wss}and{wss}			return AND;
{wss}or{wss}			return OR;
{wss}bigger{wss}		printf("bigger!!\n"); return BIGGER;
{wss}smaller{wss}		return SMALLER;
{wss}biggerish{wss}		return BIGGERISH;
{wss}smallerish{wss}	return SMALLERISH;
{wss}same{wss}			return SAME;

{wss}next{wss}			return NEXT;

{shh}					yylval.s=yytext; return SHH;

[(){}]					return yytext[0];

{number}				yylval.n=atoi(yytext); printf("numero es: %d", atoi(yytext)); return NUMBER;
{id}					yylval.s=yytext; return ID;
{string}				yylval.s=yytext; return STRING; printf("encontre un id %s\n", yytext);



%%
