float radius;

int start;
int end;

int count;

void setup() {
  size(640, 360, P3D);
  pixelDensity(displayDensity());

  radius = 5;

  end = 15;

  count = 180;
}

void draw() {
  count++;

  background(255);

  resetMatrix();

  translate(0, 0, -pow(radius, count/60.0));
  rotateX(TWO_PI*frameCount/240.0);
  rotateY(TWO_PI*frameCount/240.0);
  rotateZ(TWO_PI*frameCount/480.0);

  start = 0;
  end = start+6;

  if (count/60 == 4) {
    count = 180;
  }

  for (float p = 0; p < TWO_PI; p+= 0.1) {
    for (float a = 0; a < TWO_PI; a+= 0.1) {
      for (float r = start; r < end; r++) {
        float rad = pow(radius, r);

        float x = rad*sin(p)*cos(a);
        float y = rad*sin(p)*sin(a);
        float z = rad*cos(p);

        point(x, y, z);
      }
    }
  }

  if (frameCount < 12*60)
    saveFrame("frames/####.png");
  else
    exit();
}
