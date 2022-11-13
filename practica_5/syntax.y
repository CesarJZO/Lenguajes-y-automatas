%{
int yylex();
int yyerror(char*);
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
	| BEGIN_KW instructions END_KW
	;

instructions:
	  instruction instructions
	| instruction
	;

instruction:
	  assignation EOE
	;

assignation:
	  IDENTIFIER ASSIGNER result
	;

value:
	  INTEGER
	| IDENTIFIER
	;

result:
	  value
	| result operator result
	| OPEN_PAR result CLOSE_PAR
	;

operator: SUB_OP | ADD_OP | MUL_OP | DIV_OP;

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
