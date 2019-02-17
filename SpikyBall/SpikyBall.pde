//https://en.wikipedia.org/wiki/Spherical_coordinate_system

import peasy.*;
PeasyCam cam;

float radius = 100;
float detail = 10;

float xoff;
float yoff;
float zoff;

void setup() {
  size(900, 900, P3D);
  cam = new PeasyCam(this, radius*2);
}

void draw() {
  background(0);
  lights();

  rotateX(sin(frameCount/7200.0*TWO_PI)*TWO_PI);
  rotateY(sin(frameCount/5400.0*TWO_PI)*TWO_PI);
  rotateZ(sin(frameCount/1800.0*TWO_PI)*TWO_PI);

  float newRadius = map(sin(frameCount/600.0*TWO_PI), -1, 1, radius/4.0, radius);

  xoff+= 0.025;
  yoff+= 0.025;
  zoff+= 0.025;

  fill(0);
  noStroke();
  sphere(newRadius/4.0);

  stroke(255);
  for (int i = 0; i < detail*2+1; i++) {
    for (int j = 0; j < detail; j++) {
      float a = PI*i/detail;
      float p = PI*j/detail;

      float x = sin(p)*cos(a); 
      float y = sin(p)*sin(a);
      float z = cos(p);

      float r = noise(x+1+xoff, y+1+yoff, z+1+zoff)*newRadius;

      line(x*newRadius/4.0, y*newRadius/4.0, z*newRadius/4.0, x*r, y*r, z*r);
    }
  }

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float b = brightness(pixels[x+y*width])/255.0;

      if (x <= width/2) {
        if (y <= height/2)
          pixels[x+y*width] = color(b*238, b*5, b*255);
        else
          pixels[x+y*width] = color(b*5, b*132, b*255);
      } else {
        if (y <= height/2)
          pixels[x+y*width] = color(b*5, b*132, b*255);
        else
          pixels[x+y*width] = color(b*238, b*5, b*255);
      }
    }
  }
  updatePixels();
}
