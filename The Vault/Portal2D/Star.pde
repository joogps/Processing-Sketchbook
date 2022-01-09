class Star {
  PVector pos;
  PVector vel;

  float size;

  float alpha;
  float origAlpha;
  float alphaSpeed;

  Star() {
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D();

    size = random(1, 10);
    vel.div(size);

    alpha = random(255);
    origAlpha = alpha;
    alphaSpeed = random(600, 1200);
  }

  void display() {
    fill(255, alpha);
    noStroke();

    ellipse(pos.x, pos.y, size, size);
  }

  void update() {
    pos.add(vel);
    alpha = lerp(alpha, abs(cos(frameCount/alphaSpeed*TWO_PI))*origAlpha, 0.1);

    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) {
      pos = new PVector(width/2, height/2);
      size = random(1, 10);

      alpha = 0;
      origAlpha = random(255);
    }
  }
}
