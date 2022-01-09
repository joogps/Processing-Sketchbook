class Butterfly {
  PVector pos;
  PVector targetPos;

  float w;
  float h;

  float angle;
  float targetAngle;

  float flap;
  float targetFlap;

  color tint;
  color targetTint;

  PImage sprite;

  Butterfly(PImage s) {
    pos = new PVector(random(width), random(height));
    targetPos = pos.copy();

    float scale = random(0.5, 1);
    w = s.width*random(scale-0.1, scale+0.1);
    h = s.height*random(scale-0.1, scale+0.1);

    angle = random(TWO_PI);
    targetAngle = angle;

    flap = 1;
    targetFlap = flap;

    targetTint = color(random(255), 255, 255);
    tint = color(targetTint, 0);

    sprite = s;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle+HALF_PI);

    tint(tint);

    scale(flap, 1);

    imageMode(CENTER);
    image(sprite, 0, 0, w, h);
    popMatrix();
  }

  void update() {
    pos.lerp(targetPos, 0.1);
    angle = lerp(angle, targetAngle, 0.1);
    flap = lerp(flap, targetFlap, 0.1);
    tint = lerpColor(tint, targetTint, 0.01);
  }

  void updatePos() {
    if (random(1) < 0.005)
      targetPos.add(new PVector(cos(angle), sin(angle)).mult(random(25, 50)));
  }

  void updateAngle() {
    if (random(1) < 0.005)
      targetAngle+= random(-1, 1)*QUARTER_PI;
  }

  void updateFlap() {
    if (random(1) < 0.005)
      targetFlap = -targetFlap;
  }

  void kill() {
    float totalW = abs(h*sin(HALF_PI-angle))+abs(w*sin(angle));
    float totalH = abs(w*sin(HALF_PI-angle))+abs(h*sin(angle));

    float right = pos.x+totalW/2.0;
    float bottom = pos.y+totalH/2.0;
    float left = pos.x-totalW/2.0;
    float up = pos.y-totalH/2.0;

    if (left > width || up > height || right < 0 || bottom < 0)
      butterflies.remove(this);
  }
}
