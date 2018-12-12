class CircleWave {
  PVector pos;
  float aOff;

  float r;
  float a;
  float t;

  CircleWave(float x, float y, float _r, float _a, float _t) {
    pos = new PVector(x, y);
    r = _r;
    a = _a;
    t = _t;
  }

  void display() {   
    pushMatrix();
    translate(pos.x, pos.y);

    beginShape();
    for (float i = 0; i < TWO_PI; i+= 0.001) {
      float radius = cos(TWO_PI * ((i + aOff) / QUARTER_PI)) * (aOff * a);

      float x = (r + radius) * cos(i);
      float y = (r + radius) * sin(i);
      vertex(x, y);
    }
    endShape();
    popMatrix();
  }

  void update() {
    aOff = map(cos(TWO_PI * (frameCount / t)), 1, -1, 0, 1);
  }
}
