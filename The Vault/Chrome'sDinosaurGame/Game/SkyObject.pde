class SkyObject {
  PVector pos;

  float w;
  float h;

  float speed;

  PImage sprite;

  SkyObject(float x, float y, float s, PImage _sprite) {
    sprite = _sprite;

    float scale = random(1.5, 3);

    w = sprite.width*scale;
    h = sprite.height*scale;

    speed = (w+h)/2*s;

    pos = new PVector(x, y);
  }

  void display() {
    image(sprite, pos.x, pos.y, w, h);
  }

  void update() {
    if (dinosaur.move && !dinosaur.dead)
      pos.x-= speed;
  }
}
