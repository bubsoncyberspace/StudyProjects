
import java.awt.*;
import java.applet.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Random;

public class AppletSample extends Applet {
    Random random = new Random();
    Point[] points = new Point[10];

    public void paint(Graphics g) {
        int x = 0;
        int y = 0;
        int radius = 0;
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {

            System.out.println("Enter x:");
            x = Integer.parseInt(br.readLine());
            System.out.println("Enter y:");
            y = Integer.parseInt(br.readLine());
            System.out.println("Enter radius:");
            radius = Integer.parseInt(br.readLine());






        for(int i=0; i<10; i++){
            points[i] = new Point(random.nextInt(300), random.nextInt(300));
        }
        g.setColor(Color.green);
        Circle circle = new Circle(x, y, radius * 2, radius * 2);
        circle.draw(g);
        Point centerPoint = new Point(x + radius, y + radius);
        g.setColor(Color.black);
        centerPoint.drawPoint(g);
        for(Point point : points){
            if(circle.isInCircle(point)){
                g.setColor(Color.yellow);
                point.drawPoint(g);
            }
            else {
                g.setColor(Color.red);
                point.drawPoint(g);
            }

        }

        }catch (IOException e){
            e.printStackTrace();
        }}


}

