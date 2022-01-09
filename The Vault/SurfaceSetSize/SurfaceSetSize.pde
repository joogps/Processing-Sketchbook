void setup() {
  size(0, 0);
  colorMode(HSB);
}

void draw() {
  surface.setLocation(0, 0);
  surface.setSize(int(abs(cos(frameCount/480.0*TWO_PI))*displayWidth), int(abs(sin(frameCount/480.0*TWO_PI))*displayHeight));

  background(frameCount%600/600.0*255);

  fill(frameCount%240/240.0*255, 255, 255);
  noStroke();

  ellipse(width/2.0, height/2.0, width/2.0, height/2.0);
}
