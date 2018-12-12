void setup() {
  size(640, 640);
}

void draw() {
  background(0);
  sierpinskiCarpet(width/2, height/2, width, height, int(frameCount%120/120.0*7));
}

void sierpinskiCarpet(float x, float y, float w, float h, int level) {
  if (level > 0) {
    sierpinskiCarpet(x-w/3, y-h/3, w/3, h/3, level-1);
    sierpinskiCarpet(x, y-h/3, w/3, h/3, level-1);
    sierpinskiCarpet(x+w/3, y-h/3, w/3, h/3, level-1);
    sierpinskiCarpet(x-w/3, y, w/3, h/3, level-1);
    sierpinskiCarpet(x+w/3, y, w/3, h/3, level-1);
    sierpinskiCarpet(x-w/3, y+h/3, w/3, h/3, level-1);
    sierpinskiCarpet(x, y+h/3, w/3, h/3, level-1);
    sierpinskiCarpet(x+w/3, y+h/3, w/3, h/3, level-1);
  } else {
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
