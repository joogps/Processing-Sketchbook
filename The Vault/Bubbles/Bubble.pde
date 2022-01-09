class Bubble {
  PVector pos;
  PVector vel;
  PVector acc;

  float radius;

  float hue;
  float alpha;

  boolean collide;

  boolean beingDragged;
  PVector relativePos;

  Bubble(float x, float y, float _radius) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = PVector.random2D();

    radius = _radius;
    acc.setMag(radius*0.5);

    hue = random(255);
    alpha = random(-255/2, 0);

    collide = false;
    beingDragged = false;
  }

  void display() {
    stroke(hue % 255, 255, 255, alpha);
    strokeWeight(3);

    fill(0, 0, 255, alpha-255/2);

    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  void update() {
    hue+= randomGaussian() + random(0, random(0, 1));
    alpha+= random(0, 3);

    if (mousePressed) {
      PVector mouse = new PVector(mouseX, mouseY);
      mouse.sub(pos);

      float angle = map(atan2(mouse.y, mouse.x), -PI, PI, 0, TWO_PI);

      acc.x+= cos(angle) * mouse.normalize().mag() * 0.1;
      acc.y+= sin(angle) * mouse.normalize().mag() * 0.1;
    }

    if (random(0, 5) < 0.1)
      acc.add(PVector.random2D());  

    vel.add(acc);
    pos.add(vel);

    acc.mult(0.1);
    vel.mult(0.99);

    if (pos.x + radius >= width || pos.x - radius <= 0) {
      pos.x = pos.x + radius >= width ? width - radius : radius;
      vel.x*= -0.5;
    }

    if (pos.y + radius >= height || pos.y - radius <= 0) {
      pos.y = pos.y + radius >= height ? height - radius : radius;
      vel.y*= -0.5;
    }

    int outsideBall = 0;
    for (int i = 0; i < buubles.size(); i++) {
      float distance = PVector.sub(pos, buubles.get(i).pos).mag();

      if (distance <= radius + buubles.get(i).radius) {
        if (collide || buubles.get(i).collide) {
          PVector temp = vel;

          vel = buubles.get(i).vel;
          buubles.get(i).vel = temp;

          collide = false;
        }
      } else {
        outsideBall++;
      }
    }

    collide = outsideBall == buubles.size()-1 || collide;
  }
}
