class Curve {
  float rad;
  PVector pos;
  PVector index;
  Curve(PVector p, float r) {
    this.pos=p.copy();
    this.rad=r;
  }

  void show() {
    println(1);
  }
}


class SCircle extends Curve {
  float angle, rot;
  BCircle big_daddy;

  SCircle(PVector p, float r) {
    super(p, r);
    angle=0;
    rot=0;
  }

  void show() {
    update();

    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, rad, rad);
  }

  void update() {
    this.angle+=rot;
    float brad = big_daddy.rad;
    this.pos.x = brad*cos(angle)/2 + big_daddy.pos.x;
    this.pos.y = brad*sin(angle)/2 + big_daddy.pos.y;

    if (this.angle>=TWO_PI) angle=0;
  }
}


class BCircle extends Curve {
  SCircle shorty;

  BCircle(PVector p, float r) {
    super(p, r);
  }

  void show() {
    noFill();
    stroke(255,1);
    ellipse(pos.x, pos.y, rad, rad);

    shorty.show();
  }

  void update() {
  }
}

class Lissajou_Curve extends Curve {
  ArrayList<PVector> points;
  SCircle cx, cy;

  Lissajou_Curve(PVector p, Curve y, Curve x) {
    super(p, 0);
    points = new ArrayList<PVector>();

    cx = ((SCircle)((BCircle)x).shorty);
    cy = ((SCircle)((BCircle)y).shorty);
    
    initColor();
  }

  void show() {
    update();

    pushStyle();
    strokeWeight(3);
    stroke(255, 200);
    noFill();
    beginShape();
    //for (PVector p : points) {
      //vertex(p.x, p.y);
    //}
    endShape();
    popStyle();

    //showText();
    

    return;
  }
  
boolean done = false;
  void update() {
    PVector small_pos = new PVector(cx.pos.x, cy.pos.y);
    
    //if(!done) fill(240,0,0);
    //else fill(0,240,0);
    fill(r,g,b);
    ellipse(small_pos.x,small_pos.y,10,10);
    
    //if (points.size()>0)
      //if (((cx.rot+cy.rot)/TWO_PI)*frameCount>=2*PI) {
        //println("done ", (cx.shorty.angle+cy.shorty.angle) );
        //done=true;
        //return;
      //}
    //this.points.add(small_pos);
    if(millis()-counter>=delay) initColor();
  }
  
  int r,g,b;
  int counter, delay;
  void initColor(){
    r=int(random(0,255));
    g=int(random(60,90));
    b=int(random(70,255));
    r=(int)map(cx.index.y,1,n,60,255);
    g=(int)map(cy.index.x,1,m,60,255);
    counter=millis();
    delay=(int)random(200,2000);
  }

  void showText() {
    String str = cx.big_daddy.index.x+", "+cy.big_daddy.index.y;
    pushStyle();
    fill(255);
    textSize(13);
    textAlign(CENTER);
    text(str, cx.big_daddy.pos.x, cy.big_daddy.pos.y+cx.big_daddy.rad/2);
    popStyle();
  }
  
  void debug(){
    pushStyle();
    fill(0,200,0);
    strokeWeight(2);
    stroke(255,180);
    ellipse(cx.pos.x,cx.pos.y,10,10);
    fill(200,0,0);
    ellipse(cy.pos.x,cy.pos.y,10,10);
    popStyle();
  }
}
