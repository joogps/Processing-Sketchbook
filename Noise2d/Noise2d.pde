float startX = 0;
float startY = 0;

void setup() {
  size(640, 640);
}

void draw() {
  background(255);
  ellipseMode(CORNER);
  
  float xoff = startX;
  for (int x = 0; x < width; x++) {
    float yoff = startY;
    for (int y = 0; y < height; y++) {
      float size = map(noise(xoff, yoff), 0, 1, 1, 25);
      if(x % 25 == 0 && y % 25 == 0){
        fill(0);
        ellipse(x + random(-1, 1), y + random(-1, 1), size, size);
      }
      yoff+= 0.01;
    }
    xoff+= 0.01;
  }
  
  startX+= map(cos(TWO_PI * frameCount / 240), -1, 1, -0.1, 0.1);
  startY+= map(cos(TWO_PI * frameCount / 120), -1, 1, 0.1, -0.1);
}
