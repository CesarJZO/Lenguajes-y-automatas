# Práctica 4: Análisis léxico

## Bash

Primero hay que preparar las carpetas necesarias para almacenar los códigos generados y los ejecutables

```bash
mkdir c bin
```

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
flex -o ./c/lex.c lex.l; gcc -o ./bin/lex ./c/lex.c; ./bin/lex test_program.la
```

En caso de usar el programa que muestra los tokens con por su nombre, se compila el archivo `lexs.l`

```bash
flex -o ./c/lexs.c lexs.l; gcc -o ./bin/lexs ./c/lexs.c; ./bin/lexs test_program.la
```

## Powershell

Crear carpetas necesarias

```powershell
New-Item -Type Directory bin
New-Item -Type Directory c
```

Para mostrar la tabla con tokens numéricos

```powershell
flex.exe -o .\c\lex.c .\lex.l; gcc.exe .\c\lex.c -o .\bin\lex.exe; .\bin\lex.exe .\test_program.la
```

Mostrar la tabla con tokens descriptivos

```powershell
flex.exe -o .\c\lexs.c .\lexs.l; gcc.exe .\c\lexs.c -o .\bin\lexs.exe; .\bin\lexs.exe .\test_program.la
```
