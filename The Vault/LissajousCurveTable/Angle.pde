class Angle {
  PVector pos;
  float size;

  float angle;
  float speed;

  Angle(float x, float y, float sz, float sp) {
    pos = new PVector(x, y);
    size = sz;
    speed = sp;
  }

  void display() {
    pushStyle();
    pushMatrix();
    translate(pos.x, pos.y);

    noFill();
    stroke(255);
    strokeWeight(3);

    ellipse(0, 0, size, size);

    fill(255);
    noStroke();

    ellipse(cos(angle)*size/2, sin(angle)*size/2, size/5, size/5);
    popMatrix();
    popStyle();
  }

  void update() {
    angle+= speed;
  }
}
