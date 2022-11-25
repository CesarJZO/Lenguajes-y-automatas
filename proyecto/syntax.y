%{
#include <stdlib.h>
int yylex();
int yyerror(char*);
%}

%token IDENTIFIER

%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP

%token AND_OP
%token OR_OP
%token NOT_OP

%token MORE_THAN
%token LESS_THAN
%token MORE_EQUAL
%token LESS_EQUAL
%token EQUAL_TO

%token OPEN_PAR
%token CLOSE_PAR
%token SEMICOLON
%token COMMA
%token OPEN_BLOCK
%token CLOSE_BLOCK

%token INTEGER
%token REAL
%token TEXT

%token ASSIGNER

%token FUN_KW
%token RETURN_KW
%token INT_KW
%token DEC_KW
%token TXT_KW
%token CHAR_KW
%token BOOL_KW
%token TRUE_KW
%token FALSE_KW
%token IF_KW
%token ELSE_KW
%token WHILE_KW
%token FOR_KW

%%

start:
	expressions { printf("¡Análisis exitoso!\n"); }
;

expressions:
	expression expressions
	| expression
;

expression: var_declaration | assignation | fun_def | return | if | while | for;

var_declaration:
	data_type IDENTIFIER SEMICOLON
	| data_type assignation
;

assignation:
	IDENTIFIER ASSIGNER result SEMICOLON
;

result: value | math_result | logic_result;

data_type: INT_KW | DEC_KW | TXT_KW | BOOL_KW | CHAR_KW;

value: IDENTIFIER | INTEGER | REAL | TEXT | TRUE_KW | FALSE_KW;

fun_def:
	FUN_KW IDENTIFIER OPEN_PAR CLOSE_PAR block
	| FUN_KW IDENTIFIER OPEN_PAR args CLOSE_PAR block
;

args:
	data_type IDENTIFIER
	| args COMMA args
;

block:
	OPEN_BLOCK CLOSE_BLOCK
	| OPEN_BLOCK expressions CLOSE_BLOCK
;

return:
	RETURN_KW value SEMICOLON
	| RETURN_KW SEMICOLON
;

if:
	IF_KW OPEN_PAR logic_result CLOSE_PAR block
	| if else
;

else: ELSE_KW block;

while:
	WHILE_KW OPEN_PAR logic_result CLOSE_PAR block
;

for:
	FOR_KW OPEN_PAR var_declaration SEMICOLON logic_result SEMICOLON assignation CLOSE_PAR block
;

math_result:
	  value
	| math_result operator math_result
	| OPEN_PAR math_result CLOSE_PAR
;

operator: SUB_OP | ADD_OP | MUL_OP | DIV_OP;

logic_result:
	  math_result
	| logic_result logic_operator logic_result
	| OPEN_PAR logic_result CLOSE_PAR
;

logic_operator:
	AND_OP | OR_OP | NOT_OP
	MORE_EQUAL | MORE_THAN | LESS_EQUAL | LESS_THAN | EQUAL_TO
;

%%

int yyerror(char *e)
{
	printf("Error: %s\n", e);
	exit(1);
}

int main()
{
	yyparse();
	return 0;
}
