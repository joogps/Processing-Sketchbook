void setup() {
  size(640, 360);
}

void draw() {
  background(120);
  rectGradient(50, 50, mouseX - 50, mouseY - 50, 50, color(mouseX * 0.1, mouseY * 0.7, mouseY * 2), color(mouseX * 1.2, mouseX * 2, mouseY * 0.5));
}

void rectGradient(float _x, float _y, float _width, float _height, float r, color color1, color color2) {
  loadPixels();  
  for (float x = _x; x < _x + _width; x++) {
    for (float y = _y; y < _y + _height; y++) {
      if ((x < _x + _width-r || y > _y+r) && (x < _x + _width-r || y < _y + _height-r) && (x > _x+r || y > _y+r) && (x > _x+r || y < _y + _height-r))
        pixels[round(x + y*width)] = color(lerpColor(color1, color2, map(y, _y, _y + _height, 0, 1)));
    }
  }

  for (int i = 0; i < 4; i++) {
    float startX = i < 2 ? _x+r : _x + _width-r;
    float startY = i < 1 || i > 2 ? _y+r : _y + _height-r;
    for (float a = 0; a < TWO_PI; a+= 0.001) {
      for (int _r = 0; _r < r; _r++) {
        int x = round(startX + cos(a) * _r);
        int y = round(startY + sin(a) * _r);
        if (x+y*width < width*height && x+y*width > 0)
          pixels[x+y*width] = color(lerpColor(color1, color2, map(y, _y, _y + _height, 0, 1)));
      }
    }
  }
  updatePixels();
}
