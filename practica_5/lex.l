%{

int occurrences = 1;
int lines = 1;

FILE *ep;
int errorOccurrences = 1;

void writeErrorRow(char *lexeme, char *desc);
void printRow(int token, char *lexeme, int color);

#define ANSI_RED          "\x1b[31m"
#define ANSI_GREEN        "\x1b[32m"
#define ANSI_MAGENTA      "\x1b[35m"
#define ANSI_RESET        "\x1b[0m"

#define GRAY              2
#define RED               31
#define GREEN             32
#define YELLOW            33
#define BLUE              34
#define MAGENTA           35
#define CYAN              36
#define AUTO              0

#define IDENTIFIER        -61

#define SUBTRACT_OP       -32
#define ADDITION_OP       -31
#define DIVISION_OP       -34
#define MULTIPLY_OP       -33

#define GREATER_THAN      -43
#define SMALLER_THAN      -41
#define LESS_EQUAL        -42
#define MORE_EQUAL        -44
#define COMPARISON        -45

#define AND_OP            -46
#define OR_OP             -47
#define NOT_OP            -48

#define PROGRAM_KEYWORD	  -12
#define BEGIN_KEYWORD     -1
#define END_KEYWORD       -6
#define INPUT_KEYWORD	  -9
#define OUTPUT_KEYWORD	  -11
#define INTEGER_KEYWORD	  -10
#define REAL_KEYWORD	  -13
#define CHAR_KEYWORD	  -3
#define STRING_KEYWORD	  -15
#define BOOLEAN_KEYWORD	  -2
#define IF_KEYWORD        -8
#define	ELSE_KEYWORD	  -5
#define THEN_KEYWORD	  -16
#define WHILE_KEYWORD	  -20
#define DO_KEYWORD        -4
#define REPEAT_KEYWORD	  -14
#define UNTIL_KEYWORD	  -18
#define VAR_KEYWORD       -19
#define	TRUE_KEYWORD	  -17
#define FALSE_KEYWORD	  -7

#define OPEN_PARENTHESIS  -81
#define CLOSE_PARENTHESIS -82
#define SEMICOLON         -83
#define COLON             -85
#define COMMA             -84
#define EQUALS            -86

#define COMMENT           -70

#define INTEGER           -71

%}

%%

[ \t\r]

"&"[a-zA-Z]+"_"{0,1}[0-9]* { printRow(IDENTIFIER, yytext, GREEN); }

"-"             { printRow(SUBTRACT_OP,       yytext,    CYAN); }
"+"             { printRow(ADDITION_OP,       yytext,    CYAN); }
"/"             { printRow(DIVISION_OP,       yytext,    CYAN); }
"*"             { printRow(MULTIPLY_OP,       yytext,    CYAN); }

"<"             { printRow(SMALLER_THAN,      yytext,    BLUE); }
">"             { printRow(GREATER_THAN,      yytext,    BLUE); }
"<="            { printRow(LESS_EQUAL,        yytext,    BLUE); }
">="            { printRow(MORE_EQUAL,        yytext,    BLUE); }
"=="            { printRow(COMPARISON,        yytext,    BLUE); }

"&"             { printRow(AND_OP,            yytext,    BLUE); }
"|"             { printRow(OR_OP,             yytext,    BLUE); }
"~"             { printRow(NOT_OP,            yytext,    BLUE); }

"program"       { printRow(PROGRAM_KEYWORD,   yytext, MAGENTA); }
"begin"         { printRow(BEGIN_KEYWORD,     yytext, MAGENTA); }
"end"           { printRow(END_KEYWORD,       yytext, MAGENTA); }
"input"         { printRow(INPUT_KEYWORD,     yytext, MAGENTA); }
"output"        { printRow(OUTPUT_KEYWORD,    yytext, MAGENTA); }
"integer"       { printRow(INTEGER_KEYWORD,   yytext, MAGENTA); }
"real"          { printRow(REAL_KEYWORD,      yytext, MAGENTA); }
"char"          { printRow(CHAR_KEYWORD,      yytext, MAGENTA); }
"string"        { printRow(STRING_KEYWORD,    yytext, MAGENTA); }
"boolean"       { printRow(BOOLEAN_KEYWORD,   yytext, MAGENTA); }
"if"            { printRow(IF_KEYWORD,        yytext, MAGENTA); }
"else"          { printRow(ELSE_KEYWORD,      yytext, MAGENTA); }
"then"          { printRow(THEN_KEYWORD,      yytext, MAGENTA); }
"while"         { printRow(WHILE_KEYWORD,     yytext, MAGENTA); }
"do"            { printRow(DO_KEYWORD,        yytext, MAGENTA); }
"repeat"        { printRow(REPEAT_KEYWORD,    yytext, MAGENTA); }
"until"         { printRow(UNTIL_KEYWORD,     yytext, MAGENTA); }
"var"           { printRow(VAR_KEYWORD,       yytext, MAGENTA); }
"true"          { printRow(TRUE_KEYWORD,      yytext, MAGENTA); }
"false"         { printRow(FALSE_KEYWORD,     yytext, MAGENTA); }

"("             { printRow(OPEN_PARENTHESIS,  yytext,    AUTO); }
")"             { printRow(CLOSE_PARENTHESIS, yytext,    AUTO); }
";"             { printRow(SEMICOLON,         yytext,    AUTO); }
","             { printRow(COMMA,             yytext,    AUTO); }
":"             { printRow(COLON,             yytext,    AUTO); }
"="             { printRow(EQUALS,            yytext,    AUTO); }

"//".+"//"      { printRow(COMMENT,           yytext,    GRAY); }

[0-9]+          { printRow(INTEGER,           yytext,  YELLOW); }

\n              { lines++; }

.               { writeErrorRow(yytext,    "Unexpected token"); }

%%

void writeErrorRow(char *lexeme, char *description)
{
    fprintf(ep,
        "| %-11d|" ANSI_RED " %-15s" ANSI_RESET "| %-20s| %-5d|\n",
        errorOccurrences, lexeme, description, lines
    );
    errorOccurrences++;
}

void printRow(int token, char *lexeme, int color)
{
    printf(
        "| %-11d| %-6d|\x1b[%dm %-29s" ANSI_RESET "| %-5d|\n",
        occurrences, token, color, lexeme, lines
    );
    occurrences++;
}

int yywrap() { }

int main(int length, char **args)
{
    if (length == 1)
    {
        printf(ANSI_RED "Error: " ANSI_RESET "You need to provide a file to be read\n");
        return 1;
    }

    FILE *fp;
    fp = fopen(args[1], "r");
    yyin = fp;

    printf(
        "|--------------------------Tokens--------------------------|\n"
        "| Occurrence | Token | Lexeme                       | Line |\n"
        "|------------|-------|------------------------------|------|\n"
    );

    ep = fopen("./errors.tmp", "w");

    fprintf(ep, "\n"
        "|--------------------------Errors--------------------------|\n"
        "| Occurrence | Lexeme         | Description         | Line |\n"
        "|------------|----------------|---------------------|------|\n"
    );

    yylex();
    
    fclose(ep);
    fclose(fp);
    
    if (errorOccurrences == 1) {
    	remove("./errors.tmp");
		return 0;
	}

    ep = fopen("./errors.tmp", "r");
    char ch;
    while ((ch = fgetc(ep)) != EOF)
        putchar(ch);
    fclose(ep);

    remove("./errors.tmp");
    printf("\n");

    return 0;
}
