// From Daniel Shiffman

int cols;
int rows;
float[][] current;// = new float[cols][rows];
float[][] previous;// = new float[cols][rows];

import processing.sound.*;

float dampening = 0.99;

AudioIn in;
Amplitude amp;

float xoff;

void setup() {
  size(600, 400);
  cols = width;
  rows = height;
  current = new float[cols][rows];
  previous = new float[cols][rows];

  colorMode(HSB);

  in = new AudioIn(this, 0);
  in.start();

  amp = new Amplitude(this);
  amp.input(in);
}

void draw() {
  xoff+= 0.01;

  previous[constrain(int(map(amp.analyze(), 0, 0.1, 0, width - 1)), 0, width - 1)][round(map(noise(xoff), 0, 1, 0, height))] = 255;
  dampening = 0.91 + constrain(map(amp.analyze(), 0, 0.1, 0.05, 0.099), 0.05, 0.099);

  background(0);

  loadPixels();
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
      current[i][j] = (
        previous[i-1][j] + 
        previous[i+1][j] +
        previous[i][j-1] + 
        previous[i][j+1]) / 2 -
        current[i][j];
      current[i][j] = current[i][j] * dampening;
      int index = i + j * cols;
      pixels[index] = color(map(i * j, 0, width * height, 0, 255), 255, current[i][j] * 2);
    }
  }
  updatePixels();

  float[][] temp = previous;
  previous = current;
  current = temp;
}
