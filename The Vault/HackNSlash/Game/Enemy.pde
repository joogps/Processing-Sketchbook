class Enemy {
  PVector pos;
  PVector vel;

  float speed;

  float size;

  float theta;

  float alpha;
  boolean die;

  int index;

  boolean shooter;
  int timer;
  int delay;

  boolean stronger;
  int lifes;

  Enemy(int i) {
    size = (width+height)/random(25, 35);

    if (random(1) < 0.5)
      pos = new PVector(random(width), random(1) < 0.5 ? -size/2 : height+size/2);
    else
      pos = new PVector(random(1) < 0.5 ? -size/2 : width+size/2, random(height)); 

    vel = new PVector();

    speed = random(0.5, 2.5);

    alpha = 255;

    index = i;

    float r = random(1);

    if (hud.level > 2)
      shooter = r <= 0.15;

    if (shooter) {
      timer = millis();
      delay = round(random(0.5, 2)*1000);
    }

    if (hud.level > 1)
      stronger = r <= 0.3 && !shooter;

    if (stronger)
      lifes = round(random(1, 3));
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);

    fill((1-player.superShot)*255, alpha);

    if (!shooter)
      ellipse(0, 0, size, size);
    else {
      rectMode(CENTER);
      rect(0, 0, size, size);
    }

    if (stronger) {
      pushStyle();
      noFill();

      stroke(player.superShot*255);

      for (int i = 0; i < lifes; i++) 
        ellipse(0, 0, size*(0.8-i*0.2), size*(0.8-i*0.2));
      popStyle();
    }
    popMatrix();
  }

  void update() {
    vel = new PVector(cos(theta), sin(theta)).mult(speed);
    pos.add(vel);

    if (shooter && millis()-timer > delay) {
      enemyShots.add(new Shot(pos.copy(), size/5, theta, "enemy", false, enemyShots.size()));
      timer = millis();
    }
  }

  void die() {
    if (die) {
      alpha = lerp(alpha, 0, 0.3);

      if (alpha < 1)
        enemies.set(index, null);
    }
  }

  void target(Player player) {
    theta = atan2(player.pos.y-pos.y, player.pos.x-pos.x);
  }
}
