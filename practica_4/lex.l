/* Definition section */
%{

int occurrences = 1;
int lines = 1;

FILE *ep;

void writeErrorRow(char *token);
void printRow(int token, char *lexeme);

#define RED               "\x1b[31m"
#define GREEN             "\x1b[32m"
#define MAGENTA           "\x1b[35m"
#define RESET             "\x1b[0m"

#define IDENTIFIER        1

#define SUBTRACT_OP       2
#define ADDITION_OP       3
#define DIVISION_OP       4
#define MULTIPLY_OP       5

#define GREATER_THAN      6
#define SMALLER_THAN      7
#define LESS_EQUAL        8
#define MORE_EQUAL        9
#define COMPARISON        10

#define AND_OP            11
#define OR_OP             12
#define NOT_OP            13

#define PROGRAM_KEYWORD	  14
#define BEGIN_KEYWORD     15
#define END_KEYWORD       16
#define INPUT_KEYWORD	  17
#define OUTPUT_KEYWORD	  18
#define INTEGER_KEYWORD	  19
#define REAL_KEYWORD	  20
#define CHAR_KEYWORD	  21
#define STRING_KEYWORD	  22
#define BOOLEAN_KEYWORD	  23
#define IF_KEYWORD        24
#define	ELSE_KEYWORD	  25
#define THEN_KEYWORD	  26
#define WHILE_KEYWORD	  27
#define DO_KEYWORD        28
#define REPEAT_KEYWORD	  29
#define UNTIL_KEYWORD	  30
#define VAR_KEYWORD       31
#define	TRUE_KEYWORD	  32
#define FALSE_KEYWORD	  33

#define OPEN_PARENTHESIS  34
#define CLOSE_PARENTHESIS 35
#define SEMICOLON         36
#define COLON             37
#define COMMA             38
#define EQUALS            39

#define COMMENT           40

#define INTEGER           41

%}

/* Rule section */
%%

[ \t\r] /* no action: ignore all white space */

"&"[a-zA-Z]+"_"{0,1}[0-9]* { printRow(IDENTIFIER, yytext); }

"-"             { printRow(SUBTRACT_OP,       yytext); }
"+"             { printRow(ADDITION_OP,       yytext); }
"/"             { printRow(DIVISION_OP,       yytext); }
"*"             { printRow(MULTIPLY_OP,       yytext); }

"<"             { printRow(SMALLER_THAN,      yytext); }
">"             { printRow(GREATER_THAN,      yytext); }
"<="            { printRow(LESS_EQUAL,        yytext); }
">="            { printRow(MORE_EQUAL,        yytext); }
"=="            { printRow(COMPARISON,        yytext); }

"&"             { printRow(AND_OP,            yytext); }
"|"             { printRow(OR_OP,             yytext); }
"~"             { printRow(NOT_OP,            yytext); }

"program"       { printRow(PROGRAM_KEYWORD,   yytext); }
"begin"         { printRow(BEGIN_KEYWORD,     yytext); }
"end"           { printRow(END_KEYWORD,       yytext); }
"input"         { printRow(INPUT_KEYWORD,     yytext); }
"output"        { printRow(OUTPUT_KEYWORD,    yytext); }
"integer"       { printRow(INTEGER_KEYWORD,   yytext); }
"real"          { printRow(REAL_KEYWORD,      yytext); }
"char"          { printRow(CHAR_KEYWORD,      yytext); }
"string"        { printRow(STRING_KEYWORD,    yytext); }
"boolean"       { printRow(BOOLEAN_KEYWORD,   yytext); }
"if"            { printRow(IF_KEYWORD,        yytext); }
"else"          { printRow(ELSE_KEYWORD,      yytext); }
"then"          { printRow(THEN_KEYWORD,      yytext); }
"while"         { printRow(WHILE_KEYWORD,     yytext); }
"do"            { printRow(DO_KEYWORD,        yytext); }
"repeat"        { printRow(REPEAT_KEYWORD,    yytext); }
"until"         { printRow(UNTIL_KEYWORD,     yytext); }
"var"           { printRow(VAR_KEYWORD,       yytext); }
"true"          { printRow(TRUE_KEYWORD,      yytext); }
"false"         { printRow(FALSE_KEYWORD,     yytext); }

"("             { printRow(OPEN_PARENTHESIS,  yytext); }
")"             { printRow(CLOSE_PARENTHESIS, yytext); }
";"             { printRow(SEMICOLON,         yytext); }
","             { printRow(COMMA,             yytext); }
":"             { printRow(COLON,             yytext); }
"="             { printRow(EQUALS,            yytext); }

"//".+"//"      { printRow(COMMENT,           yytext); }

[0-9]+          { printRow(INTEGER,           yytext); }

\n              { lines++; }

.               { writeErrorRow(yytext); }

%%

void writeErrorRow(char *token)
{
    fputs("| ", ep);
    fputs(token, ep);
    fputs("", ep);
}

void printRow(int token, char *lexeme)
{
    printf(
        "| %-11d| %-6d| %-15s| %-5d|\n", occurrences, token, lexeme, lines
    );
    occurrences++;
}

void printErrorTable()
{
    printf(
        "|--------------------------Errors--------------------------|\n"
        "| Occurrence | Lexeme         | Description         | Line |\n"
        "|------------|----------------|---------------------|------|\n"
    );

    for
}

int yywrap() { }

int main(int length, char **args)
{
    if (length == 1)
    {
        perror(RED "Error: " RESET "You need to provide a file to be read\n");
        return 1;
    }

    FILE *fp;
    fp = fopen(args[1], "r");
    yyin = fp;

    ep = fopen("./errors.tmp", "w");

    printf(
        "| Occurrence | Token | Lexeme         | Line |\n"
        "|------------|-------|----------------|------|\n"
    );

    yylex();

    fclose(ep);
    remove("./errors.tmp");

    printf("\n");

    return 0;
}
