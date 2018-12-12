class Ship {
  float[] size = {30, 40};
  PVector pos = new PVector(hud.size+(width-hud.size)/2-size[0]/2, height-size[1]);
  boolean posIncrease = true;
  float speed = 2;

  int hp = 3;

  void display() {
    fill(255, map(hp, 3, 1, 255, 0), map(hp, 3, 1, 255, 0));
    noStroke();
    rect(pos.x, pos.y, size[0], size[1]);
  }

  void move() {
    if (hud.start) {
      if (posIncrease) 
        pos.x+= speed;
      else
        pos.x-= speed;

      if (pos.x+size[0]/2 >= width)
        posIncrease = false;

      if (pos.x - size[0]/2 <= 130)
        posIncrease = true;
    }
  }

  void shoot() {
    if (hud.start) {
      shots.add(new Shot());
      hud.attempts++;
    }
  }
}
