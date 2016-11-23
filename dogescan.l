%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}
%option nounistd
%option noyywrap

number					[0-9]+
id						[a-zA-Z][0-9a-zA-Z_]*
string					\".*\"
space					\ 
whitespace				[\ \t\n\v\f]
wss						whitespace*
dogetype				numbr|words

%%

{wss}very{wss}			return VERY;
{wss}so{wss}			return SO;
{wss}dogetype{wss}		yylval.s=yytext; return DOGETYPE;
{wss}is{wss}			return IS;

{wss}more{wss}			return MORE;
{wss}less{wss}			return LESS;
{wss}lots{wss}			return LOTS;
{wss}few{wss}			return FEW;

{wss}plz{wss}			return PLZ;
{wss}go{wss}to{wss}the{wss}moon{wss}	return GOTOTHEMOON;

{wss}rly{wss}			return RLY;
{wss}notrly{wss}		return NOTRLY;
{wss}but{wss}			return BUT;
{wss}many{wss}			return MANY;

{wss}not{wss}			return NOT;
{wss}and{wss}			return AND;
{wss}or{wss}			return OR;
{wss}bigger{wss}		return BIGGER;
{wss}smaller{wss}		return SMALLER;
{wss}biggerish{wss}		return BIGGERISH;
{wss}smallerish{wss}	return SMALLERISH;
{wss}same{wss}			return SAME;

{wss}next{wss}			return NEXT;

[(){}]					return yytext[0];

{number}				yylval.f=atoi(yytext); printf("el numero es %d\n", yytext); return NUMBER;
{id}					yylval.s=yytext; return ID;
{string}				yylval.s=yytext; return STRING;


.						;

%%
