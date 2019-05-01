class Arc {
  float radius;

  float start;
  float end;

  float fill;

  float angle;

  Arc (float r) {
    radius = r;
  }

  void display() {
    if (fill == 0) {
      float x = cos(arcs[currentFill].angle)*radius*2;
      float y = sin(arcs[currentFill].angle)*radius*2;

      point(x, y);
    } else
      arc(0, 0, radius*4, radius*4, start, end);
  }

  void update(float f) {
    fill = f;

    if (fill < 0) {
      start = -QUARTER_PI+HALF_PI*fill;
      end = -QUARTER_PI;

      angle = start;
    } else {
      start = -HALF_PI-QUARTER_PI;
      end = -HALF_PI-QUARTER_PI+HALF_PI*fill;

      angle = end;
    }
  }
}
