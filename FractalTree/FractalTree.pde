void setup() {
  size(640, 360);
  colorMode(HSB);
}

void draw() {
  background(255);

  translate(width/2, height);
  fractalTree(height/2, frameCount/600.0*TWO_PI, color(255, 255, 255), 7);
}

void fractalTree(float l, float t, color c, int level) {
  stroke(c);
  line(0, 0, 0, -l);

  if (level > 0) {
    pushMatrix();
    translate(0, -l);
    fractalTree(l/2, t, color(hue(c)+255/10.0, saturation(c), brightness(c), alpha(c)), level-1);
    popMatrix();

    pushMatrix();
    translate(0, -l);
    rotate(t);
    fractalTree(l/2, t, color(hue(c)+255/10.0, saturation(c), brightness(c), alpha(c)), level-1);
    popMatrix();


    pushMatrix();
    translate(0, -l);
    rotate(-t);
    fractalTree(l/2, t, color(hue(c)-255/10.0, saturation(c), brightness(c), alpha(c)), level-1);
    popMatrix();
  }
}
