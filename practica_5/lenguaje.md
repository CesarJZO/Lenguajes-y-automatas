# Estructura del lenguaje de prueba

## Palabras reservadas

- `program`
- `var`
- `integer`
- `boolean`
- `begin`
- `end`
- `if`
- `then`
- `else`
- `input`
- `output`
- `while`
- `do`
- `repeat`
- `until`

## Identificadores

```c
"#"[a-z]+
```

## Delimitadores

- `:`
- `;`

## Asignación

- `:=`

## Enteros

```c
[0-9]+
```

## Operadores aritméticos

- `+`
- `*`
- `-`
- `/`

## Operadores relacionales

- `>`
- `<`
- `>=`
- `<=`
- `=`

## Sintaxis

### head

Palabra reservada `program` seguida de un **identificador** seguido de un `;` (fin de sentencia)

```
program #nombre;
```

### variables

Palabra reservada `var` inicia el bloque, puede contener cero o mas **variables**

```
#uno, #dos : integer;
#tres : boolean;
```

### code

Palabra reservada `begin` seguida de cero o mas **expresiones**
