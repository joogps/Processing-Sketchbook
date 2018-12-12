void setup() {
  size(1000, 350);
}

void draw() {
  PVector sunPos = new PVector(mouseX, mouseY);

  noStroke();

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x+y*width] = color(map(dist(x, y, sunPos.x, sunPos.y), 0, width+height, 200, 0), map(dist(x, y, sunPos.x, sunPos.y), 0, width+height, 220, 0), 255);
    }
  }
  updatePixels();

  fill(255, 255, 0);
  ellipse(sunPos.x, sunPos.y, 80, 80);

  fill(70, 180, 20);
  rect(-1, 300, width+1, 120);

  fill(40, 60, 240);
  rectMode(CORNERS);
  rect(width/3.5, 210, width-width/3.5, 330);

  fill(200);
  rect(width/2.1, 240, width-width/3.25, 330-30, 10);

  rectMode(CORNER);
  rect(width/3.25, 240, 65, 330-240, 30, 30, 0, 0);

  fill(50, 80);

  float angle = map(-atan2(sunPos.x-width/2, sunPos.y-120), -HALF_PI, TWO_PI-HALF_PI, 0, TWO_PI);

  beginShape();
  vertex(width/3.5, 330);
  vertex(width-width/3.5, 330);

  vertex(width-width/3.5-cos(angle)*(width/3*5)/4, 330+(330-210));
  vertex(width/3.5-cos(angle)*(width/3*5)/4, 330+(330-210));
  endShape(CLOSE);

  fill(150, 70, 40);
  triangle(width/2, 120, width/4, 210, width-width/4, 210);
}
