class Ground {
  PVector pos1;
  PVector pos2;

  float w;
  float h;

  Ground() {
    w = groundSprite.width*5;
    h = groundSprite.height*5;

    pos1 = new PVector(0, height-h*1.5);
    pos2 = new PVector(w, height-h*1.5);
  }

  void display() {
    image(groundSprite, pos1.x, pos1.y, w, h);
    image(groundSprite, pos2.x, pos2.y, w, h);
  }

  void update() {
    pos1.x-= dinosaur.speed;
    pos2.x-= dinosaur.speed;

    if (pos1.x+w < 0)
      pos1.x = pos2.x+w;

    if (pos2.x+w < 0)
      pos2.x = pos1.x+w;
  }
}
