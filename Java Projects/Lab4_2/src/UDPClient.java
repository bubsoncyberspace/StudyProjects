import java.net.*;
import java.io.*;

public class UDPClient {
    public void runClient() throws IOException {
        try(DatagramSocket s = new DatagramSocket();
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in))) {
            boolean flag = true;
            while(flag) {
                byte[] buf = new byte[512];
                byte[] x;
                byte[] y;
                byte[] z;
                System.out.println("Enter x:");
                x = br.readLine().getBytes();
                System.out.println("Enter y:");
                y = br.readLine().getBytes();
                System.out.println("Enter z:");
                z = br.readLine().getBytes();
                DatagramPacket sendPacket = new DatagramPacket(x, x.length, InetAddress.getByName("127.0.0.1"), 8001);
                s.send(sendPacket);
                sendPacket.setData(y);
                sendPacket.setLength(y.length);
                s.send(sendPacket);
                sendPacket.setData(z);
                sendPacket.setLength(z.length);
                s.send(sendPacket);
                DatagramPacket recvPacket = new DatagramPacket(buf, buf.length);
                s.receive(recvPacket);
                String result = new String(recvPacket.getData()).trim();
                System.out.println("The result: " + result);
                System.out.println("Do you want to continue? (n - no, y - yes)");
                result = br.readLine();
                sendPacket.setData(result.getBytes());
                sendPacket.setLength(result.getBytes().length);
                s.send(sendPacket);
                if(result.equals("n")){
                    flag = false;
                }
            }
        }
    }

    public static void main(String[] args) {
        try {
            UDPClient client = new UDPClient();
            client.runClient();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}


