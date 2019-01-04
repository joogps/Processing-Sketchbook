boolean[][] slashes;

void setup() {
  size(400, 400);
  slashes = new boolean[8][8];
  for (int x = 0; x < slashes.length; x++)
    for (int y = 0; y < slashes[x].length; y++)
      slashes[x][y] = random(1) < 0.5;
  
  strokeCap(ROUND);
}

void draw() {
  background(255);

  for (int x = 0; x < slashes.length; x++) {
    for (int y = 0; y < slashes[x].length; y++) {
      pushMatrix();
      translate(x*width/float(slashes.length), y*height/float(slashes[x].length));
      
      stroke(slashes[x][y] ? 255 : 0, abs(sin(frameCount/600.0*TWO_PI))*255, slashes[x][y] ? 0 : 255, 50);
      strokeWeight(slashes[x][y] ? abs(cos(frameCount/300.0*TWO_PI))*30 : abs(sin(frameCount/240.0*TWO_PI))*30);

      if (slashes[x][y])
        line(0, height/float(slashes[x].length), width/float(slashes.length), 0);
      else
        line(0, 0, width/float(slashes.length), height/float(slashes[x].length));
      popMatrix();
    }
  }
}
