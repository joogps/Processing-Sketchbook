import peasy.*;
PeasyCam cam;

PShape sponge;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 200);

  noStroke();
  sponge = createShape(BOX, 1);
  sponge.setTexture(loadImage("sponge.jpg"));
}

void draw() {
  background(0);
  lights();

  scale(100);
  mengerSponge(2);
}

void mengerSponge(int level) {
  if (level > 0) {
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        for (int z = -1; z <= 1; z++) {
          if (!(x == 0 && y == 0) && !(x == 0 && z == 0) && !(y == 0 && z == 0)) {
            pushMatrix();
            scale(1/3.0);
            translate(x, y, z);

            mengerSponge(level-1);
            popMatrix();
          }
        }
      }
    }
  } else
    shape(sponge);
}
