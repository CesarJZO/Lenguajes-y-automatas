/* Definition section */
%{

int occurrences = 1;
int lines = 1;

void printRow(int token, char *lexeme);

#define RED               "\x1b[31m"
#define GREEN             "\x1b[32m"
#define MAGENTA           "\x1b[35m"
#define RESET             "\x1b[0m"

#define IDENTIFIER        97

#define SUBTRACT_OP       89
#define ADDITION_OP       88
#define DIVISION_OP       91
#define MULTIPLY_OP       90

#define GREATER_THAN      94
#define SMALLER_THAN      92
#define LESS_EQUAL        93
#define MORE_EQUAL        95
#define COMPARISON        107

#define AND_OP            98
#define OR_OP             99
#define NOT_OP            100

#define PROGRAM_KEYWORD	  53
#define BEGIN_KEYWORD     5
#define END_KEYWORD       23
#define INPUT_KEYWORD	  34
#define OUTPUT_KEYWORD	  46
#define INTEGER_KEYWORD	  40
#define REAL_KEYWORD	  57
#define CHAR_KEYWORD	  15
#define STRING_KEYWORD	  67
#define BOOLEAN_KEYWORD	  11
#define IF_KEYWORD        30
#define	ELSE_KEYWORD	  21
#define THEN_KEYWORD	  71
#define WHILE_KEYWORD	  87
#define DO_KEYWORD        17
#define REPEAT_KEYWORD	  61
#define UNTIL_KEYWORD	  79
#define VAR_KEYWORD       82
#define	TRUE_KEYWORD	  74
#define FALSE_KEYWORD	  28

#define OPEN_PARENTHESIS  101
#define CLOSE_PARENTHESIS 102
#define SEMICOLON         103
#define COLON             105
#define COMMA             104
#define EQUALS            106

#define COMMENT           112

#define INTEGER           108

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

"//".+"//"      { printRow(COMMENT, yytext); }

[0-9]+          { printRow(INTEGER, yytext); }

\n              { lines++; }

. { printf(RED "Error: " MAGENTA "%s" RESET " is not a valid token\n", yytext); }

%%

void printRow(int token, char *lexeme)
{
    printf(
        "| %-11d| %-6d| %-15s| %-5d|\n", occurrences, token, lexeme, lines
    );
    occurrences++;
}

int yywrap() { }

int main(int length, char **args)
{
    if (length == 1)
    {
        printf(RED "Error: " RESET "You need to provide a file to be read\n");
        return 1;
    }

    FILE *fp;
    fp = fopen(args[1], "r");
    yyin = fp;

    printf(
        "| Occurrence | Token | Lexeme         | Line |\n"
        "|------------|-------|----------------|------|\n"
    );

    yylex();

    printf("\n");

    return 0;
}
