//https://en.wikipedia.org/wiki/Torus

import peasy.*;
PeasyCam cam;

float radius1 = 75;
float radius2 = 25;

int detail = 50;

void setup() {
  size(900, 900, P3D);

  colorMode(HSB);
  noiseDetail(2, 1);

  cam = new PeasyCam(this, (radius1+radius2)*2.75);

  background(0);
}

void draw() {
  fill(0, 75);
  rect(-width/2.0, -height/2.0, width, height);

  directionalLight(noise(sin(frameCount/300.0*TWO_PI)+1)*255, 255, 255, sin(frameCount/300.0*TWO_PI), cos(frameCount/450.0*TWO_PI), sin(frameCount/600.0*TWO_PI));

  rotateX(cos(frameCount/600.0*TWO_PI)*TWO_PI);
  rotateY(sin(frameCount/750.0*TWO_PI)*TWO_PI);
  rotateZ(sin(frameCount/300.0*TWO_PI)*TWO_PI);

  fill(255);
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
