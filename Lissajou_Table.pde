final float PI = 3.14;
final float TWO_PI = PI*2;
float cell_size;

float brad=100;
float srad=brad/10;

int m=5;
int n=m=7;
float speed = 200; 
Curve curves[][];

int show_grid=0;

void setup() {
  size(900, 900);
  //                  rowscols
  curves = new Curve[n][m];

  cell_size = width/n;

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      if (i==0 && j==0) {
        Curve none = new Curve(new PVector(), 0);
        none.index=new PVector(0, 0);
        curves[i][j] = none;
      }

      //First row big circles
      if (i==0) {
        float bx = j*cell_size+cell_size/2;
        float by = cell_size/1.5; //also acts as big_rad
        if (j==0) continue;
        //Assemble big circle
        BCircle big = new BCircle(new PVector(bx, by), by);
        //Assemble small
        SCircle small = new SCircle(new PVector(), 15);
        small.angle=0;
        small.rot=(2*j)/speed;
        small.big_daddy=big;
        big.shorty=small;

        big.index=new PVector(i, j);
        small.index=big.index.copy();

        curves[i][j] = big;
      } else if (j==0) {
        float by = i*cell_size+cell_size/2;
        float bx = cell_size/1.5; //also acts as big_rad
        //Assemble big circle
        BCircle big = new BCircle(new PVector(bx, by), bx);
        //Assemble small
        SCircle small = new SCircle(new PVector(), 15);
        small.angle=0;
        small.rot=(2*i)/speed;
        small.big_daddy=big;
        big.shorty=small;

        big.index=new PVector(i, j);
        small.index=big.index.copy();

        curves[i][j] = big;
      } else if (i!=0 && j!=0) {
        float bx = cell_size*i+cell_size/2;
        float by = cell_size*j+cell_size/2;
        Lissajou_Curve lissajou = new Lissajou_Curve(new PVector(bx, by), curves[i][0], curves[0][j]);

        lissajou.index=new PVector(i, j);

        curves[i][j] = lissajou;
      }
    }
  }
}


void draw() {
  //background(15);
  fill(0, 10);
  rect(0, 0, width, height);


  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      //if (curves[i][j]==null) return;

      Curve c = curves[i][j];
      if (c instanceof BCircle) {
        BCircle big = (BCircle)c;
        big.show();
      } else if (c instanceof Lissajou_Curve) {
        Lissajou_Curve lc = (Lissajou_Curve)c;

        lc.show();
      }
    }
  }

  //for (int i=1; i<n; i++) {
  //  for (int j=1; j<m; j++) {
  //    //show_guide_lines(i,j);
  //  }
  //}
  if (show_grid == 1) {
    show_guide_lines(n/2, m/3);
  }
  else if (show_grid == 2){
    for(int i=1; i<n; i+=2){
      for(int j=1; j<m; j+=2){
          show_guide_lines(i,j);
      }
    }
  }
  //((Lissajou_Curve)curves[2][1]).debug();
  return;
}

void show_guide_lines(int row, int col) {
  BCircle cy = (BCircle)curves[row][0];
  BCircle cx = (BCircle)curves[0][col];
  stroke(150, 20);
  line(cx.shorty.pos.x, 0, cx.shorty.pos.x, height);
  line(0, cy.shorty.pos.y, width, cy.shorty.pos.y);
  fill(250,0,0);
  ellipse(cx.shorty.pos.x,cx.shorty.pos.y,cx.shorty.rad/2,cx.shorty.rad/2);
  fill(0,250,0);
  ellipse(cy.shorty.pos.x,cy.shorty.pos.y,cy.shorty.rad/2,cy.shorty.rad/2);
}

void keyPressed() {
  if (key == 'g') show_grid = (show_grid+1)%3;
}
