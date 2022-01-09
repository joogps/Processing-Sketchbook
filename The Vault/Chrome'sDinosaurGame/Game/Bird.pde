class Bird {
  PVector pos;
  PVector vel;

  float w;
  float h;

  float speed;

  PImage birdSprite;

  Bird() {
    birdSprite = birdSprites[0];

    w = birdSprite.width*1.8;
    h = birdSprite.height*1.8;

    speed = random(2, 3);

    pos = new PVector(width*random(2, 2.5), random(0, 1) < 0.5 ? dinosaur.h/2 : dinosaur.pos.y+w*0.2);
    vel = new PVector(0, 0);
  }

  void display() {
    if (dinosaur.move && !dinosaur.dead)
      birdSprite = birdSprites[round(map(frameCount%(speed*13), 0, speed*13, 0, 1))];

    image(birdSprite, pos.x, pos.y, w, h);
  }

  void update() {
    pos.add(vel);

    if (dinosaur.move && !dinosaur.dead)
      vel = new PVector(-dinosaur.speed/2.25-speed, cos(TWO_PI*frameCount/60));
    else
      vel = new PVector(0, 0);
  }
}
