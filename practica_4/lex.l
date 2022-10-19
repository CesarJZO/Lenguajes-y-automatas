/* Definition section */
%{
char token[50];
int line = 0;
%}

/* Rule section */
%%

"&"[a-zA-Z]+"_"{1}[0-9]+	{ token = "Identifier"; }
["-" | "+" | "/" | "*"]	{ token = "Math operator"; }
["<" | ">"]		{ token = "Relational operator"; }
"program"		{ token = "Keyword"; }
[ \t\r\n]		/* Ignore */

%%

int yywrap() { }

int main(int length, char **args) {
	if (length > 1) {
		FILE *fp;
		fp = fopen(args[1], "r");
		yyin = fp;
	
		yylex();
		printf(token);
		line++;
		return 0;
	}
	else {
		printf("Input file not found!");
		return 1;
	}
}
