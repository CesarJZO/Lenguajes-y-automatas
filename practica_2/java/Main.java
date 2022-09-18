package practica_2.java;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
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
            [1-8]:\s""";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        mainMenu(scanner);

        scanner.close();
    }

    public static void mainMenu(Scanner s) {
        int option = 0;
        while (option != 8) {
            System.out.print(menu);
            option = s.nextInt();

            if (option > 8 || option < 1)
                return;
            
            System.out.print("Componente léxico: ");
            String regex = s.next();

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
                System.out.println(ConsoleColor.GREEN + "Componente válido");
            else
                System.out.println(ConsoleColor.RED + "Componente no válido");
            System.out.println(ConsoleColor.RESET);
        }
    }

    public static boolean validate(TokenType t, String input) {
        String regex;
        switch (t) {
            case Identifier -> regex = "[a-z]+";
            case Integer -> regex = "\\d+";
            case Comment -> regex = ":)";
            case ArithmeticOperator -> regex = "";
            case LogicOperator -> regex = "";
            case RelationalOperator -> regex = "";
            case Keyword -> regex = "fun|return|none|int|dec|bool|text|if|else|while";
            default -> regex = "";
        }

        if (t == TokenType.Identifier && Pattern.matches("fun|return|none|int|dec|bool|text|if|else|while", input))
            return false;

        if (regex.equals(""))
            return false;

        Pattern compiled = Pattern.compile(regex);

        Matcher matcher = compiled.matcher(input);

        return matcher.matches();
    }
}
