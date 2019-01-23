import peasy.*;

float[][] cells1;
float[][] cells2;

float damping;

PeasyCam cam;

void setup() {
  size(640, 640, P3D);

  cells1 = new float[150][150];
  cells2 = new float[cells1.length][cells1[0].length];

  cells1[cells1.length/2+1][cells1[0].length/2] = 1000;

  damping = 0.99;

  cam = new PeasyCam(this, 1000);
}

void draw() {
  background(100);
  lights();

  noStroke();
  fill(25, 50, 255);

  translate(-width/2, -height/2);

  for (int x = 1; x < cells2.length-1; x++) {
    for (int y = 1; y < cells2[x].length-1; y++) {
      cells2[x][y] = ((cells1[x+1][y]+
        cells1[x-1][y]+
        cells1[x][y+1]+
        cells1[x][y-1])/2.0-cells2[x][y])*damping;
    }
  }

  for (int y = 0; y < cells1[0].length; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cells1.length; x++) {
      vertex(width*x/float(cells1.length), height*y/float(cells1[0].length), -cells1[x][y]);
      vertex(width*x/float(cells1.length), height*(y+1)/float(cells1[0].length), -cells1[x][y]);
    }
    endShape();
  }

  float[][] temp = cells1;
  cells1 = cells2;
  cells2 = temp;
}
