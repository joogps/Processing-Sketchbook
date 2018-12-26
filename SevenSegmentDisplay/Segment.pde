class Segment {
  PVector pos;

  float w;
  float h;

  float angle;

  boolean state;
  float animation;

  Segment(float x, float y, float _w, float _h, float a) {
    pos = new PVector(x, y);

    w = _w;
    h = _h;

    angle = a;

    state = false;
    animation = 0;
  }

  void display() {
    noStroke();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);

    fill(50, 0, 0);
    drawSegment(w, h);

    fill(255, 0, 0);
    drawSegment(w*animation, h*animation);
    popMatrix();

    animation = lerp(animation, state ? 1 : 0, 0.2);
  }

  void setState (boolean s) {
    if (state != s) {
      state = s;
      animation = state ? 0 : 1;
    }
  }
}

void drawSegment(float w, float h) {
  beginShape();
  vertex(-w/2, -h*0.3);
  vertex(0, -h/2);
  vertex(w/2, -h*0.3);

  vertex(w/2, h*0.3);
  vertex(0, h/2);
  vertex(-w/2, h*0.3);
  endShape(CLOSE);
}
