class Dinosaur {
  PVector pos;
  PVector vel;
  PVector acc;

  float w;
  float h;

  float speed;

  boolean jumping;
  boolean crouching;

  boolean firstJump;

  boolean move = frameCount != 0;
  boolean dead;

  PImage dinosaurSprite;

  Dinosaur() {
    dinosaurSprite = dinosaurStill;

    w = dinosaurRun[0].width * 1.7;
    h = dinosaurRun[0].height * 1.7;

    pos = new PVector(w/3, height-(h+h/5));

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void display() {
    if (move && !dead && !jumping && speed > 0) {
      int index = round(frameCount/(speed*3)%1);

      if (!crouching)
        dinosaurSprite = dinosaurRun[index];
      else
        dinosaurSprite = dinosaurCrouch[index];
    }

    image(dinosaurSprite, pos.x, pos.y, w, h);

    w = dinosaurSprite.width * 1.7;
    h = dinosaurSprite.height * 1.7;

    if (!jumping)
      pos.y = height-(h+h/(crouching ? 3 : 5));
  }

  void update() {
    if ((move && !dead) || firstJump) {
      pos.add(vel);
      vel.add(acc);

      crouching = keyPressed && keyCode == DOWN;
    }

    if (move && !dead)
      speed = 7.5;

    if (pos.y >= height-(h+h/5) && vel.y > 0) {
      vel.y = 0;
      acc.y = 0;

      jumping = false;

      move = true;
    }

    if (keyPressed && !dead) {
      firstJump = !move;

      if (keyCode != DOWN && !jumping) {
        if (move) {
          dinosaurJumpSound.rewind();
          dinosaurJumpSound.play();
        }

        vel.y = -12;
        acc.y = 0.5;

        dinosaurSprite = dinosaurStill;

        jumping = true;
      } else if (!jumping)
        move = true;
    }
  }

  void collide(Cactus cactus, Bird bird) {
    float x = cactus != null ? cactus.pos.x : bird != null ? bird.pos.x : null;
    float y = cactus != null ? cactus.pos.y : bird != null ? bird.pos.y : null;
    float wdt = cactus != null ? cactus.w : bird != null ? bird.w : null;
    float hgt = cactus != null ? cactus.h : bird != null ? bird.h : null;
    PImage sprite = cactus != null ? cactus.cactusSprite : bird != null ? bird.birdSprite : null;

    if (pos.x+w > x && pos.x < x+wdt && pos.y+h > y && pos.y < y+hgt && !dead) {
      dinosaurSprite.loadPixels();
      for (int dinoX = 0; dinoX < dinosaurSprite.width-1; dinoX++) {
        for (int dinoY = 0; dinoY < dinosaurSprite.height-1; dinoY++) {
          if (alpha(dinosaurSprite.pixels[dinoX+dinoY*dinosaurSprite.width]) > 0) {
            sprite.loadPixels();
            for (int cactusX = 0; cactusX < sprite.width-1; cactusX++) {
              for (int cactusY = 0; cactusY < sprite.height-1; cactusY++) {
                if (alpha(sprite.pixels[cactusX+cactusY*sprite.width]) > 0) {
                  float dX = map(dinoX, 0, dinosaurSprite.width, 0, w) + pos.x;
                  float dY = map(dinoY, 0, dinosaurSprite.height, 0, h) + pos.y;

                  float cX = map(cactusX, 0, sprite.width, 0, wdt) + x;
                  float cY = map(cactusY, 0, sprite.height, 0, hgt) + y;

                  if (dist(dX, dY, cX, cY) < 1) {
                    dinosaurDieSound.play();

                    dead = true;
                    speed = 0;
                    dinosaurSprite = dinosaurDead;

                    if (hud.score > hud.highScore)
                      hud.highScore = hud.score;
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  void restart() {
    if (dead) {
      setGame();
    }
  }
}
