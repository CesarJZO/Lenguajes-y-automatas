%{
#include "syntax.tab.h"
int line = 1;
%}

%%

"//".+      { }
[ \t\r]     { }
\n          { line++; }

"program"   { return PROGRAM_KW; }
"var"       { return VAR_KW;     }
"integer"   { return INTEGER_KW; }
"boolean"   { return BOOLEAN_KW; }
"true"      { return TRUE_KW;    }
"false"     { return FALSE_KW;   }
"begin"	    { return BEGIN_KW;   }
"end"		{ return END_KW;     }
"if"        { return IF_KW;      }
"then"      { return THEN_KW;    }
"else"      { return ELSE_KW;    }
"input"	    { return INPUT_KW;   }
"output"    { return OUTPUT_KW;  }
"while"     { return WHILE_KW;   }
"do"        { return DO_KW;      }
"repeat"    { return REPEAT_KW;  }
"until"     { return UNTIL_KW;   }

"#"[a-z]+   { return IDENTIFIER; }

","         { return SEPARATOR; }
":"         { return DATA_ASSIGN;}
";"         { return EOE;        } // End of expression

":="      { return ASSIGNER;   }

[0-9]+    { return INTEGER;    }

"+"       { return ADD_OP;     }
"-"       { return SUB_OP;     }
"*"       { return MUL_OP;     }
"/"       { return DIV_OP;     }

">"       { return MORE_THAN;  }
"<"       { return LESS_THAN;  }
">="      { return MORE_EQUAL; }
"<="      { return LESS_EQUAL; }
"="       { return EQUAL_TO;   }

"("       { return OPEN_PAR;  }
")"       { return CLOSE_PAR; }

.         { printf("Invalid token at line %d\n", line); return -1; }

%%

int yywrap() { }
