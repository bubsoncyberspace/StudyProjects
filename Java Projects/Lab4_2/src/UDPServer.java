import java.net.*;
import java.io.*;

import static java.lang.Math.*;

public class UDPServer {
    private final static int DEFAULT_PORT = 8001;
    private File file = new File("file1.txt");
    private void runServer() throws IOException {
        try(DatagramSocket s = new DatagramSocket(DEFAULT_PORT);
            FileWriter fw = new FileWriter(file, true)
        ) {
            boolean stopFlag = false;
            while(!stopFlag) {
                byte[] buf;
                byte[] x = new byte[16];
                byte[] y = new byte[16];
                byte[] z = new byte[16];
                DatagramPacket recvPacket = new DatagramPacket(x, x.length);
                s.receive(recvPacket);
                double x1 = 0, y1 = 0, z1 = 0, result = 0;
                try {
                    x1 = Double.parseDouble(new String(recvPacket.getData()).trim());
                    recvPacket.setData(y);
                    recvPacket.setLength(y.length);
                    s.receive(recvPacket);
                    y1 = Double.parseDouble(new String(recvPacket.getData()).trim());
                    recvPacket.setData(z);
                    recvPacket.setLength(z.length);
                    s.receive(recvPacket);
                    z1 = Double.parseDouble(new String(recvPacket.getData()).trim());
                    result = function(x1, y1, z1);
                    buf = Double.toString(result).getBytes();
                } catch (NumberFormatException e){
                    buf = "Incorrect input".getBytes();
                }
                DatagramPacket sendPacket = new DatagramPacket(buf, buf.length, recvPacket.getAddress(), recvPacket.getPort());
                s.send(sendPacket);
                writeToFile(x1,y1,z1,result,fw);
                s.receive(recvPacket);
                if(new String(recvPacket.getData()).trim().equals("n")){
                    stopFlag = true;
                }
            }
        }
    }

    private void writeToFile(double x, double y, double z, double result, FileWriter fw) throws IOException {
        StringBuilder sb = new StringBuilder("x = ");
        sb.append(x);
        sb.append("; y = ");
        sb.append(y);
        sb.append("; z = ");
        sb.append(z);
        sb.append("; result = ");
        sb.append(result);
        sb.append("\n");
        fw.write(sb.toString());
        fw.close();
    }

    private double function(double x, double y, double z) {
        return (x+y);
    }

    public static void main(String[] args) {
        try {
            UDPServer udpSvr = new UDPServer();
            udpSvr.runServer();
        }
        catch(IOException e) {
            throw new RuntimeException(e);
        }
    }
}
