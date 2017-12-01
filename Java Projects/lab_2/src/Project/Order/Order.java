package Project.Order;

import  Project.PriceInterface;
import Project.wearshop.Object;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Order implements PriceInterface{
    private List<Object> ShopBag;
    private int cost;
    private int price;
    private static int orderNum=0;

    public Order()
    {
        ShopBag = new ArrayList<Object>();
        orderNum=orderNum+1;
    }

    public void addItem(Object ob)
    {
        ShopBag.add(ob);
    }

    public void printOrder()
    {
        int i=1;
       Iterator it=ShopBag.iterator();
        System.out.println("=================================================");
        while(it.hasNext())
        {
            System.out.println(i+")"+(it.next()).toString());
            i=i+1;
        }
        System.out.println();
        System.out.println("Себестоимость заказа:"+cost+" Цена заказа:"+price);
        System.out.println("=================================================");
    }


    @Override
    protected void finalize()
    {
        try {
            super.finalize();
        } catch (Throwable ex) {
            System.err.println("Ошибка при удалении объекта");
        }
        orderNum=orderNum-1;
    }

    @Override
    public int countPrice() {
        int tempPrice=0, tempCost=0;
        Iterator it=ShopBag.iterator();
        Object ob;
        while(it.hasNext())
        {
            ob=(Object)it.next();
            tempCost=tempCost+ob.getCost();
            tempPrice=tempPrice+ob.getPrice();
        }
        cost=tempCost;
        price=tempPrice;
        return tempPrice;
    }

}
