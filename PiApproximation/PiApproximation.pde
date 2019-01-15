PVector pos1;
PVector vel1;
float mass1;

PVector pos2;
PVector vel2;
float mass2;

int collisions;

void setup() {
  size(640, 360);

  pos1 = new PVector(width/2, height*3/4-50);
  mass1 = 1;
  vel1 = new PVector();

  pos2 = new PVector(width, height*3/4-100);
  mass2 = 100000000;
  vel2 = new PVector(-1/sqrt(mass2), 0);
}

void draw() {
  background(0);
  stroke(255);
  line(width/8, height*3/4, width, height*3/4);
  line(width/8, 0, width/8, height*3/4);

  textAlign(RIGHT, TOP);
  textSize(30);
  text(collisions, width-textDescent()/2.0, 0);

  rect(pos1.x, pos1.y, 50, 50);
  rect(pos2.x, pos2.y, 100, 100);

  for (int i = 0; i < sqrt(mass2); i++) {
    pos1.add(vel1);
    pos2.add(vel2);

    checkCollisions();
    checkWall();
  }
}

void checkCollisions() {
  if (pos1.x+50 >= pos2.x) {
    //https://en.wikipedia.org/wiki/Elastic_collision

    float vel1x = vel1.copy().x;
    vel1.x = (mass1-mass2)/(mass1+mass2)*vel1x+(2*mass2)/(mass1+mass2)*vel2.copy().x;
    vel2.x = (2*mass1)/(mass1+mass2)*vel1x+(mass2-mass1)/(mass1+mass2)*vel2.copy().x;

    collisions++;
  }
}

void checkWall() {
  if (pos1.x <= width/8) {
    vel1.mult(-1);
    collisions++;
  }

  if (pos2.x <= width/8) {
    vel2.mult(-1);
    collisions++;
  }
}
