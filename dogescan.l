%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dogescan.h"
%}
%option nounistd

number					[0-9]+
id						[a-zA-Z][0-9a-zA-Z_]*
string					\".*\"

%%

{number}				return NUMBER;
{id}					return ID;
{string}				return STRING;

\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;

%%