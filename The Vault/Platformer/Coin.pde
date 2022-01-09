class Coin {
  PVector pos;
  PVector origPos;

  float alpha;

  float size;

  int index;

  Coin(float x, float y, int i) {
    pos = new PVector(x, y);
    origPos = pos.copy();

    alpha = 255;

    size = 15;

    index = i;
  }

  void display() {
    ellipse(pos.x, pos.y, size, size);
  }

  void update() {
    pos.x = origPos.x + player.scroll;
  }

  void player(Player p) {
    if (dist(pos.x, pos.y, p.pos.x, p.pos.y) < size/2 + p.size/2) {
      player.coins++;
      coins[index] = null;
    }
  }
}
