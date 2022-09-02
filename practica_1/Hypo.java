package practica_1;

import java.util.Scanner;
import java.lang.String;
public class Hypo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("Inserte los valores de los catetos");
        System.out.print("x: ");
        double x = scanner.nextDouble();
        System.out.print("y: ");
        double y = scanner.nextDouble();

        double h = Math.sqrt(x * x + y * y);

        System.out.println("h: " + h);

        scanner.close();
    }
}
