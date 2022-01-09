class Target {
  float[] size;
  PVector pos;

  PVector move = new PVector(1, 0);
  float moveDelay = frameRate*1.5;

  Target(float x, float y, float w, float h) {
    size = new float[2];
    size[0] = w;
    size[1] = h;

    pos = new PVector(x, y);
  }

  void display() {
    fill(255);
    noStroke();
    rect(pos.x, pos.y, size[0], size[1]);
  }

  void move() {
    if (hud.start) {
      if (moveDelay <= 0) {
        if (abs(move.x) <= 1)
          pos.x+= move.x*3;

        pos.y+= move.y*3;

        if (move.y == 1) {
          move.x/= -2;
          move.y = 0;
        } else if (abs(move.x) == 1) {
          move.x = move.x*2;
          move.y = 1;
        }

        moveDelay = frameRate*1.5;
      } else {
        moveDelay--;
      }

      if (pos.y+size[1] > hud.limit) {
        setNull();
        hud.gameOver = true;

        deathSound.play();
      }
    }
  }
}
