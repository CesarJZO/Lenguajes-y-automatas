%{
int yylex();
int yyerror(char*);
%}

%token PROGRAM_KW
%token VAR_KW
%token INTEGER_KW
%token BOOLEAN_KW
%token TRUE_KW
%token FALSE_KW
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

%token SEPARATOR
%token DATA_ASSIGN
%token EOE

%token ASSIGNER

%token INTEGER

%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP

%token OPEN_PAR
%token CLOSE_PAR

%token MORE_THAN
%token LESS_THAN
%token MORE_EQUAL
%token LESS_EQUAL
%token EQUAL_TO

%%

program:
	  head				 			{ printf("Solo encabezado\n");   }
	| head declaration_block 		{ printf("head+declare\n"); 	 }
	| head declaration_block body	{ printf("head+declare+body\n"); }
	;

head:
	  PROGRAM_KW IDENTIFIER EOE
	;

declaration_block:
	  VAR_KW var_declarations
	| VAR_KW
	;

var_declarations:
	  identifiers DATA_ASSIGN data_type EOE var_declarations
	| identifiers DATA_ASSIGN data_type EOE
	;

identifiers:
	  IDENTIFIER
	| IDENTIFIER SEPARATOR identifiers
	;

data_type: INTEGER_KW | BOOLEAN_KW;

body:
	  BEGIN_KW END_KW
	| BEGIN_KW expressions END_KW
	;

instructions:
	  instruction instructions
	| instruction EOE
	;

instruction: assignation | io;

assignation:
	  IDENTIFIER ASSIGNER result
	| IDENTIFIER ASSIGNER logic_result
	;

io:
	  INPUT_KW | OUTPUT_KW
	| io OPEN_PAR IDENTIFIER CLOSE_PAR
	;

value:
	  INTEGER
	| IDENTIFIER
	| TRUE_KW | FALSE_KW
	;

result:
	  value
	| result operator result
	| OPEN_PAR result CLOSE_PAR
	;

operator: SUB_OP | ADD_OP | MUL_OP | DIV_OP;

expressions:
	  expression expressions
	| expression
	;

expression: instructions | if | while | repeat;

logic_result:
	  result
	| logic_result logic_operator logic_result
	| OPEN_PAR logic_result CLOSE_PAR
	;

logic_operator: MORE_EQUAL | MORE_THAN | LESS_EQUAL | LESS_THAN | EQUAL_TO;

if:
	IF_KW logic_result THEN_KW body
	| if else
	;

else:
	ELSE_KW body
	;

while:
	WHILE_KW logic_result DO_KW body
	;

repeat:
	REPEAT_KW body UNTIL_KW logic_result EOE
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
