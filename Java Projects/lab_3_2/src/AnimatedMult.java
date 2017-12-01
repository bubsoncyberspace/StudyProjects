public class AnimatedMult extends Mult {
    public String  type;
    AnimatedMult(String animator, String style,  String director,String length,String audition,String type){
        super(animator, style, director, length, audition);
        this.type=type;
    }
    public String Name() {
        name="AnimatedMult";
        return name;
    }

    public String getType() {
        return type;
    }

    public void print()
    {
        System.out.println("AnimatedMult 1 - Animator: "+this.getAnimator()+" Style "+this.getStyle()+"  Director: "+this.getDirector()+" length: "+this.getLength()+" audition: "+this.getAudition()+" name: "+this.Name()+" Type: "+this.getType()+"\n");
    }


}

