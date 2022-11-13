# Práctica 5: Análisis sintáctico

## Compilación

```bash
flex -o l.c lex.l && bison -dt syntax.y && gcc l.c syntax.tab.c -o ./compiler.out
```
