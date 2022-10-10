package practica_2;

import java.util.*;
import java.util.regex.*;

public class Regex {
    public static final String RESET = "\u001B[0m";
    public static final String RED   = "\u001B[31m";
    public static final String GREEN = "\u001B[32m";
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

        int option = 1;
        while (option < 8 && option > 0) {
            System.out.print(menu);
            try {
                option = scanner.nextInt();
            } catch (InputMismatchException e) { }

            if (option < 8 && option > 0) {

                System.out.print("Cadena: ");
                String lex = scanner.next();

                boolean valid;

                switch (option) {
                    case 1 -> valid = Pattern.matches("[a-z]+", lex); // Identifier
                    case 2 -> valid = Pattern.matches("\\d+", lex); // Integer
                    case 3 -> valid = Pattern.matches("^[:][)].*|^[:][)]\\s.*", lex); // Comment
                    case 4 -> valid = Pattern.matches("^[-*/+]", lex); // Arithmetic Operator
                    case 5 -> valid = Pattern.matches("^[=&|!]", lex); // Logic Operator
                    case 6 -> valid = Pattern.matches("^[<>]", lex); // Relational Operator
                    case 7 -> valid = Pattern.matches("fun|return|num|txt|bool", lex); // Keyword
                    default -> valid = false;
                }
                if (option == 1 && Pattern.matches("fun|return|num|txt|bool", lex)) valid = false;

                if (valid)
                    System.out.println(GREEN + "Cadena válida");
                else
                    System.out.println(RED + "Cadena no válido");
                System.out.println(RESET);
            }
        }
        scanner.close();
    }
}
