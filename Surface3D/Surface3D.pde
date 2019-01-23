import peasy.*;

int size = 3;
float animation = 0;

String mode = "waves";

float theta = 0;
float amplitude = 5;
float period = 200;
float dZ;
float[] zValues;

PeasyCam cam;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 600);
}

void draw() {
  theta = cos(TWO_PI * frameCount/600.0) * 35;
  dZ = (TWO_PI/period) * size;
  zValues = new float[width/size];

  float z = theta;
  for (int i = 0; i < zValues.length; i++) {
    zValues[i] = sin(z)*amplitude;
    z+=dZ;
  }

  background(0);
  lights();

  fill(255);
  noStroke();

  rotateY(animation % TWO_PI);

  for (float y = -height/2; y <= height/2; y+=size) {
    beginShape(TRIANGLE_STRIP);
    for (float x = -width/2; x <= width/2; x+=size) {
      vertex(x, y, mode == "waves" ? zWaves(x, y, size, false) : mode == "bend" ? zBend(x, y, size, false) : mode == "stretch" ? zStretch(x, y, size, false) : zCone(x, y, size, false));
      vertex(x, y+size, mode == "waves" ? zWaves(x, y, size, true) : mode == "bend" ? zBend(x, y, size, true) : mode == "stretch" ? zStretch(x, y, size, true) : zCone(x, y, size, true));
    }
    endShape();
  }

  animation+= 0.01;
}

void keyPressed() {
  if (key == ' ')
    mode = mode == "waves" ? "bend" : mode == "bend" ? "stretch" : mode == "stretch" ? "cone" : "waves";
}

float zWaves(float x, float y, int detail, boolean yIncrease) {
  return zValues[constrain(floor((x + width/2)/detail), 0, zValues.length - 1)] * 5;
}

float zBend(float x, float y, int detail, boolean yIncrease) {
  return sin(map(x + width/2, 0, width, 0, PI)) * cos(TWO_PI * frameCount / 90) * 250;
}

float zStretch(float x, float y, int detail, boolean yIncrease) {
  return sin(map((x + width/2) + ((y + (yIncrease ? detail : 0)) + height/2), 0, width + height, 0, PI)) * cos(TWO_PI * frameCount / 90) * 250;
}

float zCone(float x, float y, int detail, boolean yIncrease) {
  return sin(map(dist(x, y + (yIncrease ? detail : 0), 0, 0), 0, dist(width/2, height/2, 0, 0), 0, HALF_PI)) * cos(TWO_PI * frameCount / 90) * 350;
}
