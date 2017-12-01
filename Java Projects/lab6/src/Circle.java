import java.awt.*;


public class Circle {
    private int x;
    private int y;
    private int width;
    private int height;

    public Circle(int x, int y, int width, int height) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public void draw(Graphics g){
        g.setColor(Color.BLUE);
        g.fillOval(x, y, width, height);
    }

    public boolean isInCircle(Point point){
        int xCenter = x + width/2;
        int yCenter = y + height/2;
        if((point.getX() < xCenter + width/2)&&(point.getX() > xCenter - width/2))
            if((point.getY() < yCenter + height/2 )&&(point.getY() > yCenter - height/2))
                return true;
        return false;
    }
}
