int columns;
int rows;

float hue;


void setup() {
  size(640, 1136);
  colorMode(HSB);
}

void draw() {
  background(255);

  columns = round(random(1, 10));
  rows = round(random(1, 10));

  hue = random(255);

  float start = 1/9.0;
  float end = 8/9.0;

  float w = abs(width*(end-start))/float(columns);
  float h = abs(height*(end-start))/float(rows);

  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      color c = color(random(hue-15, hue+15), random(255), random(255));

      fill(c);
      stroke(c);

      triangle(width*start+x*w, height*start+y*h, width*start+(x+1)*w, height*start+y*h, width*start+x*w, height*start+(y+1)*h);

      c = color(random(hue-15, hue+15), random(255), random(255));

      fill(c);
      stroke(c);

      triangle(width*start+x*w, height*start+(y+1)*h, width*start+(x+1)*w, height*start+y*h, width*start+(x+1)*w, height*start+(y+1)*h);
    }
  }

  saveFrame("wallpapers/####.png");

  if (frameCount >= 30)
    exit();
}
