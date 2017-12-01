public abstract class Mult implements FilmInterface,Object {
    public String animator, style, director, length, audition, name;

    Mult(String animator, String style, String director, String length, String audition) {
        this.director = director;
        this.length = length;
        this.audition = audition;
        this.animator = animator;
        this.style = style;

    }

    Mult(String animator, String director, String length, String audition) {
        this.director = director;
        this.length = length;
        this.audition = audition;
        this.animator = animator;
        this.style = "Animation";

    }

    Mult() {
        this.director = "director";
        this.length = "length";
        this.audition = "audition";
        this.animator = "Animator";
        this.style = "Animation";

    }

    public String getAnimator() {
        return animator;
    }

    public String getStyle() {
        return style;
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
}

