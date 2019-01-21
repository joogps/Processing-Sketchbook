Box box1;
Box box2;

PVector walls;

int digits;
int collisions;

void setup() {
  size(640, 360);

  walls = new PVector(width/8, height*3/4);
  digits = 4;

  box1 = new Box(width/2, walls.y-50, 0, 50, 1);
  box2 = new Box(width, walls.y-100, -1/sqrt(pow(10, digits*2)), 100, pow(10, digits*2));
}

void draw() {
  background(0);
  stroke(255);
  line(walls.x, walls.y, width, walls.y);
  line(walls.x, 0, walls.x, walls.y);

  textAlign(RIGHT, TOP);
  textSize(30);
  text(collisions, width-textDescent()/2.0, 0);

  box1.display();
  box2.display();

  for (int i = 0; i < sqrt(box2.mass); i++) {
    box1.update();
    box2.update();

    checkCollisions();
    checkWalls();
  }
}

void checkCollisions() {
  if (box1.pos.x+box1.size >= box2.pos.x && box1.pos.x < box2.pos.x+box2.size) {
    //https://en.wikipedia.org/wiki/Elastic_collision

    float vel1x = box1.vel.copy().x;
    box1.vel.x = (box1.mass-box2.mass)/(box1.mass+box2.mass)*vel1x+(2*box2.mass)/(box1.mass+box2.mass)*box2.vel.copy().x;
    box2.vel.x = (2*box1.mass)/(box1.mass+box2.mass)*vel1x+(box2.mass-box1.mass)/(box1.mass+box2.mass)*box2.vel.copy().x;

    collisions++;
  }
}

void checkWalls() {
  box1.walls();
  box2.walls();
}
