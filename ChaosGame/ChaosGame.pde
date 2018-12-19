PVector[] points;
ArrayList<PVector> random;

void setup() {
  size(320, 320);

  points = new PVector[3];
  points[0] = new PVector(width/2, height/10);
  points[1] = new PVector(width/10, height*9/10);
  points[2] = new PVector(width*9/10, height*9/10);

  random = new ArrayList<PVector>();

  PVector r = new PVector();
  for (int i = 0; i < points.length; i++)
    r.add(points[i]);

  random.add(r.div(points.length));
}

void draw() {
  background(0);

  noFill();
  stroke(255);

  for (int i = 0; i < random.size(); i++)
    point(random.get(i).x, random.get(i).y);

  for (int i = 0; i < 1000; i++) {
    PVector point = points[round(random(points.length-1))];
    PVector current = random.get(random.size()-1);

    float theta = atan2(point.y-current.y, point.x-current.x);
    float distance = dist(current.x, current.y, point.x, point.y);

    random.add(new PVector(current.x+cos(theta)*distance/2, current.y+sin(theta)*distance/2));
  }
}
