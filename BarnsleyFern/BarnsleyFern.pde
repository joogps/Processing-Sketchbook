ArrayList<PVector> points;

void setup() {
  size(460, 620);

  points = new ArrayList<PVector>();
  points.add(new PVector(0, 0));
}

void draw() {
  background(0);

  stroke(0, 255, 0);
  for (int i = 0; i < points.size(); i++)
    point(map(points.get(i).x, -2.1820, 2.6558, 0, width), map(points.get(i).y, 9.9983, 0, 0, height));

  for (int i = 0; i < 100; i++) {
    PVector currentPoint = points.get(points.size()-1);
    PVector newPoint = new PVector(0, 0);

    float r = random(1);
    if (r > 0.99) {
      newPoint.x = 0;
      newPoint.y = currentPoint.y*0.16;
    } else if (r > 0.92) {
      newPoint.x = currentPoint.x*0.2+currentPoint.y*-0.26;
      newPoint.y = currentPoint.x*0.23+currentPoint.y*0.22+1.6;
    } else if (r > 0.85) {
      newPoint.x = currentPoint.x*-0.15+currentPoint.y*0.28;
      newPoint.y = currentPoint.x*0.26+currentPoint.y*0.24+0.44;
    } else {
      newPoint.x = currentPoint.x*0.85+currentPoint.y*0.04;
      newPoint.y = currentPoint.x*-0.04+currentPoint.y*0.85+1.6;
    }

    points.add(newPoint);
  }
}
