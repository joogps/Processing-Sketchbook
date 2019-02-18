//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 200;
float detail = 60;

float arcDetail = 120;
float colorChange;

void setup() {
  size(900, 900, P3D);
  colorMode(HSB);

  cam = new PeasyCam(this, radius*4);
}

void draw() {
  background(255);
  lights();

  fill(255);
  noStroke();

  for (int i = 0; i < detail*2+1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < detail; j++) {
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

  noFill();
  strokeWeight(3);
  for (int i = 0; i < arcDetail; i++) {
    float y = -radius+radius*2*(i/arcDetail);
    float r = sqrt(sq(radius)-sq(y));

    stroke((i/arcDetail*255+colorChange)%255, 255, 255);
    beginShape();
    for (float a = 0; a <= constrain((frameCount/300.0-((i-1)/arcDetail))*TWO_PI, 0, TWO_PI); a+= PI/90.0)
      vertex(cos(a)*r, y, sin(a)*r);
    endShape();
  }

  if ((frameCount/300.0-(0.5-1.5/arcDetail))*TWO_PI > PI)
    colorChange+= 0.75;
}
