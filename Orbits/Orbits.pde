Body body;

void setup() {
  size(640, 640);
  body = new Body(0, 0, 100, 5);
  background(0);

  colorMode(HSB);
}

void draw() {
  translate(width/2, height/2);

  body.display();
  body.update();
}
