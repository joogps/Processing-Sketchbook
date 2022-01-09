class Bird {
  PVector pos;
  PVector vel;
  PVector acc;

  float radius;

  boolean move;
  boolean dead;

  Bird(float x, float y, float r) {
    pos = new PVector(x, y);
    vel = new PVector(0, 1);
    acc = new PVector(0, 0);

    radius = r;

    move = false;
    dead = false;
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  void flap() { 
    vel.mult(0);
    acc.sub(new PVector(0, 3));

    move = true;
  }

  void edges() {
    if (pos.y + radius >= height || pos.y - radius <= 0) {
      dead = true;

      if (pos.y - radius <= 0) {
        acc.mult(-1);
        if (deathLine == null) {
          deathLine = new DeathLine(new PVector(pos.x, 0), new PVector(1, 0));
        }
      } else {
        pos.y = height-radius;
        vel = new PVector(0, 0);
        if (deathLine == null) {
          deathLine = new DeathLine(new PVector(pos.x, height-1), new PVector(1, 0));
        }
      }
    }
  }

  void hit(Pipe pipe) {
    for (float a = 0; a < TWO_PI; a+= 0.01) {
      float x = pos.x + cos(a) * radius;
      float y = pos.y + sin(a) * radius;

      if ((x >= pipe.x && x <= pipe.x + pipe.pipeWidth) && (y <= pipe.yOpening || y >= pipe.yOpening + pipe.spacing)) {
        dead = true;
        vel = new PVector(0, 0);
        if (deathLine == null) {
          deathLine = new DeathLine(new PVector(x, y), PVector.fromAngle((a+HALF_PI) % TWO_PI));
        }
      }
    }
    
    if (!dead) {
      if (pos.x + radius >= pipe.x && pos.x + radius <= pipe.x + pipe.pipeWidth) {
        pipe.birdInside = true;
      }
      else if(pipe.birdInside){
        pipe.birdInside = false;
        score.increaseScore(1);
      }
    }
  }

  void update() {
    vel.add(acc);
    pos.add(vel);

    if (move) {
      acc.mult(0);

      vel.add(new PVector(0, 0.1));
    } else {
      vel = new PVector(0, cos(TWO_PI * frameCount / 90));
    }
  }
}
