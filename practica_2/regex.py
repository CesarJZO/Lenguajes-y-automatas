import re

GREEN  = '\033[92m'
YELLOW = '\033[93m'
RED    = '\033[91m'
RESET  = '\033[0m'

menu = """
Analizador léxico.
    1. Identificadores
    2. Números enteros
    3. Comentarios
    4. Operadores aritméticos
    5. Operadores lógicos
    6. Operadores relacionales
    7. Palabras reservadas
    8. Salir
[1-8]: """

option = '1'

while option != '8':
    option = input(menu)
    
    if option == '8': exit(0)

    lex = input('Componente léxico: ')

    valid = False

    if option == '1':   # Identifier
        valid = re.match('[a-z]+$', lex)
    elif option == '2': # Integer
        valid = re.match('\\d+$', lex)
    elif option == '3': # Comment
        valid = re.match('^[:][)].*', lex)
    elif option == '4': # Arithmetic Operator
        valid = re.match('^([+|-|*|/])$', lex)
    elif option == '5': # Logic Operator
        valid = re.match('^([=]|[&]|[|]|[!])$', lex)
    elif option == '6': # Relational Operator
        valid = re.match('^([<]|[>])$', lex)
    elif option == '7': # Keyword
        valid = re.match('^(fun|return|num|txt|bool)$', lex)
    if option == '1' and re.match('^(fun|return|num|txt|bool)$', lex):
        valid = False

    if valid:
        print(f'{GREEN}Cadena válida{RESET}')
    else:
        print(f'{RED}Cadena no válida{RESET}')
