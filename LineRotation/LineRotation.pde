int columns = 8;
int lines =  80;

void setup() {
  size(640, 640);
}

void draw() {
  background(255);
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < lines; y++) {
      pushMatrix();
      translate(x*(width/(columns-1)), (y+0.5)*(height/float(lines-1)));
      rotate((frameCount+(y/float(lines)*60.0)+(x/float(columns)*60.0))/300.0*TWO_PI);

      stroke(0, x/float(columns)*255, y/float(lines)*255);
      strokeWeight(1.5);

      line(0, -height/float(lines-1)*2.5, 0, height/float(lines-1)*2.5);
      popMatrix();
    }
  }
}
