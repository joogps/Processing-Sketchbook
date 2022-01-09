float radius = 5;
int spins = 24;

float animation = 0;

void setup() {
  size(640, 360);
  colorMode(HSB);
}

void draw() {
  background(255);
  translate(width/2, height/2);

  for (float i = 0; i < TWO_PI*spins; i+= 0.01) {
    float r = radius + map(i, 0, TWO_PI*spins, 0, spins * 15);

    float x = r * cos(i);
    float y = r * sin(i);

    strokeWeight(5);
    stroke(map(i % TWO_PI, 0, TWO_PI, animation, 255 + animation) % 255, 255, 255);
    point(x, y);
  }
  
  animation = map(cos(TWO_PI * frameCount / 180), 1, -1, 0, 255);
}
