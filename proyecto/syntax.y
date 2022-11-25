%{
int yylex();
int yyerror(char*);
%}

%token IDENTIFIER
%token FUNCTION_NAME

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
%token VAR_KW
%token IS_KW
%token NULL_KW

%%

program:
	expressions
	;

expressions:
	  expression expressions
	| expression
	;

instructions:
	  instruction instructions
	| instruction SEMICOLON
	;

instruction: var_declaration | assignation | function_call;

expression: instructions | if | while | for | function_def;

body:
	  OPEN_BLOCK CLOSE_BLOCK
	| OPEN_BLOCK expressions CLOSE_BLOCK
	;

function_body:
	OPEN_BLOCK CLOSE_BLOCK
	| OPEN_BLOCK return CLOSE_BLOCK
	| OPEN_BLOCK expressions return CLOSE_BLOCK
	;

return:
	  RETURN_KW SEMICOLON
	| RETURN_KW value SEMICOLON
	| RETURN_KW instruction SEMICOLON
	;

var_declaration:
	  data_type IDENTIFIER SEMICOLON
	| data_type IDENTIFIER ASSIGNER value SEMICOLON
	;

data_type: INT_KW | DEC_KW | TXT_KW | BOOL_KW | CHAR_KW;

assignation:
	  IDENTIFIER ASSIGNER result
	| IDENTIFIER ASSIGNER logic_result
	| IDENTIFIER ASSIGNER NULL_KW
	;

function_def:
	FUN_KW FUNCTION_NAME OPEN_PAR CLOSE_PAR function_body
	| FUN_KW FUNCTION_NAME OPEN_PAR args CLOSE_PAR function_body
	;

function_call:
	  FUNCTION_NAME OPEN_PAR CLOSE_PAR
	| FUNCTION_NAME OPEN_PAR args CLOSE_PAR
	| function_call body
	;

args:
	  data_type IDENTIFIER
	| data_type IDENTIFIER COMMA args
	;

value:
	  INTEGER
	| REAL
	| TEXT
	| IDENTIFIER
	| TRUE_KW | FALSE_KW
	;

result:
	  value
	| result operator result
	| OPEN_PAR result CLOSE_PAR
	;

operator: SUB_OP | ADD_OP | MUL_OP | DIV_OP;

logic_result:
	  result
	| logic_result logic_operator logic_result
	| OPEN_PAR logic_result CLOSE_PAR
	;

logic_operator: MORE_EQUAL | MORE_THAN | LESS_EQUAL | LESS_THAN | EQUAL_TO | AND_OP | OR_OP | NOT_OP;

if:
	IF_KW OPEN_PAR logic_result CLOSE_PAR body
	| if else
	;

else:
	ELSE_KW body
	;

while:
	WHILE_KW OPEN_PAR logic_result CLOSE_PAR body
	;

for:
	FOR_KW OPEN_PAR CLOSE_PAR
	| FOR_KW OPEN_PAR instruction SEMICOLON logic_result SEMICOLON instruction CLOSE_PAR
	| for body
	; 

%%

int yyerror(char *e)
{
	printf("Error: %s\n", e);
}

int main()
{
	yyparse();
	return 0;
}
