import peasy.*;
PeasyCam cam;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 200);
}

void draw() {
  background(0);
  mengerSponge(100, 2);
}

void mengerSponge(float size, int level) {
  if (level > 0) {
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        for (int z = -1; z <= 1; z++) {
          pushMatrix();
          translate(x*size/3.0, y*size/3.0, z*size/3.0);
          if (!(x == 0 && y == 0) && !(x == 0 && z == 0) && !(y == 0 && z == 0))
            mengerSponge(size/3.0, level-1);
          popMatrix();
        }
      }
    }
  } else
    box(size);
}
