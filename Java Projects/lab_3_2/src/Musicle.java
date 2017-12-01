public class Musicle implements FilmInterface,Object{
    public String instrument,director,length,audition,name;
    int countsong;

    Musicle(String instrument, int countsong,  String director,String length,String audition)
    {
        this.director=director;
        this.length=length;
        this.audition=audition;
        this.instrument=instrument;
        this.countsong=countsong;

    }
    Musicle(String instrument,  String director,String length,String audition)
    {
        this.director=director;
        this.length=length;
        this.audition=audition;
        this.instrument=instrument;
        this.countsong=0;

    }
    Musicle()
    {
        this.director="director";
        this.length="length";
        this.audition="audition";
        this.instrument="Guitar";
        this.countsong=0;

    }

    public  String getInstrument() {
        return instrument;
    }

    public int getCountsong() {
        return countsong;
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
        name="Mus";
        return name;
    }
    public void print()
    {
        System.out.println("Mus 1 - Instrument:("+this.getInstrument()+",Countsong "+this.getCountsong()+") Director: "+this.getDirector()+" length: "+this.getLength()+" audition: "+this.getAudition()+" name "+this.Name()+"\n");
    }
}