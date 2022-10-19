# Expresiones regulares

## Lenguaje de prueba

### Identificadores

Inicia con & seguida de una letra y puede contener más letras y/o guion bajo y/ o números

```
&[a-Z]+[_]*[0-9]*
```

### Operadores aritméticos

Resta, suma, división y multiplicación

```
[-|+|/|*]
```

### Operadores relacionales

- `<` Menor que
- `\>` Mayor que
- `<=` Menor igual
- `\>=` Mayor igual
- `==` Comparación

```
[<|>|<=|>=|==]
```

### Operadores lógicos

- `&` And
- `|` Or
- `~` Not

```
[&|||~]
```

### Palabras reservadas

- `program`
- `begin`
- `end`
- `input`
- `output`
- `integer`
- `real`
- `char`
- `string`
- `boolean`
- `if`
- `else`
- `then`
- `while`
- `do`
- `repeat`
- `until`
- `var`
- `true`
- `false`

```
program|begin|end|input|output|real|char|string|boolean|if|else|then|while|do|repeat|until|var|true|false
```
### Caracteres especiales

- `(` Paréntesis de apertura
- `)` Paréntesis de cierre
- `;` Punto y coma
- `,` Coma
- `:` Dos puntos
- `=` Igual

### Comentarios

Inician y terminan con `//` y pueden contener cualquier otro carácter o estar vacío separado al menos de un espacio

```
//.+|\s//
```

### Números enteros

Cualquier cantidad entera que no incluya negativos

```
[0-9]+
```

### Caracteres especiales que no generan token

- `.` Punto
- `\s` Espacio en blanco
- `\t` Tabulación
- `\n` Final de línea
- `\f` Final de archivo