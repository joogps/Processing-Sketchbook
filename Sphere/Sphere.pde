//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 100;
float detail = 100;

void setup() {
  size(640, 640, P3D);
  cam = new PeasyCam(this, 300);
}

void draw() {
  background(255);

  for (float p = 0; p < PI+PI/detail; p+= PI/detail) {
    beginShape(TRIANGLE_STRIP);
    for (float a = 0; a < TWO_PI+PI/detail; a+= PI/detail) {
      float x = radius*sin(p)*cos(a);
      float y = radius*sin(p)*sin(a);
      float z = radius*cos(p);
      
      vertex(x, y, z);
      
      float nx = radius*sin(p+PI/detail)*cos(a+PI/detail);
      float ny = radius*sin(p+PI/detail)*sin(a+PI/detail);
      float nz = radius*cos(p+PI/detail);
      
      vertex(nx, ny, nz);
    }
    endShape();
  }
}
