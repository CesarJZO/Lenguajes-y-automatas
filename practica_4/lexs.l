/* Definition section */
%{

int occurrences = 1;
int lines = 1;

void printRow(char *token, char *lexeme);

#define RED               "\x1b[31m"
#define GREEN             "\x1b[32m"
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

"&"[a-zA-Z]+"_"{0,1}[0-9]* { printRow("Identifier", yytext); }

"-"             { printRow("Subtraction",       yytext); }
"+"             { printRow("Addition",       yytext); }
"/"             { printRow("Division",       yytext); }
"*"             { printRow("Multiplication",       yytext); }

"<"             { printRow("Less than",      yytext); }
">"             { printRow("Greater than",      yytext); }
"<="            { printRow("Less equal",        yytext); }
">="            { printRow("Greater equal",        yytext); }
"=="            { printRow("Comparison",        yytext); }

"&"             { printRow("And",            yytext); }
"|"             { printRow("Or",             yytext); }
"~"             { printRow("Not",            yytext); }

"program"       { printRow("Keyword",   yytext); }
"begin"         { printRow("Keyword",     yytext); }
"end"           { printRow("Keyword",       yytext); }
"input"         { printRow("Keyword",     yytext); }
"output"        { printRow("Keyword",    yytext); }
"integer"       { printRow("Keyword",   yytext); }
"real"          { printRow("Keyword",      yytext); }
"char"          { printRow("Keyword",      yytext); }
"string"        { printRow("Keyword",    yytext); }
"boolean"       { printRow("Keyword",   yytext); }
"if"            { printRow("Keyword",        yytext); }
"else"          { printRow("Keyword",      yytext); }
"then"          { printRow("Keyword",      yytext); }
"while"         { printRow("Keyword",     yytext); }
"do"            { printRow("Keyword",        yytext); }
"repeat"        { printRow("Keyword",    yytext); }
"until"         { printRow("Keyword",     yytext); }
"var"           { printRow("Keyword",       yytext); }
"true"          { printRow("Keyword",      yytext); }
"false"         { printRow("Keyword",     yytext); }

"("             { printRow("Open parenthesis",  yytext); }
")"             { printRow("Close parenthesis", yytext); }
";"             { printRow("Semicolon",         yytext); }
","             { printRow("Comma",             yytext); }
":"             { printRow("Colon",             yytext); }
"="             { printRow("Equals",            yytext); }

"//"([.|" "])+"//" { printRow("Comment", yytext); }

[0-9]+          { printRow("Integer", yytext); }

\n              { lines++; }

%%

void printRow(char *token, char *lexeme)
{
    printf(
        "| %-11d| %-18s| %-15s| %-5d|\n", occurrences, token, lexeme, lines
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
        "| Occurrence | Token             | Lexeme         | Line |\n"
        "|------------|-------------------|----------------|------|\n"
    );

    yylex();

    printf("\n");

    return 0;
}
