class Shot {
  PVector pos;
  PVector vel;

  float size;

  float theta;

  String type;

  boolean superShot;

  int index;

  Shot(PVector p, float s, float a, String t, boolean sShot, int i) {
    pos = p;

    size = s;

    theta = a;

    type = t;

    vel = new PVector(cos(theta), sin(theta)).mult(random(3, 5)*(sShot ? 5 : 1));

    superShot = sShot;

    index  = i;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    rectMode(CENTER);
    fill((1-player.superShot)*255);

    rect(0, 0, size, size);
    popMatrix();
  }

  void update() {
    pos.add(vel);
  }

  void edges() {   
    if (collideRectEdge(pos, size, size, theta) != null) {
      PVector edgePos = collideRectEdge(pos, size, size, theta);

      float[] angleConstraints = angleConstraints(edgePos);

      float minAngle = angleConstraints[0];
      float maxAngle = angleConstraints[1];

      if (superShot) {
        int loops = round(random(5, 15));
        for (int i = 0; i < loops; i++) {
          float particleTheta = random(minAngle, maxAngle);
          particles.add(new Particle(edgePos.copy(), new PVector(cos(particleTheta), sin(particleTheta)).mult(random(1, 20)), random(size/2), particles.size()));
        }
      }

      if (type == "player")
        shots.set(index, null);
      else if (type == "enemy")
        enemyShots.set(index, null);
    }
  }

  void collideEnemy(Enemy enemy) {
    if (!enemy.die && collideRectCircle(pos, size, size, theta, enemy.pos, enemy.size)) {
      hud.score();

      if (!enemy.stronger || (enemy.stronger && enemy.lifes == 0) || superShot) {
        enemy.die = true;

        int loops = round(random(5, 15));
        for (int i = 0; i < loops; i++)
          particles.add(new Particle(pos.copy(), PVector.random2D().mult(random(5, 10)), random(enemy.size/2), particles.size()));

        if (!superShot)
          shots.set(index, null);
      } else {
        enemy.lifes--;

        int loops = round(random(5*(3-enemy.lifes)/3, 15*(3-enemy.lifes)/3));
        for (int i = 0; i < loops; i++)
          particles.add(new Particle(pos.copy(), PVector.random2D().mult(random(5*(3-enemy.lifes)/3, 10*(3-enemy.lifes)/3)), random(enemy.size/2*(3-enemy.lifes)/3), particles.size()));

        shots.set(index, null);
      }
    }
  }

  void collidePlayer() {
    if (collideRectRect(pos, size, size, theta, player.pos, player.size, player.size, player.theta))
      setGame();
  }

  void collideEnemyShot(Shot enemyShot) {
    if (collideRectRect(pos, size, size, theta, enemyShot.pos, enemyShot.size, enemyShot.size, enemyShot.theta)) {
      shots.set(index, null);
      enemyShots.set(enemyShot.index, null);
    }
  }
}
