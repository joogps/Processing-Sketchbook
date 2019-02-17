//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 200;
float detail = 60;

float xoff;
float yoff;
float zoff;

void setup() {
  size(900, 900, P3D);

  colorMode(HSB);
  noiseDetail(1, 0.5);

  cam = new PeasyCam(this, radius*2.25);
}

void draw() {
  background(255);
  lights();

  fill(frameCount/300.0*255%255, 255, 255);
  noStroke();

  xoff+= 0.015;
  yoff+= 0.015;
  zoff+= 0.015;

  for (float i = 0; i < detail*2+1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (float j = 0; j < detail; j++) {
      float a = PI*i/detail;
      float p = PI*j/detail;

      float x = cos(a)*sin(p);
      float y = sin(a)*sin(p);
      float z = cos(p);

      float r = map(noise(x+xoff+1, y+yoff+1, z+zoff+1), 0, 1, radius/6.0, radius);

      vertex(x*r, y*r, z*r);

      float na = PI*(i+1)/detail;
      float np = PI*(j+1)/detail;

      float nx = cos(na)*sin(np);
      float ny = sin(na)*sin(np);
      float nz = cos(np);

      float nr = map(noise(nx+xoff+1, ny+yoff+1, nz+zoff+1), 0, 1, radius/6.0, radius);

      vertex(nx*nr, ny*nr, nz*nr);
    }
    endShape();
  }
}
