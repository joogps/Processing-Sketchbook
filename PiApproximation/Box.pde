class Box {
  PVector pos;
  PVector vel;

  float size;
  float mass;

  Box(float x, float y, float v, float s, float m) {
    pos = new PVector(x, y);

    size = s;
    mass = m;

    vel = new PVector(v, 0);
  }

  void display() {
    rect(pos.x, pos.y, size, size);
  }

  void update() {
    pos.add(vel);
  }

  void walls() {
    if (pos.x <= walls.x) {
      vel.mult(-1);
      collisions++;
    }
  }
}
