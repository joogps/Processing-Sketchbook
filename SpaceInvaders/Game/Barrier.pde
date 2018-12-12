class Barrier {
  float[] size;
  PVector pos;

  int hp = 5;

  int barrierIndex;

  Barrier(float x, float y, float w, int i) {
    size = new float[2];
    size[0] = w;
    size[1] = 30;

    pos = new PVector(x, y);
    barrierIndex = i;
  }

  void display() {
    fill(255, map(hp, 5, 1, 255, 0), map(hp, 5, 1, 255, 0));
    noStroke();
    rect(pos.x, pos.y, size[0], size[1]);
  }
}
