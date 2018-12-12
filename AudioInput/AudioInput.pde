import processing.sound.*;

AudioIn input;
Amplitude amp;

float temp;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(640, 360);

  input = new AudioIn(this, 0);
  input.start();

  amp = new Amplitude(this);
  amp.input(input);

  colorMode(HSB);
}

void draw() {
  background(255);

  points.add(new PVector(temp, map(amp.analyze(), 0, 0.5, height - height / 4, 0))); 
  temp++;
  temp = temp % width;

  for (int i = 0; i < points.size(); i++) {
    stroke(map(points.get(i).x * points.get(i).y, 0, width*height, 0, 255), 255, 255);
    if (dist(points.get(i).x, points.get(i).y, points.get(constrain(i+1, 0, points.size() - 1)).x, points.get(constrain(i+1, 0, points.size() - 1)).y) < width-1)
      line(points.get(i).x, points.get(i).y, points.get(constrain(i+1, 0, points.size() - 1)).x, points.get(constrain(i+1, 0, points.size() - 1)).y);
  }
}
