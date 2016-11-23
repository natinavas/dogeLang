/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    ID = 259,
    STRING = 260,
    VERY = 261,
    SO = 262,
    DOGETYPE = 263,
    IS = 264,
    MORE = 265,
    LESS = 266,
    LOTS = 267,
    FEW = 268,
    PLZ = 269,
    GOTOTHEMOON = 270,
    RLY = 271,
    NOTRLY = 272,
    BUT = 273,
    MANY = 274,
    NEXT = 275,
    NOT = 276,
    AND = 277,
    OR = 278,
    BIGGER = 279,
    SMALLER = 280,
    BIGGERISH = 281,
    SMALLERISH = 282,
    SAME = 283
  };
#endif
/* Tokens.  */
#define NUMBER 258
#define ID 259
#define STRING 260
#define VERY 261
#define SO 262
#define DOGETYPE 263
#define IS 264
#define MORE 265
#define LESS 266
#define LOTS 267
#define FEW 268
#define PLZ 269
#define GOTOTHEMOON 270
#define RLY 271
#define NOTRLY 272
#define BUT 273
#define MANY 274
#define NEXT 275
#define NOT 276
#define AND 277
#define OR 278
#define BIGGER 279
#define SMALLER 280
#define BIGGERISH 281
#define SMALLERISH 282
#define SAME 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 10 "dogeyacc.y" /* yacc.c:1909  */

	int f;
	char* s;

#line 115 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
