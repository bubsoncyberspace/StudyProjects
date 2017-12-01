package Project;

import Project.Order.Order;
import Project.wearshop.Accessories.Bag;
import Project.wearshop.Accessories.Hat;
import Project.wearshop.Wear.Shoes;
import Project.wearshop.Wear.Wear;



public class Main {

    public static void main(String[] args) {
        // TODO code application logic here
        Order order=new Order();
        Shoes shoes=new Shoes();
        Wear wear=new Wear();
        Bag bag=new Bag();
        Hat hat=new Hat();

        bag.setName(" backpack 1");
        bag.setCost(420);
        bag.setAmount("17 литров");
        bag.setType("Рюкзак");
        bag.setMaterial("Нейлон");
        bag.setColor("black");
        bag.setSize("s");
        bag.setPrice(450);
        bag.setDescription("новый ультралегкий портфель");

        shoes.setName(" shoes 1");
        shoes.setCost(1220);
        shoes.setType("туфли");
        shoes.setMaterial("кожа");
        shoes.setColor("коричневый");
        shoes.setSize("43");
        shoes.setPrice(1300);
        shoes.setHigh("Low");

        wear.setName(" coat 1");
        wear.setCost(1350);
        wear.setType("пальто");
        wear.setMaterial("ткань");
        wear.setColor("Бежевый");
        wear.setSize("XL");
        wear.setPrice(1500);
        wear.setOthMaterials("Хлопок");

        hat.setName(" hat 1");
        hat.setCost(150);
        hat.setLabel("BSUIR");
        hat.setType("Кепка");
        hat.setMaterial("Нейлон");
        hat.setColor("black");
        hat.setSize("XS");
        hat.setPrice(250);
        hat.setDescription("современная кепка для студентов БГУИР");




        order.addItem(bag);
        order.addItem(shoes);
        order.addItem(wear);
        order.addItem(hat);

        order.printOrder();
        order.countPrice();
        order.printOrder();
        System.out.println(order.toString());

    }
}
