class Barrier {
  PVector pos;
  float w;
  float h;

  Barrier(float x, float y, float _w, float _h) {
    pos = new PVector(x, y);
    w = _w;
    h = _h;
  }

  void display() {
    pushStyle();
    fill(255);
    noStroke();

    rect(pos.x, pos.y, w, h);
    popStyle();
  }
}
