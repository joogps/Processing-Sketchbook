import peasy.*;
PeasyCam cam;

int cols;
int rows;
int layers;

void setup() {
  size(460, 460, P3D);

  cam = new PeasyCam(this, 100);

  cols = 10;
  rows = 10;
  layers = 10;
}

void draw() {
  background(0);
  rectMode(CENTER);

  for (float x = -cols/2.0; x < cols/2.0; x++) {
    for (float y = -rows/2.0; y < rows/2.0; y++) {
      for (float z = -layers/2.0; z < layers/2.0; z++) {  
        pushMatrix();
        translate(x*width/float(cols)+width/float(cols)/2.0, y*height/float(rows)+height/float(rows)/2.0, -z*width/float(cols));
        rotateY(cos(frameCount/600.0*TWO_PI)*TWO_PI*((x+y+z)%2 == 0 ? 1 : -1));

        rect(0, 0, width/float(cols), height/float(rows));
        popMatrix();
      }
    }
  }
}
