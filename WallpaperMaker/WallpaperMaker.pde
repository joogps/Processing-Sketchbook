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

  float spacing = 1/9.0;

  float w = abs(width*(1-spacing*2))/float(columns);
  float h = abs(height*(1-spacing*2))/float(rows);

  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      color c = color(random(hue-15, hue+15), random(255), random(255));

      fill(c);
      stroke(c);

      triangle(width*spacing+x*w, height*spacing+y*h, width*spacing+(x+1)*w, height*spacing+y*h, width*spacing+x*w, height*spacing+(y+1)*h);

      c = color(random(hue-15, hue+15), random(255), random(255));

      fill(c);
      stroke(c);

      triangle(width*spacing+x*w, height*spacing+(y+1)*h, width*spacing+(x+1)*w, height*spacing+y*h, width*spacing+(x+1)*w, height*spacing+(y+1)*h);
    }
  }

  saveFrame("wallpapers/####.png");

  if (frameCount >= 30)
    exit();
}
