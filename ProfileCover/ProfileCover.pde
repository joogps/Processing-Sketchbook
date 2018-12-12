float[] hues = {286, 213, 126};

void setup() {
  size(1500, 500);
  colorMode(HSB);

  background(0);

  textFont(createFont("Product Sans Regular.ttf", 100));
  textAlign(CENTER, CENTER);

  fill(0, 0, 180);
  text("@joogps", width/2, height/2-textDescent());

  for (int i = 0; i < hues.length; i++) {
    fill(hues[i], 255, 180, 100);
    text("@joogps", width/2+random(-width/130.0, width/130.0), height/2-textDescent()+random(-height/130.0, height/130.0));
  }

  save("cover.png");
  exit();
}
