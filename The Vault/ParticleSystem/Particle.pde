class Particle {
  PVector pos;
  PVector vel = new PVector(random(-1, 1), random(-1, 1), random(-1, 0)).mult(1.5);
  PVector acc  = new PVector(0, 0, 0.06);

  float size = random(5, 15);

  float alpha = 255;

  Particle(float x, float y, float z) {
    pos = new PVector(x, y, z);
  }

  void display() {
    fill(0, 0, 255, alpha);
    noStroke();

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(size);
    popMatrix();
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
  }

  void kill() {
    alpha  = lerp(alpha, 0, 0.02);
  }
}
