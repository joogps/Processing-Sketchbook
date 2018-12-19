import peasy.*;
PeasyCam cam;

PVector[] points;
ArrayList<PVector> random;

void setup() {
  size(320, 320, P3D);
  cam = new PeasyCam(this, height*6/5);

  points = new PVector[4];
  points[0] = new PVector(0, -height*2/5, 0);
  points[1] = new PVector(-width*2/5, height*2/5, height*2/5);
  points[2] = new PVector(width*2/5, height*2/5, height*8/20);
  points[3] = new PVector(0, height*2/5, -height*2/5);

  random = new ArrayList<PVector>();
  random.add(points[round(random(points.length-1))]);
}

void draw() {
  background(0);

  noFill();
  stroke(255);

  for (int i = 0; i < random.size(); i++)
    point(random.get(i).x, random.get(i).y, random.get(i).z);

  for (int i = 0; i < 10; i++) {
    PVector point = points[round(random(points.length-1))];
    PVector current = random.get(random.size()-1);

    random.add(new PVector((point.x+current.x)/2.0, (point.y+current.y)/2.0, (point.z+current.z)/2.0));
  }

  if (random.size() > 30000) {
    random = new ArrayList<PVector>();
    random.add(points[round(random(points.length-1))]);
  }
}
