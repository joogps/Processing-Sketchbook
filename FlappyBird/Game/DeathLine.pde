class DeathLine {
  PVector pos1;
  PVector pos2;

  PVector vel;
  PVector acc;

  DeathLine(PVector _pos, PVector _acc) {
    pos1 = _pos.copy();
    pos2 = _pos.copy();

    vel = new PVector(0, 0);
    acc = _acc;
  }

  void display() {
    pushStyle();
    strokeWeight(3);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    popStyle();
  }

  void update() {
    if ((pos1.x <= width && pos1.x >= 0) && (pos1.y <= height && pos1.y >= 0) || ((pos2.x <= width && pos2.x >= 0) && (pos2.y <= height && pos2.y >= 0))) {
      vel.add(acc);

      pos1.add(vel);
      pos2.sub(vel);

      acc.mult(0.1);
      vel.mult(1.1);
    }
  }
}
