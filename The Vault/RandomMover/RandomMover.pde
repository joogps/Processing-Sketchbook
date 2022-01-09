Mover[] movers;
String[] modes = {"ellipse", "rectangle", "triangle"};

void setup() {
  fullScreen();
  colorMode(HSB);

  movers = new Mover[6];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(width), random(height), random(15, 35), modes[i % modes.length]);
  }
}

void draw() {
  background(0, 0, map(cos(TWO_PI * frameCount / 6000), 1, -1, 0, 100));

  for (int i = 0; i < movers.length; i++) {
    movers[i].move();
    movers[i].display();
  }
}
