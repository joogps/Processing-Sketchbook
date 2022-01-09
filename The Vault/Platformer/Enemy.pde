class Enemy {
  PVector pos;
  PVector vel;
  PVector acc;

  PVector origPos;

  float size;

  float scrollChange;

  boolean move;

  int index;

  Enemy(float x, float y, int i) {
    pos = new PVector(x, y);
    vel = new PVector(-1, 0);
    acc = new PVector(0, 0.1);

    origPos = pos.copy();

    size = 15;

    scrollChange = player.scroll;

    index = i;
  }

  void display() {
    pushStyle();
    fill(0);
    ellipse(pos.x, pos.y, size, size);

    fill(255);
    noStroke();
    ellipse(pos.x-size/4, pos.y-size/4, size/6, size/6);
    ellipse(pos.x+size/4, pos.y-size/4, size/6, size/6);
    popStyle();
  }

  void update() {
    if (move) {
      pos.add(vel);
      vel.add(acc);
    }

    if (pos.x+size/2 > 0 && pos.x-size/2 < width) {
      move = true;
    }

    if (scrollChange != player.scroll) 
      pos.x-= scrollChange-player.scroll;

    scrollChange = player.scroll;
  }

  void block(Block b) {
    if (pos.x + size/2 > b.pos.x-b.size/2 && pos.x-size/2 < b.pos.x+b.size/2 && pos.y - size/2 < b.pos.y + b.size/2 && pos.y + size/2 > b.pos.y - b.size/2) {
      if (pos.y < b.pos.y - b.size/2) {
        vel.y = 0;
        acc.y = 0.05;
        pos.y = b.pos.y - b.size/2 - size/2;
      } else {
        vel.x*= -1;
      }
    }
  }

  void platform(Platform p) {
    float theta = atan2(p.pos2.y-p.pos1.y, p.pos2.x-p.pos1.x);

    for (float l = 0; l < dist(p.pos1.x, p.pos1.y, p.pos2.x, p.pos2.y); l+= 1) {
      float x = p.pos1.x + cos(theta)*l;
      float y = p.pos1.y + sin(theta)*l;

      if (dist(x, y, pos.x, pos.y) <= size/2) {
        if (!(abs(theta) == HALF_PI || abs(theta) == PI*1.5)) {
          pos.y = y + sin(atan2(pos.y-y, pos.x-x))*size/2;

          vel.y = 0;
          acc.y = 0.05;
        } else {
          pos.x = dist(pos.x-size/2, pos.y, x, y) < dist(pos.x+size/2, pos.y, x, y) ? x + size/2+1 : x - size/2-1;
          vel.x*= -1;
        }
      }
    }
  }

  void player(Player p) {
    if (dist(pos.x, pos.y, p.pos.x, p.pos.y) < size/2 + p.size/2) {
      if (p.vel.y > 0 && p.jumping) {
        enemies[index] = null;
      } else {
        noLoop();
      }
    }
  }
}
