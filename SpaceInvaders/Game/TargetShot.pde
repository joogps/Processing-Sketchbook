class TargetShot {
  float[] size = {5, 10};
  PVector pos;
  float speed = 1.5;

  TargetShot(Target target) {
    pos = new PVector(target.pos.x+target.size[0]/2-size[0]/2, target.pos.y+target.size[1]);

    targetShotSound.rewind();
    targetShotSound.play();
  }

  void display() {
    fill(255);
    noStroke();
    rect(pos.x, pos.y, size[0], size[1]);
  }

  void move() {
    pos.y+= speed;
  }

  void kill(int shotIndex) {
    if (pos.y - size[1]/2 > height)
      targetShots.set(shotIndex, null);
  }

  void hit(int shotIndex, Barrier barrier) {
    float widthStart = pos.x;
    float widthEnd = pos.x+size[0];

    float heightEnd = pos.y+size[1];

    if (barrier == null && ship != null) {
      if (widthEnd > ship.pos.x && widthStart < ship.pos.x+ship.size[0] && heightEnd > ship.pos.y) {
        targetShots.set(shotIndex, null);
        if (ship.hp > 1) {
          ship.hp--;

          hitSound.rewind();
          hitSound.play();
        } else {
          setNull();
          hud.gameOver = true;

          deathSound.play();
        }
      }
    } else if (barrier != null && widthEnd > barrier.pos.x && widthStart < barrier.pos.x+barrier.size[0] && heightEnd > barrier.pos.y) {
      targetShots.set(shotIndex, null);
      if (barrier.hp > 1)
        barrier.hp--;
      else
        barriers.set(barrier.barrierIndex, null);

      barrierHitSound.rewind();
      barrierHitSound.play();
    }
  }
}
