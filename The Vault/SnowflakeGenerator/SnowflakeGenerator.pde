PVector[] points;

void setup() {
  size(640, 640);

  points = new PVector[50];
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random((width < height ? width : height)/30*(1-i/float(points.length-1)), (width < height ? width : height)/10*(1-i/float(points.length-1))), -height/4*i/float(points.length-1));
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(cos(frameCount/600.0*TWO_PI), 1);

  beginShape();
  for (int j = 0; j < 6; j++) {
    pushMatrix();
    for (int i = 0; i < points.length; i++) {
      PVector point = new PVector(-points[i].x, points[i].y-height/8).rotate(TWO_PI*j/6.0);
      vertex(point.x, point.y);
    }

    for (int i = points.length-1; i >= 0; i--) {
      PVector point = new PVector(points[i].x, points[i].y-height/8).rotate(TWO_PI*j/6.0);
      vertex(point.x, point.y);
    }
    popMatrix();
  }
  endShape(CLOSE);
}
