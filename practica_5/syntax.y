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

%token DATA_ASSIGN

%token EOE
%token EOL

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

program: head	{ printf("Inicio valido\n"); }
	| head declaration_block
	;

head: PROGRAM_KW IDENTIFIER EOE EOL;
declaration_block: VAR_KW EOL var_declaration;

var_declaration: IDENTIFIER DATA_ASSIGN data_type EOE;

data_type: INTEGER_KW
	| BOOLEAN_KW;

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
