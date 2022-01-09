void setup() {
  size(640, 360);
  colorMode(HSB);
}

void draw() {
  background(255);

  translate(width/2, height/2);
  rotate(frameCount/90.0*TWO_PI);

  for (float a = 0; a < TWO_PI; a+= 0.1) {
    stroke(a/TWO_PI*255, 255, 255);
    line(0, 0, cos(a)*((a+0.1)/TWO_PI)*(width+height)*(cos(frameCount/300.0)*15), sin(a)*((a+0.1)/TWO_PI)*(width+height)*(cos(frameCount/300.0)*15));
  }
}
