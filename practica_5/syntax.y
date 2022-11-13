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

%token MORE_THAN
%token LESS_THAN
%token MORE_EQUAL
%token LESS_EQUAL
%token EQUAL_TO

%%

program: head				 	{ printf("Solo encabezado\n"); }
	| head declaration_block 	{ printf("head+declare\n"); }
	;

head: PROGRAM_KW IDENTIFIER EOE { printf("Linea de programa\n"); }
	;

declaration_block: VAR_KW var_declarations { printf("Bloque de variables\n"); }
	| VAR_KW					{ printf("Bloque de variables vacio\n"); }
	;

var_declarations:
	  identifiers DATA_ASSIGN data_type EOE var_declarations
	| identifiers DATA_ASSIGN data_type EOE
	;

identifiers:
	  IDENTIFIER				{ printf("Una variable en una linea\n");}
	| IDENTIFIER SEPARATOR identifiers { printf("Multiples variables en la misma linea\n"); }
	;

data_type: INTEGER_KW  	{ printf("Integers\n"); }
	| BOOLEAN_KW 		{ printf("Bools\n"); }
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
