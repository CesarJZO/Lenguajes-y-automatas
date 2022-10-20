# Práctica 4: Análisis léxico

Para compilar el código hay que convertir el archivo lex (`.l`) a lenguaje C (`.c`), especificando que se llame `lex.c` en este caso

```bash
flex -o lex.c lex.l
```

Después se compila el archivo generado en C para que sea ejecutable

```bash
gcc -o bin/lex lex.c
```

Y se usa el ejecutable usando como argumento el nombre de un archivo de texto plano

```bash
./bin/lex test_program.la
```

O bien, todos al mismo tiempo

```bash
flex -o lex.c lex.l; gcc -o ./bin/lex lex.c; ./bin/lex test_program.la
```

En caso de usar el programa que muestra los tokens con por su nombre, se compila el archivo `lexs.l`

```bash
flex -o lexs.c lexs.l; gcc -o ./bin/lexs lexs.c; ./bin/lexs test_program.la
```
