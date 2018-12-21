boolean[][] slashes;

void setup() {
  size(400, 400);
  randomizeSlashes(1, 1);
}

void draw() {
  background(0);
  stroke(255);

  for (int x = 0; x < slashes.length; x++) {
    for (int y = 0; y < slashes[x].length; y++) {
      pushMatrix();
      translate(x*width/float(slashes.length), y*height/float(slashes[x].length));

      if (slashes[x][y])
        line(0, height/float(slashes[x].length), width/float(slashes.length), 0);
      else
        line(0, 0, width/float(slashes.length), height/float(slashes[x].length));
      popMatrix();
    }
  }

  if (frameCount%30 == 0)
    randomizeSlashes(1+frameCount/30, 1+frameCount/30);
}

void randomizeSlashes(int columns, int rows) {
  slashes = new boolean[columns][rows];
  for (int x = 0; x < slashes.length; x++)
    for (int y = 0; y < slashes[x].length; y++)
      slashes[x][y] = random(1) < 0.5;
}
