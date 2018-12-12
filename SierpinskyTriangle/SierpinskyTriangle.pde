void setup() {
  size(640, 640);
}

void draw() {
  translate(width/2, height/2);

  background(0);
  sierpinskiTriangle(0, 0, width, height, int(frameCount%120/120.0*7));
}

void sierpinskiTriangle(float x, float y, float w, float h, float level) {
  if (level > 0) {
    sierpinskiTriangle(x, y-h/4, w/2, h/2, level-1);
    sierpinskiTriangle(x-w/4, y+h/4, w/2, h/2, level-1);
    sierpinskiTriangle(x+w/4, y+h/4, w/2, h/2, level-1);
  } else {
    triangle(x, y-h/2, x-w/2, y+h/2, x+w/2, y+h/2);
  }
}
