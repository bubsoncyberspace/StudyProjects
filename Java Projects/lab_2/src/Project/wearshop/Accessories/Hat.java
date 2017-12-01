package Project.wearshop.Accessories;
import Project.wearshop.Object;

public class Hat extends Accessories {
    private String label;
    private static int hNum=0;
    private int hId;
    public Hat()
    {
        super();
        label=new String();
        generateName();
        hNum=hNum+1;
        hId=hNum;
    }
    public void setLabel(String Label)
    {
        label=Label;
    }
    @Override
    protected void generateName()
    {
        name="шапка";
    }

    @Override
    public String toString()
    {
        String str=new String();
        str=super.toString()+"_лейбл:"+label;
        return str;
    }


    @Override
    public boolean equals(Object obj)
    {
        if(obj==null)
            return false;
        if(this==obj)
            return true;
        if(obj instanceof Hat)
        {
            Hat temp=(Hat) obj;
            return this.label==temp.label &&
                    this.cost==temp.cost &&
                    this.material.equals(temp.material) &&
                    this.size==temp.size &&
                    this.type.equals(temp.type) &&
                    this.name.equals(temp.name) &&
                    this.price==temp.price &&
                    this.color==temp.color &&
                    this.hId==temp.hId;
        }
        else
            return false;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 83 * hash + (this.label != null ? this.label.hashCode() : 0);
        hash = 83 * hash + this.hId;
        return hash;
    }

}
