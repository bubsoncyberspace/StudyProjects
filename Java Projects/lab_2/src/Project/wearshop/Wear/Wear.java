package Project.wearshop.Wear;


import Project.wearshop.Object;

public class Wear extends Object {
    private String OthMaterials;
    private static int wNum=0;
    private int wId;
    public Wear()
    {
        super();
        OthMaterials=new String();
        generateName();
        wNum=wNum+1;
        wId=wNum;
    }

    public void setOthMaterials(String OMaterials)
    {
        OthMaterials=OMaterials;
    }

    @Override
    protected void generateName()
    {
        name="Одежда";
    }

    @Override
    public String toString()
    {
        String str=new String();
        str=super.toString()+"_другие_материалы:"+OthMaterials;
        return str;
    }
    @Override
    public boolean equals(Object ob)
    {
        if(ob==null)
            return false;
        if(this==ob)
            return true;
        if(ob instanceof Wear)
        {
            Wear temp=(Wear) ob;
            return this.cost==temp.cost &&
                    this.material.equals(temp.material) &&
                    this.size==temp.size &&
                    this.type.equals(temp.type) &&
                    this.name.equals(temp.name) &&
                    this.price==temp.price &&
                    this.color==temp.color &&
                    this.wId==temp.wId;
        }
        else
            return false;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 79 * hash + (this.OthMaterials != null ? this.OthMaterials.hashCode() : 0);
        hash = 79 * hash + this.wId;
        return hash;
    }

}
