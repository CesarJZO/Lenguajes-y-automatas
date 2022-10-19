#include <stdio.h>
#include <lex_table.h>

void printTableS(int occurrence, char *token, char *lexeme, int line)
{
    printf(
        "| Occurrence | Token          | Lexeme     | Line |\n"
        "+------------+----------------+------------+------+\n"
    );
    for (int i = 0; i < occurrences; i++)
    {
        printf(
            "| %-11d| %-15s| %-15s| %-5d|\n", occurrence, token, lexeme, line
        );
    }
}

void printTableN(int occurrence, int token, char * lexeme, int line)
{
    printf(
        "| Occurrence | Token | Lexeme     | Line |\n"
        "+------------+-------+------------+------+\n"
    );
    for (int i = 0; i < occurrences; i++)
    {
        printf(
            "| %-11d| %-6d| %-15s| %-5d|\n", occurrence, token, lexeme, line
        );
    }
}

void printHeader()
{
    printf(
        "| Occurrence | Token | Lexeme     | Line |\n"
        "|------------|-------|------------|------+\n"
    );
}

int printRow(int token, char *lexeme)
{
    printf(
        "| %-11d| %-6d| %-15s| %-5d|\n", occurrences, token, lexeme, lines
    );
    occurrences++;
    return token;
}
