package thread;


import java.awt.*;
import java.applet.*;
import java.util.Random;

public class AppletThreadSample extends Applet implements Runnable{

    private Thread T;
    private ShapeShip m_ShapeShip = null;
    private ShapeRect m_ShapeRect = null;
    private ShapeLine m_ShapeLine = null;
    private Button btbRun = new Button();

    public void run() {
        setBackground(Color.yellow);
        while (true){
            repaint();
            try{
                T.sleep(0);
            }
            catch (InterruptedException e){	}
        }
    }

    public void init() {
        resize(700,460);
        T = new Thread(this);
        T.start();
        m_ShapeShip= new ShapeShip();
        m_ShapeRect= new ShapeRect();
        m_ShapeLine = new ShapeLine();
        btbRun.setSize(100,100);
        btbRun.setLabel("Run");
        btbRun.addActionListener((e)->  m_ShapeLine = new ShapeLine());
        add(btbRun);
    }

    public void paint(Graphics g) {
        g.setColor(Color.white);
        g.fillOval(m_ShapeShip.x_Oval, m_ShapeShip.y_Oval,
                m_ShapeShip.w_Oval, m_ShapeShip.h_Oval);
        g.setColor(Color.blue);
        g.fillRect(m_ShapeRect.x_Rect, m_ShapeRect.y_Rect,
                m_ShapeRect.w_Rect, m_ShapeRect.h_Rect);
        if(m_ShapeLine != null) {
            g.setColor(Color.black);
            g.drawLine(m_ShapeLine.x1_Line, m_ShapeLine.y1_Line, m_ShapeLine.x2_Line, m_ShapeLine.y2_Line);
            if(m_ShapeLine.y2_Line <= m_ShapeShip.y_Oval + m_ShapeShip.h_Oval &&
                    (m_ShapeLine.x2_Line >= m_ShapeShip.x_Oval &&
                            m_ShapeLine.x2_Line <= m_ShapeShip.x_Oval + m_ShapeShip.w_Oval)) {
                m_ShapeLine.destroy();
                m_ShapeShip.destroyed = true;
            }
        }
    }

    class ShapeShip implements Runnable{
        boolean destroyed = false;
        Thread T;
        Random random = new Random();
        int x_Oval, y_Oval,w_Oval,h_Oval; //координаты и размеры овала
        public ShapeShip(){ //конструктор
            T = new Thread(this); //создание объекта Thread
            x_Oval=0; y_Oval=30;w_Oval=100;h_Oval=100;
            T.start(); //запуск потока (вызов метода run)
        }
        public void run(){//метод run
           for(;;){
                if(destroyed){
                    while(w_Oval != 0 && h_Oval != 0){
                        w_Oval -= 30;
                        h_Oval -= 30;
                        try{
                            T.sleep(200);
                        }
                        catch (InterruptedException e){	}
                    }
                }
                if(x_Oval >= 700)
                    x_Oval = 0;
                x_Oval+=random.nextInt(20);
                try{
                    T.sleep(100); //приостановка работы потока на 100 миллисекунд
                }
                catch (InterruptedException e){	}
            }
        }
    }

    class ShapeRect implements Runnable{
        Thread T;
        int x_Rect,y_Rect,w_Rect,h_Rect;
        public ShapeRect(){ //конструктор
            T = new Thread(this); //создание объекта Thread
//установление начальных координат квадрата
            x_Rect=350;y_Rect=400;w_Rect=50;h_Rect=50;
            T.start();//запуск потока (вызов метода run)
        }
        public void run(){ //метод run
            for(;;){
            }
        }
    }

    class ShapeLine implements Runnable{
        Thread T;
        int x1_Line,y1_Line,x2_Line,y2_Line; //координаты и размеры квадрата
        public ShapeLine(){ //конструктор
            T = new Thread(this); //создание объекта Thread
//установление начальных координат квадрата
            x1_Line=375;y1_Line=350;x2_Line=x1_Line;y2_Line=320;
            T.start();//запуск потока (вызов метода run)
        }
        public void run(){ //метод run
            while(x1_Line != 0 && x2_Line != 0){
                y1_Line -= 30;
                y2_Line -= 30;
                try{
                    T.sleep(650);  //приостановка работы потока на 1000 миллисекунд
                }
                catch (InterruptedException e){}
            }
        }
        public void destroy(){
            x1_Line = 0;
            x2_Line = 0;
            y1_Line = 0;
            y2_Line = 0;
            m_ShapeLine = null;
        }
    }
}

