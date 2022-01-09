PVector arrowPos;
PVector startingPos;

void setup() {
  size(640, 640);

  arrowPos = new PVector(0, 0);
  startingPos = new PVector(random(width), random(height));
}

void draw() {
  PVector mouse = new PVector(mouseX, mouseY);
  mouse.sub(startingPos.x, startingPos.y);

  float theta = atan2(mouse.x-arrowPos.x, mouse.y-arrowPos.y);
  PVector vel = new PVector(sin(theta), cos(theta));
  vel.mult(2);

  arrowPos.add(vel);

  background(130);

  translate(startingPos.x+arrowPos.x, startingPos.y+arrowPos.y);
  rotate(-theta);

  beginShape();
  vertex(0, 0);
  vertex(-10, -10);
  vertex(-5, -10);
  vertex(-5, -20);
  vertex(5, -20);
  vertex(5, -10);
  vertex(10, -10);
  vertex(0, 0);
  endShape();
}
