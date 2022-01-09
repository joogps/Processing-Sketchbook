class Player {
  PVector pos;
  PVector vel;
  PVector acc;

  float size;
  float targetSize;

  boolean right;
  boolean left;

  boolean jumping;

  float scroll;
  float minScroll;
  float maxScroll;

  int coins;

  Player(float x, float y, float _minScroll, float _maxScroll) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0.05);

    size = 20;
    targetSize = size;

    jumping = true;

    minScroll = abs(_minScroll);
    maxScroll = -abs(_maxScroll);

    coins = 0;
  }

  void display() {
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);

    if (right && !left) {
      if (pos.x > width/4*3 && scroll > maxScroll+width)
        scroll-= 2;
      else
        pos.x+= 2;
    }

    if (left && !right && pos.x - size/2 > 0) {
      if (pos.x < width/4 && scroll < minScroll)
        scroll+= 2;
      else
        pos.x-= 2;
    }

    size = lerp(size, targetSize, 0.2);
    if (targetSize-size < 0.01)
      size = targetSize;

    if (pos.y - size/2 > height)
      setGame();
  }

  void platform(Platform p) {
    float theta = atan2(p.pos2.y-p.pos1.y, p.pos2.x-p.pos1.x);
    int colliding = 0;

    for (float l = 0; l <= dist(p.pos1.x, p.pos1.y, p.pos2.x, p.pos2.y); l+= 1) {
      float x = p.pos1.x+cos(theta)*l;
      float y = p.pos1.y+sin(theta)*l;

      if (dist(x, y, pos.x, pos.y) <= size/2) {
        if (!(abs(theta) == HALF_PI || abs(theta) == PI*1.5)) {
          pos.y = y+sin(atan2(pos.y-y, pos.x-x))*size/2;

          vel.y = 0;
          acc.y = 0;

          jumping = false;

          colliding++;
        } else {
          pos.x = dist(pos.x-size/2, pos.y, x, y) < dist(pos.x+size/2, pos.y, x, y) ? x+size/2+1 : x-size/2-1;

          right = false;
          left = false;
        }
      }
    }

    p.colliding = colliding != 0;
  }

  void block(Block b) {
    if (pos.x + size/2 > b.pos.x-b.size/2 && pos.x-size/2 < b.pos.x+b.size/2 && pos.y - size/2 < b.pos.y + b.size/2 && pos.y + size/2 > b.pos.y - b.size/2) {
      if (pos.y > b.pos.y + b.size/2 || pos.y < b.pos.y - b.size/2) {
        if (vel.y < 0 && pos.y > b.pos.y + b.size/2) {
          vel.y*= -1;
          if (!b.hit && !b.type.equals("hit")) {
            b.pos.y = pos.y - size - b.size;
            b.hit = true;
          }
        } else if (pos.y < b.pos.y - b.size/2) {
          vel.y = vel.y < 0 ? vel.y : 0;
          pos.y = b.pos.y - b.size/2 - size/2;

          b.colliding = true;
          jumping = false;
        }
      } else {
        if (pos.x < b.pos.x) {
          right = false;
          pos.x = b.pos.x-b.size/2-size/2-1;
        } else {
          left = false;
          pos.x = b.pos.x+b.size/2+size/2+1;
        }
      }
    } else {
      b.colliding = false;
    }
  }

  void jump() {
    if (!jumping) {
      acc.y = 0.05;
      vel.y = -2*(size/20);
      jumping = true;
    }
  }

  void canJump(Platform[][] ps, Block[] bs) {
    int colliding = 0;

    for (int i = 0; i < ps.length; i++) {
      for (int j = 0; j < ps[i].length; j++) {
        colliding+= ps[i][j].colliding ? 1 : 0;
      }
    }

    for (int i = 0; i < bs.length; i++) {
      colliding+= bs[i].colliding ? 1 : 0;
    }

    if (colliding == 0) {
      acc.y = 0.05;
      jumping = true;
    }
  }
}
