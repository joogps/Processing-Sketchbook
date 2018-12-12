Crate crate;
ArrayList<PVector> forces;

void setup() {
  size(640, 360);
  forces = new ArrayList<PVector>();
  forces.add(new PVector(0, 1));
  forces.add(new PVector(0, -2));

  crate = new Crate(width/2, height/2, forces);
}

void draw() {
  background(200);
  crate.display();
  crate.update();
}
