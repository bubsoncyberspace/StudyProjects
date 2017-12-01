/**
 * Created by ASUS on 27.09.2016.
 */
import java.io.*;
import java.net.Socket;

public class Client {
    public static void main(String[] arg) {
        try(Socket clientSocket = new Socket("127.0.0.1", 2525);
            BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
            ObjectOutputStream coos = new ObjectOutputStream(clientSocket.getOutputStream());
            ObjectInputStream cois = new ObjectInputStream(clientSocket.getInputStream())
        ) {
            System.out.println("Enter 10 numbers");
            Integer[] array = new Integer[10];
            for (int i = 0; i < 10; i++) {
                array[i] = Integer.parseInt(stdin.readLine());
            }

            coos.writeObject(array);
            while (true) {
                Integer ticketNumber = (Integer) cois.readObject();
                System.out.println("Билет №" + ticketNumber);
                System.out.println("---------------------------");
                for (int i = 0; i < 10; i++) {
                    array[i] = Integer.parseInt(stdin.readLine());
                }
                coos.writeObject(array);
                coos.close();
                cois.close();
                clientSocket.close();

            }
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
