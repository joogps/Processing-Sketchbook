class PowerUp {
  PVector pos;
  PVector vel;
  PVector acc;

  PVector origPos;

  float size;

  String type;

  boolean move;

  Block parentBlock;

  float scrollChange;

  PowerUp(Block block, String _type) {
    parentBlock = block;

    pos = block.pos.copy();
    vel = new PVector(random(0, 1) < 0.5 ? -1 : 1, 0);
    acc = new PVector(0, 0.1);

    origPos = pos.copy();

    size = block.size/2;

    type = _type;

    if (!type.equals("good") && !type.equals("bad")) {
      println("Type not valid.");
      noLoop();
    }

    scrollChange = player.scroll;
  }

  void display() {
    pushStyle();
    fill(type.equals("good") ? 255 : 0);
    ellipse(pos.x, pos.y, size, size);
    popStyle();
  }

  void update() {
    if (!move) {
      pos.y--;
    } else {
      pos.add(vel);
      vel.add(acc);
    }

    if (pos.y < parentBlock.pos.y-parentBlock.size/2-size/2) {
      move = true;
    }

    if (pos.x < 0 || pos.x > width) {
      vel.x*= -1;
    }

    if (scrollChange != player.scroll)
      pos.x-= scrollChange-player.scroll;

    scrollChange = player.scroll;
  }

  void block(Block b) {
    if (move) {
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
      p.targetSize*= type.equals("good") ? 1.5 : 0.5;
      powerUps[parentBlock.index]  = null;
    }
  }
}
