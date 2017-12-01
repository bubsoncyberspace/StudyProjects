public class ToyMult extends Mult{
  public int  counttoys;
  ToyMult(String animator, String style,  String director,String length,String audition,int counttoys){
      super(animator, style, director, length, audition);
      this.counttoys=counttoys;
  }
    public String Name() {
        name="ToyMult";
        return name;
    }

    public int getCounttoys() {
        return counttoys;
    }

    public void print()
    {
        System.out.println("ToyMult 1 - Animator: "+this.getAnimator()+" Style "+this.getStyle()+" Director: "+this.getDirector()+" length: "+this.getLength()+" audition: "+this.getAudition()+" name: "+this.Name()+" Count toys: "+this.getCounttoys()+"\n");
    }


}
