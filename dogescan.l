%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dogescan.h"
#include "y.tab.h"
%}
%option nounistd

number					[0-9]+
id						[a-zA-Z][0-9a-zA-Z_]*
string					\".*\"
space					\ 
whitespace				[\ \t\n\v\f]
wss						whitespace*
dogetype				numbr|words

%%

very					return VERY;
so						return SO;
dogetype				return DOGETYPE;
is						return IS;

more					return MORE;
less					return LESS;
lots					return LOTS;
few						return FEW;

plz						return PLZ;
go{wss}to{wss}the{wss}moon	return GOTOTHEMOON;

rly						return RLY;
notrly					return NOTRLY;
but						return BUT;
many					return MANY;

wow						return WOW;
woow					return WOOW;

not						return NOT;
and						return AND;
or						return OR;
bigger					return BIGGER;
smaller					return SMALLER;
biggerish				return BIGGERISH;
smallerish				return SMALLERISH;
same					return SAME;



[(){}]					return yytext[0];

{number}				yylval.f=atoi(yytext); return NUMBER;
{id}					yylval.s=yytext; return ID;
{string}				yylval.s=strdup(yytext); return STRING;


.						;

%%