Portal portal;

void setup() {
  size(640, 640);
  portal = new Portal();
}

void draw() {
  background(0);

  portal.display();
  portal.update();
}
