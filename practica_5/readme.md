# Práctica 5: Análisis sintáctico

## Compilación

```bash
bison -dt syntax.y && flex -o l.c lex.l && gcc l.c syntax.tab.c -o ./compiler.out
```

```bash
./compiler.out < <source_file>
```
