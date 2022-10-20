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

"-"             { printRow("subtraction",       yytext); }
"+"             { printRow("addition",          yytext); }
"/"             { printRow("division",          yytext); }
"*"             { printRow("multiplication",    yytext); }

"<"             { printRow("less than",         yytext); }
">"             { printRow("greater than",      yytext); }
"<="            { printRow("less equal",        yytext); }
">="            { printRow("greater equal",     yytext); }
"=="            { printRow("comparison",        yytext); }

"&"             { printRow("and",               yytext); }
"|"             { printRow("or",                yytext); }
"~"             { printRow("not",               yytext); }

"program"       { printRow("keyword",           yytext); }
"begin"         { printRow("keyword",           yytext); }
"end"           { printRow("keyword",           yytext); }
"input"         { printRow("keyword",           yytext); }
"output"        { printRow("keyword",           yytext); }
"integer"       { printRow("keyword",           yytext); }
"real"          { printRow("keyword",           yytext); }
"char"          { printRow("keyword",           yytext); }
"string"        { printRow("keyword",           yytext); }
"boolean"       { printRow("keyword",           yytext); }
"if"            { printRow("keyword",           yytext); }
"else"          { printRow("keyword",           yytext); }
"then"          { printRow("keyword",           yytext); }
"while"         { printRow("keyword",           yytext); }
"do"            { printRow("keyword",           yytext); }
"repeat"        { printRow("keyword",           yytext); }
"until"         { printRow("keyword",           yytext); }
"var"           { printRow("keyword",           yytext); }
"true"          { printRow("keyword",           yytext); }
"false"         { printRow("keyword",           yytext); }

"("             { printRow("open parenthesis",  yytext); }
")"             { printRow("close parenthesis", yytext); }
";"             { printRow("semicolon",         yytext); }
","             { printRow("comma",             yytext); }
":"             { printRow("colon",             yytext); }
"="             { printRow("equals",            yytext); }

"//".+"//"      { printRow("comment",           yytext); }

[0-9]+          { printRow("integer",           yytext); }

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
