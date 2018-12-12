class ShapeBreath {
  int x;
  int y;
  int size;

  int strokeAlpha = 0;
  int fillAlpha = 0;

  boolean beingKilled = false;

  int frame = 0;
  float animation = 1;

  int randomRange = int(random(15, 25));

  ShapeBreath(int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
  }

  void show() {
    for (int i = 1; i < animation; i++) {
      stroke(255, strokeAlpha);
      fill(255, map(i, 20, 1, -10, fillAlpha));

      makeShape(x, y, int(size * map(i, 0, 100, 0.1, 2.5)), int(size * map(i, 0, 100, 0.1, 2.5)), i);
    }
  }

  void breathe() {
    animation = map(randomRange * cos(TWO_PI * frame / (((width + height) / 2) / round(randomRange / 6.85))), -randomRange, randomRange, randomRange, -10);
    frame++;
  }

  void increaseAlpha() {
    strokeAlpha+= 2;

    if (fillAlpha < 30) {
      fillAlpha+= 1.5;
    }

    if (animation <= 0) {
      strokeAlpha = 0;
      fillAlpha = 0;
    }
  }

  void kill(int index) {
    beingKilled = true;

    strokeAlpha-= 1.5;
    fillAlpha-= 0.1;

    if (strokeAlpha <= 0) {
      shapes.set(index, null);
    }
  }
}
