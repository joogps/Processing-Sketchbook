class Circle {
  PVector pos;
  float grow;
  float growGoal;
  float shrink;
  float size;
  color col;

  Circle(float x, float y, float s, float h) {
    pos = new PVector(x, y);
    grow = 0;
    growGoal = s;
    shrink = 0;
    size = grow-shrink;

    colorMode(HSB);
    col = color(h, 255, 255);
    colorMode(RGB);
  }

  void update() {
    grow = lerp(size, growGoal, 0.05);
    shrink = lerp(shrink, grow, 0.001);

    size = grow-shrink;

    if (size <= 0.1)
      circles.remove(this);
  }
}
