int detail = 3;
float animation = 0;

String mode = "waves";
boolean showStroke = false;

float theta = 0;
float amplitude = 5;
float period = 200;
float dZ;
float[] zValues;

void setup() {
  size(640, 360, P3D);
}

void draw() {
  theta = cos(TWO_PI * frameCount / 600) * 35;
  dZ = (TWO_PI / period) * detail;
  zValues = new float[width/detail];

  float z = theta;
  for (int i = 0; i < zValues.length; i++) {
    zValues[i] = sin(z)*amplitude;
    z+=dZ;
  }

  background(0);
  directionalLight(255, 255, 255, width/2-mouseX, height/2-mouseY, -600);
  
  translate(width/2, height/2, -600);

  fill(255);
  if (showStroke) {
    stroke(0);
  } else {
    noStroke();
  }

  rotateY(animation % TWO_PI);

  for (int y = -height/2; y <= height/2; y+=detail) {
    beginShape(TRIANGLE_STRIP);
    for (int x = -width/2; x <= width/2; x+=detail) {

      vertex(x, y, mode == "waves" ? zWaves(x, y, detail, false) : mode == "bend" ? zBend(x, y, detail, false) : mode == "stretch" ? zStretch(x, y, detail, false) : zCone(x, y, detail, false));
      vertex(x, y+detail, mode == "waves" ? zWaves(x, y, detail, true) : mode == "bend" ? zBend(x, y, detail, true) : mode == "stretch" ? zStretch(x, y, detail, true) : zCone(x, y, detail, true));
    } 
    endShape();
  }

  animation+= 0.01;
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    mode = mode == "waves" ? "bend" : mode == "bend" ? "stretch" : mode == "stretch" ? "cone" : "waves";
  } else {
    showStroke = !showStroke;
  }
}

float zWaves(int x, int y, int detail, boolean yIncrease) {
  return zValues[constrain(floor((x + width/2)/detail), 0, zValues.length - 1)] * 5;
}

float zBend(int x, int y, int detail, boolean yIncrease) {
  return sin(map(x + width/2, 0, width, 0, PI)) * cos(TWO_PI * frameCount / 90) * 250;
}

float zStretch(int x, int y, int detail, boolean yIncrease) {
  return sin(map((x + width/2) + ((y + (yIncrease ? detail : 0)) + height/2), 0, width + height, 0, PI)) * cos(TWO_PI * frameCount / 90) * 250;
}

float zCone(int x, int y, int detail, boolean yIncrease) {
  return sin(map(dist(x, y + (yIncrease ? detail : 0), 0, 0), 0, dist(width/2, height/2, 0, 0), 0, HALF_PI)) * cos(TWO_PI * frameCount / 90) * 350;
}
