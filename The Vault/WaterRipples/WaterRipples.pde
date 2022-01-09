float[][] cells1;
float[][] cells2;

float damping;

void setup() {
  size(640, 360);

  cells1 = new float[width][height];
  cells2 = new float[cells1.length][cells1[0].length];

  cells1[cells1.length/2+1][cells1[0].length/2] = 10000;

  damping = 0.99;
}

void draw() {
  background(0);

  loadPixels();
  for (int x = 1; x < cells2.length-1; x++) {
    for (int y = 1; y < cells2[x].length-1; y++) {
      cells2[x][y] = ((cells1[x+1][y]+
        cells1[x-1][y]+
        cells1[x][y+1]+
        cells1[x][y-1])/2.0-cells2[x][y])*damping;

      pixels[x+y*width] = color(cells1[x][y]);
    }
  }
  updatePixels();

  float[][] temp = cells1;
  cells1 = cells2;
  cells2 = temp;
}
