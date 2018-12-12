class Particle {
  PVector pos;
  PVector vel = new PVector(random(-1, 1), random(-1, 1), random(0, 3)).mult(1.5);
  PVector acc  = new PVector(0, 0, -0.065);

  float size = random(1, 5);

  float alpha = 255*2;

  float angle;

  Particle(float x, float y, float z, float bodyAngle) {
    pos = new PVector(x, y, z);
    angle = bodyAngle;
  }

  void display() {
    fill(red(body.ball.ballColor), green(body.ball.ballColor), blue(body.ball.ballColor), alpha);
    noStroke();

    pushMatrix();
    rotate(body.angle - angle);
    translate(pos.x, pos.y, pos.z);

    sphere(size);
    popMatrix();
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
  }

  void kill() {
    alpha  = lerp(alpha, 0, 0.025);
  }
}
