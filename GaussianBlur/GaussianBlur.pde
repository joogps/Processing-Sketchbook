PImage img;
int blurStrength;

void setup() {
  img = loadImage("sunflowers.jpg");
  size(640, 360);
}

void draw () {
  blurStrength = int(map(mouseY, 0, height, 0, 10));  
  
  image(img, 0, 0, width, height);
  blur(0, 0, mouseX, height, blurStrength);
}

void blur(int x_, int y_, int width_, int height_, int strength) {
  int _x = abs(x_);
  int _y = abs(y_);
  int _width = abs(width_);
  int _height = abs(height_);

  ArrayList<PVector> borders = new ArrayList<PVector>();

  for (int i = 0; i < strength; i++) {
    loadPixels();
    for (int x = _x + _width / 2; x < _x + _width; x++) {
      for (int y = _y + _height / 2; y < _y + _height; y++) {
        if (x > 0 && y > 0 && x < width-1 && y < height-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(lerpColor(lerpColor(pixels[(x+1)+y*width], pixels[(x-1)+y*width], 0.5), lerpColor(pixels[(x+1)+(y+1)*width], pixels[(x+1)+(y-1)*width], 0.5), 0.5), lerpColor(lerpColor(pixels[x+(y+1)*width], pixels[x+(y-1)*width], 0.5), lerpColor(pixels[(x-1)+(y+1)*width], pixels[(x-1)+(y-1)*width], 0.5), 0.5), 0.5), 0.5);
        } else {
          borders.add(new PVector(x, y));
        }
      }
    }

    for (int x = _x + _width / 2; x >= _x; x--) {
      for (int y = _y + _height / 2; y < _y + _height; y++) {
        if (x > 0 && y > 0 && x < width-1 && y < height-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(lerpColor(lerpColor(pixels[(x+1)+y*width], pixels[(x-1)+y*width], 0.5), lerpColor(pixels[(x+1)+(y+1)*width], pixels[(x+1)+(y-1)*width], 0.5), 0.5), lerpColor(lerpColor(pixels[x+(y+1)*width], pixels[x+(y-1)*width], 0.5), lerpColor(pixels[(x-1)+(y+1)*width], pixels[(x-1)+(y-1)*width], 0.5), 0.5), 0.5), 0.5);
        } else {
          borders.add(new PVector(x, y));
        }
      }
    }

    for (int x = _x + _width / 2; x < _x + _width; x++) {
      for (int y = _y + _height / 2; y >= _y; y--) {
        if (x > 0 && y > 0 && x < width-1 && y < height-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(lerpColor(lerpColor(pixels[(x+1)+y*width], pixels[(x-1)+y*width], 0.5), lerpColor(pixels[(x+1)+(y+1)*width], pixels[(x+1)+(y-1)*width], 0.5), 0.5), lerpColor(lerpColor(pixels[x+(y+1)*width], pixels[x+(y-1)*width], 0.5), lerpColor(pixels[(x-1)+(y+1)*width], pixels[(x-1)+(y-1)*width], 0.5), 0.5), 0.5), 0.5);
        } else {
          borders.add(new PVector(x, y));
        }
      }
    }

    for (int x = _x + _width / 2; x >= _x; x--) {
      for (int y = _y + _height / 2; y >= _y; y--) {
        if (x > 0 && y > 0 && x < width-1 && y < height-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(lerpColor(lerpColor(pixels[(x+1)+y*width], pixels[(x-1)+y*width], 0.5), lerpColor(pixels[(x+1)+(y+1)*width], pixels[(x+1)+(y-1)*width], 0.5), 0.5), lerpColor(lerpColor(pixels[x+(y+1)*width], pixels[x+(y-1)*width], 0.5), lerpColor(pixels[(x-1)+(y+1)*width], pixels[(x-1)+(y-1)*width], 0.5), 0.5), 0.5), 0.5);
        } else {
          borders.add(new PVector(x, y));
        }
      }
    }

    for (int j = 0; j < borders.size(); j++) {
      int x = int(borders.get(j).x);
      int y = int(borders.get(j).y);

      if (x <= 0 && y <= 0) {
        pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x+1)+(y+1)*width], lerpColor(pixels[x+(y+1)*width], pixels[(x+1)+y*width], 0.5), 0.5), 0.5);
      } else if (x <= 0 && y >= height-1) {
        pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x+1)+(y-1)*width], lerpColor(pixels[x+(y-1)*width], pixels[(x+1)+y*width], 0.5), 0.5), 0.5);
      } else if (x >= width-1 && y <= 0) {
        pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x-1)+(y+1)*width], lerpColor(pixels[x+(y+1)*width], pixels[(x-1)+y*width], 0.5), 0.5), 0.5);
      } else if (x >= width-1 && y >= height-1) {
        pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x-1)+(y-1)*width], lerpColor(pixels[x+(y-1)*width], pixels[(x-1)+y*width], 0.5), 0.5), 0.5);
      } else {
        if (x <= 0) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x+1)+y*width], lerpColor(pixels[x+(y-1)*width], pixels[x+(y+1)*width], 0.5), 0.5), 0.5);
        }

        if (y <= 0) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(y+1)+y*width], lerpColor(pixels[(x-1)+y*width], pixels[(x+1)+y*width], 0.5), 0.5), 0.5);
        }

        if (x >= width-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[(x-1)+y*width], lerpColor(pixels[x+(y+1)*width], pixels[x+(y-1)*width], 0.5), 0.5), 0.5);
        }

        if (y >= height-1) {
          pixels[x+y*width] = lerpColor(pixels[x+y*width], lerpColor(pixels[x+(y-1)*width], lerpColor(pixels[(x+1)+y*width], pixels[(x-1)+y*width], 0.5), 0.5), 0.5);
        }
      }
    }

    updatePixels();
  }
}
