void setup() {
  size(640, 360);

  colorMode(HSB);
}

void draw() {
  background((frameCount/480.0*255)%255, 255, 255);

  translate(map((frameCount/300.0)%1, 0, 1, -50*2, width+50), height/2);
  rotate(HALF_PI);

  fill(255, 100);
  beginShape();
  vertex(0, -100);
  vertex(50, 10);
  vertex(15, 10);
  vertex(15, 40);
  vertex(-15, 40);
  vertex(-15, 10);
  vertex(-50, 10);
  endShape(CLOSE);
}
