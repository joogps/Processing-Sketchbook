class Target {
  PVector pos;
  float size;

  Target(float x, float y, float s) {
    pos = new PVector(x, y);
    size = s;
  }

  void display() {
    pushStyle();
    colorMode(HSB);
    fill((frameCount/1200.0*255)%255, 255, 255);
    noStroke();

    ellipse(pos.x, pos.y, size, size);
    popStyle();
  }
}
