//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 200;
float detail = 80;

float xoff;
float yoff;
float zoff;

void setup() {
  size(640, 640, P3D);
  colorMode(HSB);
  noiseDetail(1, 0.5);
  
  cam = new PeasyCam(this, 300);
}

void draw() {
  background(255);
  
  fill(frameCount/600.0*255%255, 255, 255);
  noStroke();
  lights();
  
  xoff+= 0.01;
  yoff+= 0.01;
  zoff+= 0.01;

  for (float p = 0; p < PI+PI/detail; p+= PI/detail) {
    beginShape(TRIANGLE_STRIP);
    for (float a = 0; a < TWO_PI+PI/detail; a+= PI/detail) {
      float x = sin(p)*cos(a);
      float y = sin(p)*sin(a);
      float z = cos(p);
      
      float r = noise(x+1+xoff, y+1+yoff, z+1+zoff)*radius;
      
      vertex(x*r, y*r, z*r);
      
      float nx = sin(p+PI/detail)*cos(a+PI/detail);
      float ny = sin(p+PI/detail)*sin(a+PI/detail);
      float nz = cos(p+PI/detail);
      
      float nr = noise(nx+1+xoff, ny+1+yoff, nz+1+zoff)*radius;
      
      vertex(nx*nr, ny*nr, nz*nr);
    }
    endShape();
  }
}
