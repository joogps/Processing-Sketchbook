float startX = 0;
float startY = 0;

void setup() {
  size(640, 640);
}

void draw() {
  background(255);

  float xoff = startX;
  for (int x = 0; x < width; x++) {
    float yoff = startY;
    for (int y = 0; y < height; y++) {
      if (x%20 == 0 && y%20 == 0) {
        float size = map(noise(xoff, yoff), 0, 1, 1, 20);
        fill(0);
        ellipse(x+size/2, y+size/2, size, size);
      }
      yoff+= 0.01;
    }
    xoff+= 0.01;
  }

  startX+= map(cos(TWO_PI*frameCount/450.0), -1, 1, -0.1, 0.1);
  startY+= map(cos(TWO_PI*frameCount/300.0), -1, 1, 0.1, -0.1);
}
