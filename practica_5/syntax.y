%{

#include <stdio.h>

int yylex(void);
void yyerror(char const*);

%}

%token PROGRAM_KW
%token VAR_KW
%token INTEGER_KW
%token BOOLEAN_KW
%token BEGIN_KW
%token END_KW
%token IF_KW
%token THEN_KW
%token ELSE_KW
%token INPUT_KW
%token OUTPUT_KW
%token WHILE_KW
%token DO_KW
%token REPEAT_KW
%token UNTIL_KW

%token IDENTIFIER

%token DATA_TYPE
%token DELIMITER

%token ASSIGNER

%token INTEGER

%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP

%token MORE_THAN
%token LESS_THAN
%token MORE_EQUAL
%token LESS_EQUAL
%token EQUAL_TO

%start program

%%

program: IDENTIFIER DELIMITER;

%%

int main()
{
	yylex();
}
