class Bit {
  PVector pos;
  float size;

  boolean on;

  Bit(float x, float y, float s) {
    pos = new PVector(x, y);
    size = s;
  }

  void display() {
    fill(on ? 255 : 0);
    noStroke();

    ellipse(pos.x, pos.y, size, size);
  }

  void click() {
    if (dist(pos.x, pos.y, mouseX, mouseY) < size/2)
      on = !on;
  }
}
