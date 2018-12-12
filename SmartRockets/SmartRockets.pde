Rockets rockets;
Barrier[] barriers;
Target target;

int targetReached;

void setup() {
  size(860, 640);

  rockets = new Rockets();

  barriers = new Barrier[3];
  barriers[0] = new Barrier(width/5, height/6, width-width/8*6, 3);
  barriers[1] = new Barrier(width-width/5, height/6, width-width/8*6, 3);

  barriers[2] = new Barrier(width/2, height/1.75, width/2.5, 3);

  target = new Target(width/2, height/6, 50);
}

void draw() {
  background(0);

  rockets.display();
  rockets.update();

  target.display();

  for (int i = 0; i < barriers.length; i++)
    barriers[i].display();

  fill(255);

  textSize(30);
  textAlign(LEFT, TOP);
  text(targetReached, 5, 0);
}
