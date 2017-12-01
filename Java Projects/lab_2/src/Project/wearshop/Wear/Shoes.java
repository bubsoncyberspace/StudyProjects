package Project.wearshop.Wear;

import Project.wearshop.Object;

public class    Shoes extends Object {
    private String high;
    private static int sNum=0;
    private int sId;
    public Shoes()
    {
        super();
        high= new String();
        generateName();
        sNum=sNum+1;
        sId=sNum;
    }

    public void setHigh(String High)
    {
        high=High;
    }

    @Override
    protected void generateName()
    {
        name="Обувь";
    }
    @Override
    public String toString()
    {
        String str=new String();
        str=super.toString()+"_Высота:"+high;
        return str;
    }
@Override
    public boolean equals(Object ob)
    {
        if(ob==null)
            return false;
        if(this==ob)
            return true;
        if(ob instanceof Shoes )
        {
            Shoes temp=(Shoes) ob;
            return this.sId==temp.sId && this.cost==temp.cost &&
                    this.material.equals(temp.material) &&
                    this.size==temp.size &&
                    this.type.equals(temp.type) &&
                    this.name.equals(temp.name) &&
                    this.price==temp.price &&
                    this.color==temp.color &&
                    this.high==temp.high;

        }
        else
            return false;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + this.sId;
        return hash;
    }

}
