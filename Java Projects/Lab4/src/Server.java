
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.*;

public class Server {
    private static Map<Integer, Integer[]> lotteryBillz;
    static{
        lotteryBillz = new HashMap<>();
        for (int i = 1; i <= 10; i++) {
            Integer[] array = new Integer[10];
            Random random = new Random();
            System.out.print(i + ": ");
            for (int j = 0; j < 10; j++) {
                array[j] = random.nextInt(100);
                System.out.print(array[j] + ", ");
            }
            System.out.println();
            lotteryBillz.put(i, array);
        }
    }

    public static void main(String[] arg) {
        try (ServerSocket serverSocket = new ServerSocket(2525);
             Socket clientAccepted = serverSocket.accept();
             ObjectInputStream sois = new ObjectInputStream(clientAccepted.getInputStream());
             ObjectOutputStream soos = new ObjectOutputStream(clientAccepted.getOutputStream())
        ) {
            Integer[] clientMessageReceived = (Integer[]) sois.readObject();
            while (true) {
                int billNumber = 0;
                int maxCount = 0;
                int count = 0;
                for (Map.Entry<Integer, Integer[]> item : lotteryBillz.entrySet()) {
                    for (int i = 0; i < 10; i++) {
                        for (int j = 0; j < 10; j++) {
                            if(item.getValue()[i].equals(clientMessageReceived[j]))
                                count++;
                        }
                    }
                    if(count > maxCount) {
                        maxCount = count;
                        billNumber = item.getKey();
                    }
                    count = 0;
                }
                System.out.println("Количество совпадений: " + maxCount);
                soos.writeObject(billNumber);
                clientMessageReceived = (Integer[]) sois.readObject();
                soos.close();
                sois.close();
                serverSocket.close();

            }

        } catch (ClassNotFoundException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
