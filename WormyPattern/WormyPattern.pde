float[][] orientation;
float[][] goal;

void setup() {
  size(400, 400);

  orientation = new float[30][30];
  for (int x = 0; x < orientation.length; x++)
    for (int y = 0; y < orientation[x].length; y++)
      orientation[x][y] = HALF_PI*round(random(3));

  goal = new float[orientation.length][orientation[0].length];
  for (int x = 0; x < goal.length; x++)
    for (int y = 0; y < goal[x].length; y++)
      goal[x][y] = orientation[x][y];

  colorMode(HSB);
}

void draw() {
  background(255);

  for (int x = 0; x < orientation.length; x++) {
    for (int y = 0; y < orientation[x].length; y++) {
      pushMatrix();
      translate((x+0.5)*width/float(orientation.length), (y+0.5)*height/float(orientation[x].length));
      rotate(orientation[x][y]);

      noFill();
      stroke(130+(x*y)/float(orientation.length*orientation[x].length)*25, 255, 255);
      strokeWeight(3);

      arc(0, 0, width/float(orientation.length), height/float(orientation[x].length), 0, HALF_PI+abs(sin(frameCount/1200.0*TWO_PI))*HALF_PI);
      popMatrix();

      orientation[x][y] = lerp(orientation[x][y], goal[x][y], 0.1);
      if (abs(goal[x][y]-orientation[x][y]) < 0.05)
        orientation[x][y] = goal[x][y];
    }
  }

  for (int i = 0; i < 5; i++)
    goal[round(random(goal.length-1))][round(random(goal[0].length-1))] = HALF_PI*round(random(3));
}
