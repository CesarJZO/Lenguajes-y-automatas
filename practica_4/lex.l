/* Definition section */
%{

int occurrences = 1;
int lines = 1;

void printRow(int token, char *lexeme);

#define IDENTIFIER	1
#define SUBTRACT_OP	2
#define ADDITION_OP	3
#define DIVISION_OP	4
#define MULTIPLY_OP	5
#define GREATER_THAN	6
#define SMALLER_THAN	7
#define LESS_EQUAL	8
#define MORE_EQUAL	9
#define COMPARISON	10
#define AND_OP		11
#define OR_OP		12
#define NOT_OP		13
#define PROGRAM_KEYWORD	14
#define BEGIN_KEYWORD 	15
#define END_KEYWORD	16
#define INPUT_KEYWORD	17
#define OUTPUT_KEYWORD	18
#define INTEGER_KEYWORD	19
#define REAL_KEYWORD	20
#define CHAR_KEYWORD	21
#define STRING_KEYWORD	22
#define BOOLEAN_KEYWORD	23
#define IF_KEYWORD	24
#define	ELSE_KEYWORD	25
#define THEN_KEYWORD	26
#define WHILE_KEYWORD	27
#define DO_KEYWORD	28
#define REPEAT_KEYWORD	29
#define UNTIL_KEYWORD	30
#define VAR_KEYWORD	31
#define	TRUE_KEYWORD	32
#define FALSE_KEYWORD	33

%}

/* Rule section */
%%

"&"[a-zA-Z]+"_"{1}[0-9]+ { return printRow(IDENTIFIER, yytext); }

"-" 	{ return printRow(SUBTRACT_OP, yytext); }
"+"	    { return printRow(ADDITION_OP, yytext); }
"/"	    { return printRow(DIVISION_OP, yytext); }
"*"	    { return printRow(MULTIPLY_OP, yytext); }

"<"	    { return printRow(SMALLER_THAN, yytext); }
">"	    { return printRow(GREATER_THAN, yytext); }
"<="	{ return printRow(LESS_EQUAL, yytext); 	 }
">="	{ return printRow(MORE_EQUAL, yytext); 	 }
"=="	{ return printRow(COMPARISON, yytext); 	 }

"&"	{ return printRow(AND_OP, yytext); }
"|"	{ return printRow(OR_OP, yytext);  }
"~"	{ return printRow(NOT_OP, yytext); }

"program"       { return printRow(PROGRAM_KEYWORD, yytext); }
"begin" 	    { return printRow(BEGIN_KEYWORD, yytext);   }
"end"           { return printRow(END_KEYWORD, yytext);     }
"input"         { return printRow(INPUT_KEYWORD, yytext);   }
"output"        { return printRow(OUTPUT_KEYWORD, yytext);  }
"integer"       { return printRow(INTEGER_KEYWORD, yytext); }
"real"          { return printRow(REAL_KEYWORD, yytext);    }
"char"          { return printRow(CHAR_KEYWORD, yytext);    }
"string"        { return printRow(STRING_KEYWORD, yytext);  }
"boolean"       { return printRow(BOOLEAN_KEYWORD, yytext); }
"if"            { return printRow(IF_KEYWORD, yytext);      }
"else"          { return printRow(ELSE_KEYWORD, yytext);    }
"then"          { return printRow(THEN_KEYWORD, yytext);    }
"while"         { return printRow(WHILE_KEYWORD, yytext);   }
"do"            { return printRow(DO_KEYWORD, yytext);      }
"repeat"        { return printRow(REPEAT_KEYWORD, yytext);  }
"until"         { return printRow(UNTIL_KEYWORD, yytext);   }
"var"           { return printRow(VAR_KEYWORD, yytext);     }
"true"          { return printRow(TRUE_KEYWORD, yytext);    }
"false"         { return printRow(FALSE_KEYWORD, yytext);   }

\n    { lines++; }

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
    FILE *fp;
    fp = fopen(args[1], "r");
    yyin = fp;

    printf(
        "| Occurrence | Token | Lexeme         | Line |\n"
        "+------------+-------+----------------+------+\n"
    );

    int token = yylex();
}
