# Expresiones regulares

## Lenguaje de prueba

### Identificadores

Inicia con & seguida de una letra y puede contener más letras y/o guion bajo y/ o números

```c
"&"[a-zA-Z]+"_"{0,1}[0-9]*
```

### Operadores aritméticos

- `"-"` Resta
- `"+"` Suma
- `"/"` División
- `"*"` Multiplicación

### Operadores relacionales

- `"<"` Menor que
- `">"` Mayor que
- `"<="` Menor igual
- `">="` Mayor igual
- `"=="` Comparación

### Operadores lógicos

- `"&"` And
- `"|"` Or
- `"~"` Not

### Palabras reservadas

- `"program"`
- `"begin"`
- `"end"`
- `"input"`
- `"output"`
- `"integer"`
- `"real"`
- `"char"`
- `"string"`
- `"boolean"`
- `"if"`
- `"else"`
- `"then"`
- `"while"`
- `"do"`
- `"repeat"`
- `"until"`
- `"var"`
- `"true"`
- `"false"`

### Caracteres especiales

- `"("` Paréntesis de apertura
- `")"` Paréntesis de cierre
- `";"` Punto y coma
- `","` Coma
- `":"` Dos puntos
- `"="` Igual

### Comentarios

Inician y terminan con `//` y pueden contener cualquier otro carácter o estar vacío separado al menos de un espacio

```c
"//".+"//"
```

### Números enteros

Cualquier cantidad entera que no incluya negativos

```c
[0-9]+
```

### Caracteres especiales que no generan token

- `.` Punto
- `\s` Espacio en blanco
- `\t` Tabulación
- `\n` Final de línea
- `\f` Final de archivo

## Tabla de tokens

```md
| Occurrence | Token | Lexeme         | Line |
|------------|-------|----------------|------|
| 1          | 14    | program        | 1    |
| 2          | 19    | integer        | 2    |
| 3          | 1     | &result1       | 2    |
| 4          | 39    | =              | 2    |
| 5          | 34    | (              | 2    |
```

## Tabla de errores

```md
|--------------------------Errors--------------------------|
| Occurrence | Lexeme         | Description         | Line |
|------------|----------------|---------------------|------|
| 1          | 14             | Word not recognized | 1    |
| 2          | 19             | integer             | 2    |
| 3          | 1              | &result1            | 2    |
| 4          | 39             | =                   | 2    |
| 5          | 34             | (                   | 2    |
```
