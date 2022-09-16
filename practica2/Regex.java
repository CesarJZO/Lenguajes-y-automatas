package practica2;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Regex {
    static Scanner scanner;
    static String menu = """
            Analizador léxico.
                1. Identificadores
                2. Números enteros
                3. Comentarios
                4. Operadores aritméticos
                5. Operadores lógicos
                6. Operadores relacionales
                7. Palabras reservadas
                8. Salir

                """;

    public static void main(String[] args) {
        scanner = new Scanner(System.in);

        mainMenu();

        scanner.close();
    }

    public static void mainMenu() {
        int option = 0;
        while (option != 8) {
            System.out.print(menu);
            option = scanner.nextInt();

            System.out.print("Componente léxico: ");
            String regex = scanner.nextLine();

            if (option == 8)
                return;

            boolean found;

            switch (option) {
                case 1 -> found = validate(TokenType.Identifier, regex);
                case 2 -> found = validate(TokenType.Integer, regex);
                case 3 -> found = validate(TokenType.Comment, regex);
                case 4 -> found = validate(TokenType.ArithmeticOperator, regex);
                case 5 -> found = validate(TokenType.LogicOperator, regex);
                case 6 -> found = validate(TokenType.RelationalOperator, regex);
                case 7 -> found = validate(TokenType.Keyword, regex);
                default -> found = false;
            }

            if (found)
                System.out.println("Componente válido");
            else
                System.out.println(ConsoleColor.RED + "Componente no válido");
        }
    }

    public static boolean validate(TokenType t, String input) {
        String regex;
        switch (t) {
            case Identifier -> regex = "[a-z][a-z]$";
            case Integer -> regex = "\\d";
            default -> regex = "";
        }

        Pattern compiled = Pattern.compile(regex);

        Matcher matcher = compiled.matcher(input);

        return matcher.find();
    }
}
