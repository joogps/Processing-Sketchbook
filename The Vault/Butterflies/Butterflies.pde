PImage[] sprites;

ArrayList<Butterfly> butterflies;

void setup() {
  size(900, 600);
  colorMode(HSB);

  sprites = new PImage[4];
  for (int i = 0; i < sprites.length; i++)
    sprites[i] = loadImage(i+1+".png");

  butterflies = new ArrayList<Butterfly>();
}

void draw() {
  background(0);
  for (int i = 0; i < butterflies.size(); i++) {
    Butterfly b = butterflies.get(i);
    if (b != null) {
      b.display();
      b.update();
      b.updatePos();
      b.updateAngle();
      b.updateFlap();
      b.kill();
    }
  }

  if (random(1) < 0.01 && butterflies.size() < 10)
    butterflies.add(new Butterfly(sprites[round(random(sprites.length-1))]));
}
