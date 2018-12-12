float[] distribution = new float[360];
float[] noiseX = new float[360];

void setup() {
  size(640, 640);
  for (int i = 0; i < distribution.length; i++) {
    distribution[i] = int(randomGaussian() * (width * 1.5 / 10));
    noiseX[i] = random(distribution[i]);
  }
}

void draw() {
  background(204);
  translate(width/2, width/2);

  for (int i = 0; i < distribution.length; i++) {
    noiseX[i]+= 0.01;
    rotate(TWO_PI/distribution.length);
    stroke(0);
    float dist = abs(distribution[i]);
    line(0, 0, dist + map(noise(noiseX[i]), 0, 1, -2, 2) * dist, 0);
  }
}
