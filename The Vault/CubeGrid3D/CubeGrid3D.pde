float xRotate;
float yRotate;

int size = 175;
int density = 1;

int[][][] startEnd = {{{0, size/2}, {0, size/2}, {0, size/2}}, {{0, -size/2}, {0, size/2}, {0, size/2}}, {{0, -size/2}, {0, -size/2}, {0, size/2}}, {{0, -size/2}, {0, size/2}, {0, -size/2}}, {{0, size/2}, {0, size/2}, {0, -size/2}}, {{0, size/2}, {0, -size/2}, {0, -size/2}}, {{0, size/2}, {0, -size/2}, {0, size/2}}, {{0, -size/2}, {0, -size/2}, {0, -size/2}}};

void setup() {
  size(640, 640, P3D);
}

void draw() {
  background(map(cos(TWO_PI * frameCount / 940), -1, 1, 100, 255));
  lights();
  translate(width/2, height/2, 1);

  xRotate = map(cos(TWO_PI * frameCount / 1080), -1, 1, -PI, TWO_PI + QUARTER_PI);
  yRotate = map(cos(TWO_PI * frameCount / 820), -1, 1, -HALF_PI, TWO_PI);
  density = round(map(cos(TWO_PI * frameCount / 1440), -1, 1, 2, size/10));

  rotateX(xRotate);
  rotateY(yRotate);

  for (int i = 0; i < startEnd.length; i++) {
    for (int x = startEnd[i][0][0]; (startEnd[i][0][1] > startEnd[i][0][0] ? x < startEnd[i][0][1] : x > startEnd[i][0][1]); x+= (round(size/density) * (startEnd[i][0][1] > startEnd[i][0][0] ? +1 : -1))) {
      for (int y = startEnd[i][1][0]; (startEnd[i][1][1] > startEnd[i][1][0] ? y < startEnd[i][1][1] : y > startEnd[i][1][1]); y+= (round(size/density) * (startEnd[i][1][1] > startEnd[i][1][0] ? +1 : -1))) {
        for (int z = startEnd[i][2][0]; (startEnd[i][2][1] > startEnd[i][2][0] ? z < startEnd[i][2][1] : z > startEnd[i][2][1]); z+= (round(size/density) * (startEnd[i][2][1] > startEnd[i][2][0] ? +1 : -1))) {
          fill(map(x, -size/2, size/2, 255, 25), map(y, -size/2, size/2, 255, 25), map(z, -size/2, size/2, 255, 25), map(cos(TWO_PI * frameCount / 660), -1, 1, 125, 255));
          noStroke();

          pushMatrix();
          translate(x, y, z);
          rotateX(xRotate);
          rotateY(yRotate);
          box(round(size/map(density, 2, size/10, 1, size/10)));
          popMatrix();
        }
      }
    }
  }
};
