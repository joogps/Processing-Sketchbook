WavyCircle[] wavyCircles;

void setup() {
  size(640, 360);
  colorMode(HSB);

  wavyCircles = new WavyCircle[5];
  for (int i = 0; i < wavyCircles.length; i++)
    wavyCircles[i] = new WavyCircle();
}

void draw() {
  background(0);
  noStroke();

  for (int i = 0; i < wavyCircles.length; i++)
    wavyCircles[i].display();
}
