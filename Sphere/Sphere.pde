//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 200;
float detail = 60;

void setup() {
  size(900, 900, P3D);

  cam = new PeasyCam(this, radius*2.5);
}

void draw() {
  background(255);
  lights();

  noStroke();

  for (float i = 0; i < detail*2+1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (float j = 0; j < detail; j++) {
      float a = PI*i/detail;
      float p = PI*j/detail;

      float x = radius*cos(a)*sin(p);
      float y = radius*sin(a)*sin(p);
      float z = radius*cos(p);

      vertex(x, y, z);

      float na = PI*(i+1)/detail;
      float np = PI*(j+1)/detail;

      float nx = radius*cos(na)*sin(np);
      float ny = radius*sin(na)*sin(np);
      float nz = radius*cos(np);

      vertex(nx, ny, nz);
    }
    endShape();
  }
}
