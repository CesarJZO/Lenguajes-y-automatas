%{
#include "syntax.tab.h"
%}

%%

[ \t\r\n]       { }

"+"             { return ADD_OP;     }
"-"             { return SUB_OP;     }
"*"             { return MUL_OP;     }
"/"             { return DIV_OP;     }

">"             { return MORE_THAN;  }
"<"             { return LESS_THAN;  }
">="            { return MORE_EQUAL; }
"<="            { return LESS_EQUAL; }
"="             { return EQUAL_TO;   }

"&"             { return AND_OP;     }
"|"             { return OR_OP;      }
"~"             { return NOT_OP;     }

"fun"           { return FUN_KW;     }
"return"        { return RETURN_KW;  }
"int"           { return INT_KW;     }
"dec"           { return DEC_KW;     }
"txt"           { return TXT_KW;     }
"char"          { return CHAR_KW;    }
"bool"          { return BOOL_KW;    }
"true"          { return TRUE_KW;    }
"false"         { return FALSE_KW;   }
"if"            { return IF_KW;      }
"else"          { return ELSE_KW;    }
"while"         { return WHILE_KW;   }
"for"           { return FOR_KW;     }
"var"           { return VAR_KW;     }
"is"            { return IS_KW;      }
"null"          { return NULL_KW;    }

[a-z][a-zA-Z0-9_]*  { return FUNCTION_NAME; }
[a-z_][a-zA-Z0-9_]* { return IDENTIFIER;    }

"("             { return OPEN_PAR;    }
")"             { return CLOSE_PAR;   }
";"             { return SEMICOLON;   }
","             { return COMMA;       }
"{"             { return OPEN_BLOCK;  }
"}"             { return CLOSE_BLOCK; }

"<-"            { return ASSIGNER;    }

":)".+          { }
"</>".+"</>"    { }

[0-9]+          { return INTEGER; }
[0-9]+"."[0-9]+ { return REAL; }
"\'".*"\'"      { return TEXT; }

.               { printf("Lexical error\n"); }

%%

int yywrap() { }
