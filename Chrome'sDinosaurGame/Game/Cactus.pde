class Cactus {
  PVector pos;
  PVector origPos;

  float w;
  float h;

  PImage cactusSprite;

  Cactus(float x) {
    cactusSprite = cactusSprites[round(random(cactusSprites.length-1))];

    w = cactusSprite.width*random(1.4, 1.8);
    h = cactusSprite.height*random(1.4, 1.8);

    pos = new PVector(x, height-(h+h/8)+random(-h/15, h/15));
  }

  void display() {
    image(cactusSprite, pos.x, pos.y, w, h);
  }

  void update() {
    pos.x-= dinosaur.speed;
  }
}
