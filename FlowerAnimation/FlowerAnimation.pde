void setup() {
  size(640, 640);
  colorMode(HSB);
}

void draw() {
  background(255);
  for (float t = 0; t <= TWO_PI; t+= constrain(TWO_PI*abs(cos(frameCount/2400.0*TWO_PI))/3, QUARTER_PI/32, TWO_PI)) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(t);

    noStroke();
    fill(t/TWO_PI*255/2+255/4, 255, 255, 100-abs(cos(frameCount/2400.0*TWO_PI))/2*100);
    ellipse(0, 0, width/8, height);
    popMatrix();
  }
}
