package Project.wearshop.Accessories;
import Project.wearshop.Object;

public class Bag extends Accessories {
    private String amount;
    private static int bNum=0;
    private int bId;
    public Bag()
    {
        super();
        amount=new String();
        generateName();
        bNum=bNum+1;
        bId=bNum;
    }
    public void setAmount(String amounts)
    {
        amount=amounts;
    }
    @Override
    protected void generateName()
    {
        name="Сумка";
    }

    @Override
    public String toString()
    {
        String str=new String();
        str=super.toString()+"_объем:"+amount;
        return str;
    }


    @Override
    public boolean equals(Object obj)
    {
        if(obj==null)
            return false;
        if(this==obj)
            return true;
        if(obj instanceof Bag)
        {
            Bag temp=(Bag) obj;
            return this.amount==temp.amount &&
                    this.cost==temp.cost &&
                    this.material.equals(temp.material) &&
                    this.size==temp.size &&
                    this.type.equals(temp.type) &&
                    this.name.equals(temp.name) &&
                    this.price==temp.price &&
                    this.color==temp.color &&
                    this.bId==temp.bId;
        }
        else
            return false;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 83 * hash + (this.amount != null ? this.amount.hashCode() : 0);
        hash = 83 * hash + this.bId;
        return hash;
    }

}
