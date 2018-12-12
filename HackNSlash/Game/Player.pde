class Player {
  PVector pos;
  PVector vel;

  float size;

  float theta;
  float targetTheta;

  float superShot;
  int triggerSuperShot;

  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector();

    size = (width+height)/20;

    theta = -HALF_PI*round(random(3));
    targetTheta = PI-theta;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    rectMode(CENTER);

    fill((1-superShot)*255);
    rect(0, 0, size, size);

    fill(superShot*255);
    rect(size*0.35-size/20, -size*0.23, size/10, size/10);
    rect(size*0.35-size/20, size*0.23, size/10, size/10);
    popMatrix();

    aim();
  }

  void update() {
    pos.add(vel);
    vel.mult(0.9);

    theta = lerp(theta, targetTheta, 0.1);

    if (targetTheta < 0) {
      theta+= TWO_PI;
      targetTheta = TWO_PI+targetTheta;
    }
  }

  void shoot(boolean mouse) {
    if (key == ' ' || mouse) {
      PVector shotPos = rotateVector(new PVector(pos.x+size/2-size/20, pos.y), new PVector(pos.x, pos.y), theta);
      shots.add(new Shot(shotPos, size/(superShot > 1 ? 1 : 10), theta, "player", superShot > 1, shots.size()));

      if (superShot > 1) {
        superShot = 0;
        triggerSuperShot = 0;
      }
    }
  }

  void movePlayer() {
    if (up)
      vel.add(new PVector(cos(theta), sin(theta)).mult(size/10));

    if (down)
      vel.add(new PVector(cos(theta), sin(theta)).mult(-size/10));
  }

  void keyRotatePlayer() {
    if (right)
      targetTheta+= TWO_PI/16;

    if (left)
      targetTheta-= TWO_PI/16;
  }

  void mouseRotatePlayer() {
    targetTheta = atan2(mouseY-pos.y, mouseX-pos.x);
    theta = targetTheta;
  }

  void edges() {
    if (collideRectEdge(pos, size, size, theta) != null) {
      PVector edgePos = collideRectEdge(pos, size, size, theta);

      float[] angleConstraints = angleConstraints(edgePos);

      float minAngle = angleConstraints[0];
      float maxAngle = angleConstraints[1];

      int loops = round(random(5, 15));
      for (int i = 0; i < loops; i++) {
        float particleTheta = random(minAngle, maxAngle);
        particles.add(new Particle(edgePos.copy(), new PVector(cos(particleTheta), sin(particleTheta)).mult(random(1, 20)), random(size/2), particles.size()));
      }

      pos = new PVector(width/2, height/2);

      loops = round(random(5, 15));
      for (int i = 0; i < loops; i++)
        particles.add(new Particle(pos.copy(), PVector.random2D().mult(random(5, 10)), random(player.size/2), particles.size()));

      vel.mult(0);

      theta = PI*(random(1) < 0.5 ? 1 : -1);
      targetTheta = 0;
    }
  }

  void collideEnemy(Enemy enemy) {
    if (!enemy.die && ((!enemy.shooter && collideRectCircle(pos, size, size, theta, enemy.pos, enemy.size)) || (enemy.shooter && collideRectRect(pos, size, size, theta, enemy.pos, enemy.size, enemy.size, enemy.theta))))
      setGame();
  }

  void superShot() {
    if (hud.level >= 2) {
      if ((space || mousePressed) && triggerSuperShot > 10)
        superShot+= 1/75.0;
      else
        superShot = 0;

      if (space || mousePressed)
        triggerSuperShot++;
      else
        triggerSuperShot = 0;
    }
  }

  void aim() {
    if (triggerSuperShot > 10) {
      PVector aimPos = rotateVector(new PVector(pos.x+size/2, pos.y), new PVector(pos.x, pos.y), theta);

      PVector calcDist = aimPos.copy();
      while (calcDist.x < width && calcDist.x > 0 && calcDist.y < height && calcDist.y > 0)
        calcDist.add(cos(theta), sin(theta));

      float dist = dist(aimPos.x, aimPos.y, calcDist.x, calcDist.y);

      pushStyle();
      stroke((1-superShot)*255);
      line(aimPos.x, aimPos.y, aimPos.x+cos(theta)*dist*superShot, aimPos.y+sin(theta)*dist*superShot);
      popStyle();
    }
  }
}
