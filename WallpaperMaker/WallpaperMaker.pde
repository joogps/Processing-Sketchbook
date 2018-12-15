int columns= 5;
int rows = 5;

float hue;

void setup() {
  size(640, 1136);
  colorMode(HSB);
}

void draw() {
  background(255);
  noStroke();

  hue = random(255);

  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      fill(random(hue-15, hue+15), random(255), random(255));
      triangle(width/8.0+x*(width*3/4.0/float(columns)), height/8.0+y*(height*3/4.0/float(columns)), width/8.0+(x+1)*(width*3/4.0/float(columns)), height/8.0+y*(height*3/4.0/float(columns)), width/8.0+x*(width*3/4.0/float(columns)), height/8.0+(y+1)*(height*3/4.0/float(columns)));

      fill(random(hue-15, hue+15), random(255), random(255));
      triangle(width/8.0+x*(width*3/4.0/float(columns)), height/8.0+(y+1)*(height*3/4.0/float(columns)), width/8.0+(x+1)*(width*3/4.0/float(columns)), height/8.0+y*(height*3/4.0/float(columns)), width/8.0+(x+1)*(width*3/4.0/float(columns)), height/8.0+(y+1)*(height*3/4.0/float(columns)));
    }
  }

  saveFrame("wallpapers/####.png");

  if (frameCount >= 15)
    exit();
}
