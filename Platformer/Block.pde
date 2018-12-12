class Block {
  PVector pos;
  PVector origPos;

  float size;

  boolean hit;
  boolean colliding;

  int index;

  String type;

  boolean powerUpCreated;
  boolean coinCreated;

  float coinY;
  float coinAlpha;

  Block(float x, float y, int i, String _type) {
    pos = new PVector(x, y);
    origPos = pos.copy();

    size = 30;

    index = i;

    type = _type;

    if (!type.equals("hit") && !type.equals("coin") && (type.length() >= 7 && !type.substring(0, 7).equals("powerup"))) {
      println("Type not valid.");
      noLoop();
    }

    coinY = pos.y;
    coinAlpha = 255;
  }

  void display() {
    if (coinCreated) {
      pushStyle();
      fill(255, coinAlpha);
      stroke(0, coinAlpha);

      ellipse(pos.x, coinY, size*0.5, size*0.5);
      popStyle();
    }

    pushStyle();
    fill(hit || type == "hit" ? 0 : 255);

    rectMode(CENTER);
    rect(pos.x, pos.y, size, size);
    popStyle();
  }

  void update() {
    if (hit && abs(pos.y-origPos.y) <= 1 && !coinCreated && !powerUpCreated) {
      if (type == "coin") {
        player.coins++;
        coinCreated = true;
      } else if (type.length() >= 7 && type.substring(0, 7).equals("powerup")) {
        powerUps[index] = new PowerUp(this, type.substring(7, type.length()));
        powerUpCreated = true;
      }

      pos.y = origPos.y;
    }

    if (coinCreated) {
      coinY-= 2;
      coinAlpha-= 7;
    }

    pos.y = lerp(pos.y, origPos.y, 0.25);

    pos.x= origPos.x + player.scroll;
  }
}
