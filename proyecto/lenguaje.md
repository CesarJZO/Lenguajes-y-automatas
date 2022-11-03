# Lenguaje de prueba

## Identificador

```l
[a-zA-Z_][a-zA-Z0-9_]*
```

## Operadores aritméticos

- `+` Suma
- `-` Resta
- `*` Multiplicación
- `/` División

## Operadores lógicos

- `&` And
- `|` Or
- `~` Not

## Operadores relacionales

- `<` Menor que
- `>` Mayor que
- `<=` Menor igual
- `>=` Mayor igual
- `=` Comparación

## Delimitadores

- `(`
- `)`
- `;`
- `,`
- `:`

## Números

- `[0-9]+` Enteros
- `[0-9]+"."[0-9]+` Reales

## Asignación

```l
<-
```

## Comentarios

```l
":)".+[ \n\r]
```

## Documentación

```l
"</>".+"</>"
```

## Palabras reservadas

- `fun`
- `return`
- `int`
- `dec`
- `bool`
- `true`
- `false`
- `txt`
- `while`
- `for`
- `var`
- `if`
- `else`
- `char`
- `is`
- `null`
