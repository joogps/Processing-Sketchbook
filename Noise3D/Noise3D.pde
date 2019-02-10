//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 100;
float detail = 10;

float xoff;
float yoff;
float zoff;

void setup() {
  size(640, 640, P3D);
  cam = new PeasyCam(this, 300);
}

void draw() {
  background(255);
  
  xoff+= 0.01;
  yoff+= 0.01;
  zoff+= 0.01;

  for (float p = 0; p < PI; p+= PI/detail) {
    for (float a = 0; a < TWO_PI; a+= PI/detail) {
      
      float x = sin(p)*cos(a);
      float y = sin(p)*sin(a);
      float z = cos(p);
      
      float r = noise(x+1+xoff, y+1+yoff, z+1+zoff)*radius;
      
      line(0, 0, 0, x*r, y*r, z*r);
    }
  }
}
