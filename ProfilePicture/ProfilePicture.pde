PImage original;

float[] hues = {286, 213, 126};
float alpha = 100;

PImage[] edited;

void settings() {
  original = loadImage("original.jpg");
  size(original.width, original.height);
}

void setup() {
  colorMode(HSB);

  edited = new PImage[hues.length];
  for (int i = 0; i < edited.length; i++) {
    edited[i] = new PImage(original.width, original.height);

    loadPixels();
    for (int x = 0; x < original.width; x++) {
      for (int y = 0; y < original.height; y++) {
        edited[i].pixels[x+y*edited[i].width] = color(hues[i], 255, brightness(original.pixels[x+y*original.width]), alpha);
      }
    }
    updatePixels();
  }

  image(original, 0, 0);

  for (int i = 0; i < edited.length; i++)
    image(edited[i], random(-width/75.0, width/75.0), random(-height/75.0, height/75.0));

  save("edited.jpg");
  exit();
}
