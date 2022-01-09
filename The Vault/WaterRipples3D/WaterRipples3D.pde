import peasy.*;

float[][] cells1;
float[][] cells2;

float damping;

float w;
float h;

PeasyCam cam;

void setup() {
  size(640, 640, P3D);

  cells1 = new float[180][180];
  cells2 = new float[cells1.length][cells1[0].length];

  cells1[cells1.length/2+1][cells1[0].length/2] = 10;

  damping = 0.9;

  w = width*2/float(cells1.length);
  h = height*2/float(cells1[0].length);

  cam = new PeasyCam(this, 1000);
}

void draw() {
  background(200);
  lights();

  fill(50, 75, 255);
  noStroke();

  for (int x = 1; x < cells2.length-1; x++) {
    for (int y = 1; y < cells2[x].length-1; y++) {
      cells2[x][y] = ((cells1[x+1][y]+
        cells1[x-1][y]+
        cells1[x][y+1]+
        cells1[x][y-1])/2.0-cells2[x][y])*damping;
    }
  }

  translate(-width, -height);

  for (int y = 0; y < cells1[0].length-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cells1.length; x++) {
      vertex(x*w, y*h, abs(cells1[x][y])*50);
      vertex(x*w, (y+1)*h, abs(cells1[x][y+1])*50);
    }
    endShape();
  }

  float[][] temp = cells1;
  cells1 = cells2;
  cells2 = temp;
}

void mouseDragged() {
  if (mouseButton == RIGHT && mouseX > 1 && mouseX < width-1 && mouseY > 1 & mouseY < height-1) {
    cam.setActive(false);
    cells1[1+int(mouseX/float(width)*(cells1.length-2))][1+int(mouseY/float(height)*(cells1[0].length-2))] = 10;
  }
}

void mouseReleased() {
  cam.setActive(true);
}
