public  class Historical implements FilmInterface,Object{
    public String period,director,length,audition,name;
    int conformity;

    Historical(String period, int conformity,  String director,String length,String audition)
    {
        this.director=director;
        this.length=length;
        this.audition=audition;
        this.period=period;
        this.conformity=conformity;

    }
    Historical(String period,  String director,String length,String audition)
    {
        this.director=director;
        this.length=length;
        this.audition=audition;
        this.period=period;
        this.conformity=0;

    }
    Historical()
    {
        this.director="director";
        this.length="length";
        this.audition="audition";
        this.period="Early";
        this.conformity=0;

    }

    public  String getPeriod() {
        return period;
    }

    public int getConformity() {
        return conformity;
    }
    public String getDirector() {
        return director;
    }
    public String getLength() {
        return length;
    }
    public String getAudition() {
        return audition;
    }


    public String Name() {
        name="Hist";
        return name;
    }
    public void print()
    {
        System.out.println("Hist 1 - period: "+this.getPeriod()+" Conformity "+this.getConformity()+" Director: "+this.getDirector()+" length: "+this.getLength()+" audition: "+this.getAudition()+" name "+this.Name()+"\n");
    }
}