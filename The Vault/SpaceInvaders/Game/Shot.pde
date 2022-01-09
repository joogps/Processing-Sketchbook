class Shot {
  float[] size = {10, 20};
  PVector pos = new PVector(ship.pos.x, height - ship.size[1]+size[1]/2);
  float speed = ship.speed*1.5;

  Shot() {
    shotSound.rewind();
    shotSound.play();
  }

  void display() {
    fill(255);
    noStroke();
    rect(pos.x, pos.y, size[0], size[1]);
  }

  void move() {
    pos.y-= speed;
  }

  void kill(int shotIndex) {
    if (pos.y+size[1]/2 < 0) 
      shots.set(shotIndex, null);
  }

  void hit(int shotIndex) {
    float widthStart = pos.x;
    float widthEnd = pos.x+size[0];

    float heightStart = pos.y;
    float heightEnd = pos.y+size[0];

    for (int i = 0; i < targets.size(); i++) {
      Target target = targets.get(i);
      if (target != null && widthStart < target.pos.x+target.size[0] && widthEnd > target.pos.x && heightStart < target.pos.y+target.size[1] && heightEnd > target.pos.y) {
        targets.set(i, null);

        if (i - 1 >= 0 && i < indexesShooterTargets.size() && indexesShooterTargets.get(indexesShooterTargets.indexOf(i)) != null)
          indexesShooterTargets.set(indexesShooterTargets.indexOf(i), i - 1);


        shots.set(shotIndex, null);
        hud.points++;

        targetSound.rewind();
        targetSound.play();

        if (speed <= 30 && random(0, 1) < 0.5) 
          ship.speed*= 1.02;
      }
    }
  }
}
