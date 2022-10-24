/* Definition section */
%{

int occurrences = 1;
int lines = 1;

FILE *ep;
int errorOccurrences = 1;

void printRow(char *token, char *lexeme, int color);
void writeErrorRow(char *lexeme, char *desc);

#define ANSI_RED          "\x1b[31m"
#define ANSI_RESET        "\x1b[0m"

#define GRAY              2
#define RED               31
#define GREEN             32
#define YELLOW            33
#define BLUE              34
#define MAGENTA           35
#define CYAN              36
#define AUTO              0

%}

/* Rule section */
%%

[ \t\r] /* no action: ignore all white space */

"&"[a-zA-Z]+"_"{0,1}[0-9]* { printRow("identifier", yytext, GREEN); }

"-"             { printRow("subtraction",       yytext,    CYAN); }
"+"             { printRow("addition",          yytext,    CYAN); }
"/"             { printRow("division",          yytext,    CYAN); }
"*"             { printRow("multiplication",    yytext,    CYAN); }

"<"             { printRow("less than",         yytext,    BLUE); }
">"             { printRow("greater than",      yytext,    BLUE); }
"<="            { printRow("less equal",        yytext,    BLUE); }
">="            { printRow("greater equal",     yytext,    BLUE); }
"=="            { printRow("comparison",        yytext,    BLUE); }

"&"             { printRow("and",               yytext,    BLUE); }
"|"             { printRow("or",                yytext,    BLUE); }
"~"             { printRow("not",               yytext,    BLUE); }

"program"       { printRow("keyword",           yytext, MAGENTA); }
"begin"         { printRow("keyword",           yytext, MAGENTA); }
"end"           { printRow("keyword",           yytext, MAGENTA); }
"input"         { printRow("keyword",           yytext, MAGENTA); }
"output"        { printRow("keyword",           yytext, MAGENTA); }
"integer"       { printRow("keyword",           yytext, MAGENTA); }
"real"          { printRow("keyword",           yytext, MAGENTA); }
"char"          { printRow("keyword",           yytext, MAGENTA); }
"string"        { printRow("keyword",           yytext, MAGENTA); }
"boolean"       { printRow("keyword",           yytext, MAGENTA); }
"if"            { printRow("keyword",           yytext, MAGENTA); }
"else"          { printRow("keyword",           yytext, MAGENTA); }
"then"          { printRow("keyword",           yytext, MAGENTA); }
"while"         { printRow("keyword",           yytext, MAGENTA); }
"do"            { printRow("keyword",           yytext, MAGENTA); }
"repeat"        { printRow("keyword",           yytext, MAGENTA); }
"until"         { printRow("keyword",           yytext, MAGENTA); }
"var"           { printRow("keyword",           yytext, MAGENTA); }
"true"          { printRow("keyword",           yytext, MAGENTA); }
"false"         { printRow("keyword",           yytext, MAGENTA); }

"("             { printRow("open parenthesis",  yytext,    AUTO); }
")"             { printRow("close parenthesis", yytext,    AUTO); }
";"             { printRow("semicolon",         yytext,    AUTO); }
","             { printRow("comma",             yytext,    AUTO); }
":"             { printRow("colon",             yytext,    AUTO); }
"="             { printRow("equals",            yytext,    AUTO); }

"//".+"//"      { printRow("comment",           yytext,    GRAY); }

[0-9]+          { printRow("integer",           yytext,  YELLOW); }

\n              { lines++; }

.               { writeErrorRow(yytext,         "Invalid token"); }

%%

void printRow(char *token, char *lexeme, int color)
{
    printf(
        "| %-11d| %-18s|\x1b[%dm %-17s" ANSI_RESET "| %-5d|\n",
        occurrences, token, color, lexeme, lines
    );
    occurrences++;
}

void writeErrorRow(char *lexeme, char *description)
{
    fprintf(ep,
        "| %-11d|" ANSI_RED " %-15s" ANSI_RESET "| %-20s| %-5d|\n",
        errorOccurrences, lexeme, description, lines
    );
    errorOccurrences++;
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
        "| Occurrence | Token             | Lexeme           | Line |\n"
        "|------------|-------------------|------------------|------|\n"
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
    
    ep = fopen("./errors.tmp", "r");
    char ch;
    while ((ch = fgetc(ep)) != EOF)
        putchar(ch);
    fclose(ep);

    remove("./errors.tmp");
    printf("\n");

    return 0;
}
