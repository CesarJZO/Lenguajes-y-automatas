/* Definition section */
%{
#define KEYWORD 1
#define SUB_OPERATOR 2
#define SUM_OPERATOR 3
#define DIV_OPERATOR 4
#define MUL_OPERATOR 5
#define GREATER_THAN 6
#define SMALLER_THAN 7
#define PROGRAM_KEYWORD 8
%}

/* Rule section */
%%

"&"[a-zA-Z]+"_"{1}[0-9]+	{ return KEYWORD; }
"-"							{ return SUB_OPERATOR; }
"+"							{ return SUM_OPERATOR; }
"/"							{ return DIV_OPERATOR; }
"*"							{ return MUL_OPERATOR; }
"<"		{ return SMALLER_THAN; }
">"		{ return GREATER_THAN; }
"program"		{ return PROGRAM_KEYWORD; }
[ \t\r\n]		/* Ignore */

%%

int yywrap() { }

int main(int length, char **args) {
	if (length > 1) {
		FILE *fp;
		fp = fopen(args[1], "r");
		yyin = fp;
	
		int token = yylex();
		printf("%d", token);
		return 0;
	}
	else {
		printf("Input file not found!");
		return 1;
	}
}
