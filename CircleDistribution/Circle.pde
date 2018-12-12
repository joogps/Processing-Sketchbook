class Circle {
  PVector pos;
  float radius;

  Circle(PVector p, float r) {
    pos = p;
    radius = r;
  }

  void display() {
    fill(0, 50, 255, 150);
    noStroke();

    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
