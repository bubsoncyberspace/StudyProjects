package Project.wearshop;

import Project.PriceInterface;

abstract public class Object implements PriceInterface {
    protected String name;
    protected String type;
    protected String size;
    protected String material;
    protected String color;
    protected int cost;
    protected int price;
    public Object ()
    {
        name=new String();
        type=new String();
        size=new String();
        material=new String();
        color=new String();
        cost=0;
        price=0;
    }
    abstract protected void generateName();
    public void setName(String Name)//установка значений
    {
        name=Name;
    }
    protected void setPrice()
    {
        price=countPrice();
    }
    public void setType(String Type)
    {
        type=Type;
    }
    public void setSize(String Size)
    {
        size=Size;
    }
    public void setMaterial(String Material)
    {
        material=Material;
    }
    public void setColor(String Color)
    {
        color=Color;
    }
    public void setPrice(int Price)
    {
        price=Price;
    }


    public void setCost(int Cost)
    {
        cost=Cost;
        setPrice();
    }
    public int getPrice()
    {
        return price;
    }
    public int getCost()
    {
        return cost;
    }
    @Override
    public int countPrice()
    {
        int price;
        price=(int) ((cost*1.2)*1.2);
        return price;
    }

    @Override
    public String toString()
    {
        String str=new String();
        str=name+"_"+type+"_"+material+"_"+size+"_"+color+"_себестоимость:"+cost+"у.е._Цена:"+price+"у.е.";
        return str;
    }

    public abstract boolean equals(Object ob);
}
