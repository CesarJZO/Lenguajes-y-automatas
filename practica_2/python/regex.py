import re

GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
RESET = '\033[0m'

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
    
    if option == '8': exit(1)

    lex = input('Componente léxico: ')

    found = False

    if option == '1':
        found = re.match('[a-z]+', lex)
    elif option == '2':
        found = re.match('', lex)
    elif option == '3':
        found = re.match('', lex)
    elif option == '4':
        found = re.match('', lex)
    elif option == '5':
        found = re.match('', lex)
    elif option == '6':
        found = re.match('', lex)
    elif option == '7':
        found = re.match('', lex)

    if found:
        print(f'{GREEN}Componente válido{RESET}')
    else:
        print(f'{RED}Componente no válido{RESET}')
