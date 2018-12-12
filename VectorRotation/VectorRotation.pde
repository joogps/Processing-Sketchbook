void setup() {
  size(640, 640);

  PVector[] corners = {new PVector(width/4, height/4), new PVector(width*3/4, height/4), new PVector(width*3/4, height*3/4), new PVector(width/4, height*3/4)};
  float angle = random(TWO_PI);

  noStroke();

  fill(100);
  beginShape();
  for (int i = 0; i < corners.length; i++)
    vertex(corners[i].x, corners[i].y);
  endShape();

  fill(80, 80, 255, 100);
  beginShape();
  for (int i = 0; i < corners.length; i++) {
    PVector rotatedVector = rotateVector(corners[i], new PVector(width/2, height/2), angle);
    vertex(rotatedVector.x, rotatedVector.y);
  }
  endShape();
}

PVector rotateVector(PVector origin, PVector center, float angle) {
  float x = center.x+(origin.x-center.x)*cos(angle)-(origin.y-center.y)*sin(angle);
  float y = center.y+(origin.x-center.x)*sin(angle)+(origin.y-center.y)*cos(angle);

  return new PVector(x, y);
}
