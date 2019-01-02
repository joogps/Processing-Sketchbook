void setup() {
  size(512, 512);

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x+y*width] = lerpColor(color(30), color(80), y/float(height));
    }
  }
  updatePixels();

  fill(255);

  textFont(createFont("CalibriBold.ttf", 300));
  textAlign(CENTER, CENTER);

  text("JG", width/2, height/2-textDescent());

  save("favicon.png");
  exit();
}
