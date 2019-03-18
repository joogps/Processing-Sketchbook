https://stackoverflow.com/questions/225548/resources-for-image-distortion-algorithms

float a;
float b;

void setup() {
  size(640, 640);
  colorMode(HSB);
}

void draw() {
  a = sin((frameCount-1)/160.0*PI)*TWO_PI*15;
  b = 50;

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x+y*width] = color(x/float(width)*255, 255, 255);
    }
  }
  updatePixels();

  loadPixels();
  color[] newPixels = pixels;
  for (int X = 0; X < width; X++) {
    int x = X-width/2;
    for (int Y = 0; Y < height; Y++) {
      int y = Y-height/2;

      float angle = a*exp(-(sq(x)+sq(y))/sq(b));
      float u = cos(angle)*x+sin(angle)*y+width/2;
      float v = -sin(angle)*x+cos(angle)*y+height/2;

      color firstColor = lerpColor(pixels[constrain(floor(u)+floor(v)*width, 0, pixels.length-1)], pixels[constrain(ceil(u)+floor(v)*width, 0, pixels.length-1)], u%1);
      color secondColor = lerpColor(pixels[constrain(floor(u)+ceil(v)*width, 0, pixels.length-1)], pixels[constrain(ceil(u)+ceil(v)*width, 0, pixels.length-1)], u%1);
      color finalColor = lerpColor(firstColor, secondColor, v%1);

      newPixels[X+Y*width] = finalColor;
    }
  }

  pixels = newPixels;
  updatePixels();
}
