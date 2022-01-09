void setup() {
  size(640, 640);

  float w = width*0.8;
  float h = height*0.8;

  String[][] grid = new String[3][3];
  String player = random(1) < 0.5 ? "x" : "o";

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      int randomX = round(random(grid.length-1));
      int randomY = round(random(grid[x].length-1));

      while (grid[randomX][randomY] != null) {
        randomX = round(random(grid.length-1));
        randomY = round(random(grid[x].length-1));
      }

      grid[randomX][randomY] = player;

      if (player == "x")
        player = "o";
      else if (player == "o")
        player = "x";
    }
  }

  background(255);

  pushMatrix();
  translate((width-w)/2, (height-h)/2);

  fill(175);
  noStroke();
  rect(0, 0, w, h);

  stroke(255);
  strokeWeight(3);
  strokeCap(SQUARE);

  for (int x = 1; x < grid.length; x++)
    line(x*(w/float(grid.length)), 0, x*(w/float(grid.length)), h);

  for (int y = 1; y < grid[0].length; y++)
    line(0, y*(h/float(grid[0].length)), w, y*(h/float(grid[0].length)));

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      if (grid[x][y] == "x")
        drawX(x*(w/float(grid.length)), y*(h/float(grid[x].length)), w/float(grid.length), h/float(grid[x].length));

      if (grid[x][y] == "o")
        drawO(x*(w/float(grid.length)), y*(h/float(grid[x].length)), w/float(grid.length), h/float(grid[x].length));
    }
  }
  popMatrix();

  save("icon2.png");
  exit();
}

void drawX(float x, float y, float w, float h) {
  stroke(255, 0, 0);
  strokeWeight((w+h)/30);
  strokeCap(ROUND);

  line(x+w/4, y+h/4, x+w*3/4, y+h*3/4);
  line(x+w*3/4, y+h/4, x+w/4, y+h*3/4);
}

void drawO(float x, float y, float w, float h) {
  noFill();

  stroke(0, 0, 255);
  strokeWeight((w+h)/25);
  strokeCap(ROUND);

  ellipse(x+w/2, y+h/2, w/2, h/2);
}
