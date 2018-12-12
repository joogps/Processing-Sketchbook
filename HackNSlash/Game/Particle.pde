class Particle {
  PVector pos;
  PVector vel;

  float size;

  float desacceleration;

  float alpha;
  float alphaSpeed;

  boolean isSquare;

  float theta;
  float thetaSpeed;
  float thetaDesacceleration;

  int index;

  Particle(PVector p, PVector v, float s, int i) {
    pos = p;
    vel = v;

    size = s;

    desacceleration = random(0.8, 0.9);
    
    alpha = 255;
    alphaSpeed = random(0.01, 0.1);

    isSquare = random(1) < 0.5;

    thetaSpeed = random(0.5);
    thetaDesacceleration = random(0.85, 1);

    index = i;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    fill((1-player.superShot)*255, alpha);

    if (isSquare) {
      rectMode(CENTER);
      rect(0, 0, size, size);
    } else
      ellipse(0, 0, size, size);
    popMatrix();
  }

  void update() {
    pos.add(vel);
    vel.mult(desacceleration);

    if (isSquare) {
      theta+= thetaSpeed;
      thetaSpeed*= thetaDesacceleration;
    }

    alpha = lerp(alpha, 0, alphaSpeed);
    if (alpha < 0.5)
      particles.set(index, null);
  }
}
