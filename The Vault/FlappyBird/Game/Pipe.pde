class Pipe {
  float x;
  float yOpening;

  float spacing;
  float pipeWidth;

  Bird bird;
  boolean birdInside;

  boolean move;
  float timing;

  Pipe(float _x, Bird _bird) {
    x = _x;

    bird = _bird;

    spacing = _bird.radius*6;
    yOpening = random(25, height-25-spacing);
    pipeWidth = bird.radius*3;

    birdInside = false;

    move = random(0, 1) > 0.5;
    timing = random(30, 150);
  }

  void display() {
    fill(0);

    rect(x, -height, pipeWidth, yOpening + height);
    rect(x, yOpening + spacing, pipeWidth, height);
  }

  void update() {
    if (!bird.dead && bird.move)
      x--;

    if (!bird.dead && move)
      yOpening+= cos(TWO_PI * frameCount / timing) * 2;
  }
}
