%{

int line = 1;

%}

%%

program   { return PROGRAM_KW; }
var       { return VAR_KW;     }
integer   { return INTEGER_KW; }
boolean   { return BOOLEAN_KW; }
begin	  { return BEGIN_KW;   }
end		  { return END_KW;     }
if        { return IF_KW;      }
then      { return THEN_KW;    }
else      { return ELSE_KW;    }
input	  { return INPUT_KW;   }
output    { return OUTPUT_KW;  }
while     { return WHILE_KW;   }
do        { return DO_KW;      }
repeat    { return REPEAT_KW;  }
until     { return UNTIL_KW;   }

"#"[a-z]+ { return IDENTIFIER; }

":"       { return DATA_TYPE;  }
";"       { return DELIMITER;  }

":="      { return ASSIGNER;   }

[0-9]+    { return INTEGER;    }

"+"       { return ADD_OP;     }
"-"       { return SUB_OP;     }
"*"       { return MUL_OP;     }
"/"       { return DIV_OP;     }

">"       { return MORE_THAN;  }
"<"       { return LESS_THAN;  }
">="      { return MORE_EQUAL;  }
"<="      { return LESS_EQUAL; }
"="       { return EQUAL_TO;   }

\n        { line++;            }

.         { yyerror(yytext);   }

%%
