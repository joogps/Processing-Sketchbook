CircleWave[] circleWaves;

void setup() {
  size(640, 360);
  colorMode(HSB);

  circleWaves = new CircleWave[10];
  for (int i = 0; i < circleWaves.length; i++)
    circleWaves[i] = new CircleWave();
}

void draw() {
  background(0);
  noStroke();

  for (int i = 0; i < circleWaves.length; i++)
    circleWaves[i].display();
}
