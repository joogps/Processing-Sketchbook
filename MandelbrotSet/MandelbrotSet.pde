void setup() {
  size(400, 400);
  colorMode(HSB);
}

void draw() {
  background(255);

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float a = map(x, 0, width, -2.0, 2.0);
      float b = map(y, 0, height, -2.0, 2.0);

      float complexA = a;
      float complexB = b;

      int i = 0;

      while (i < 100) {
        float aSquared = sq(a)-sq(b);
        float bSquared = 2*a*b;

        a = aSquared+complexA;
        b = bSquared+complexB;

        if (sq(a)+sq(b) > 4)
          break;

        i++;
      }

      pixels[x+y*width] = color(sqrt(i/100.0)*255, 255, i == 100 || i == 0 ? 0 : 255);
    }
  }
  updatePixels();
}
