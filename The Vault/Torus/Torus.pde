//https://en.wikipedia.org/wiki/Torus

import peasy.*;
PeasyCam cam;

float radius1 = 75;
float radius2 = 25;

int detail = 50;

void setup() {
  size(900, 900, P3D);
  colorMode(HSB);

  cam = new PeasyCam(this, (radius1+radius2)*2.75);
}

void draw() {
  background(0);

  directionalLight(0, 0, 255, sin(frameCount/112.5*TWO_PI), cos(frameCount/225.0*TWO_PI), sin(frameCount/75.0*TWO_PI));

  rotateX(frameCount/225.0*TWO_PI);
  rotateY(frameCount/450.0*TWO_PI);
  rotateZ(frameCount/300.0*TWO_PI);

  fill(frameCount/900.0*255%255, 255, 255);
  noStroke();

  for (int i = 0; i < detail*2+1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < detail*2+1; j++) {
      float a = PI*i/detail;
      float p = PI*j/detail;

      float x = (radius1+radius2*cos(p))*cos(a);
      float y = (radius1+radius2*cos(p))*sin(a);
      float z = radius2*sin(p);

      vertex(x, y, z);

      float na = PI*(i+1)/detail;
      float np = PI*j/detail;

      float nx = (radius1+radius2*cos(np))*cos(na);
      float ny = (radius1+radius2*cos(np))*sin(na);
      float nz = radius2*sin(np);

      vertex(nx, ny, nz);
    }
    endShape();
  }
}
