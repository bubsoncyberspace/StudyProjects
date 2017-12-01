package Project.wearshop.Accessories;

import Project.wearshop.Object;

public abstract class Accessories extends Object {
    protected String Description;
    public Accessories(){
        super();
        Description= new String();
        generateName();
    }
    public void setDescription(String description)
    {

        Description=description;
    }


    @Override
    protected void generateName() {
        name="Unknown_accessories";
    }

    @Override
    public String toString()
    {
        String str=new String();
        str=super.toString()+"_Описание:"+Description;
        return str;
    }


}
