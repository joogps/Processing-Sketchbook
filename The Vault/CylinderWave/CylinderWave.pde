import peasy.*;
PeasyCam cam;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 300);

  colorMode(HSB);
}

void draw() {
  background(map(cos(TWO_PI * frameCount/2400), -1, 1, 0, 255));
  lights();

  rotateX(QUARTER_PI * 1.5);
  rotateZ(HALF_PI);

  float range = map(cos(TWO_PI * frameCount/3000), -1, 1, 0, 225);
  noStroke();
  for (int i = 0; i < 5; i++) {
    fill(map(cos(TWO_PI * (frameCount - i * 15) / 120), -1, 1, range, range+30), 255, 255);
    cylinder(i*25, (i+1)*25, i*25, (i+1)*25, (map(cos(TWO_PI * (frameCount - i * 30) / 240), -1, 1, 50-i*2, 1)), (map(cos(TWO_PI * (frameCount - i * 30) / 240), -1, 1, 50-i*2, 1)), 0, TWO_PI, 300);
  }
}
