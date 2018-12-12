int[][] grid;

float w;
float h;

void setup() {
  size(641, 641);

  grid = new int[4][4];

  grid[round(random(grid.length-1))][round(random(grid[0].length-1))] = 2;

  w = width*0.75;
  h = height*0.75;
}

void draw() {
  translate((width-w)/2, (height-h)/2);

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      fill(255);
      rect(x*w/grid.length, y*h/grid[x].length, w/grid.length, h/grid[x].length);

      if (grid[x][y] != 0) {
        fill(0);

        textAlign(CENTER, CENTER);
        textSize(30);
        text(grid[x][y], x*w/grid.length+w/grid.length/2, y*h/grid[x].length+h/grid[x].length/2);
      }
    }
  }
}

void keyPressed() {
  switch(keyCode) {
  case DOWN:
    for (int x = 0; x < grid.length; x++) {
      for (int i = 0; i < grid[x].length; i++) {
        for (int y = grid[x].length-1; y >= 0; y--) {
          if (grid[x][y] != 0 && y < grid[x].length-1) {
            if (grid[x][y+1] == 0) {
              grid[x][y+1] = grid[x][y];
              grid[x][y] = 0;
            } else if (grid[x][y] == grid[x][y+1]) {
              grid[x][y+1] = grid[x][y]*2;
              grid[x][y] = 0;
            }
          }
        }
      }
    }
    break;
  case UP:
    for (int x = 0; x < grid.length; x++) {
      for (int i = 0; i < grid[x].length; i++) {
        for (int y = 0; y < grid[x].length; y++) {
          if (grid[x][y] != 0 && y > 0) {
            if (grid[x][y-1] == 0) {
              grid[x][y-1] = grid[x][y];
              grid[x][y] = 0;
            } else if (grid[x][y] == grid[x][y-1]) {
              grid[x][y-1] = grid[x][y]*2;
              grid[x][y] = 0;
            }
          }
        }
      }
    }
    break;
  case RIGHT:
    for (int i = 0; i < grid.length; i++) {
      for (int x = grid.length-1; x >= 0; x--) {
        for (int y = 0; y < grid[x].length; y++) {
          if (grid[x][y] != 0 && x < grid.length-1) {
            if (grid[x+1][y] == 0) {
              grid[x+1][y] = grid[x][y];
              grid[x][y] = 0;
            } else if (grid[x][y] == grid[x+1][y]) {
              grid[x+1][y] = grid[x][y]*2;
              grid[x][y] = 0;
            }
          }
        }
      }
    }
    break;
  case LEFT:
    for (int i = 0; i < grid.length; i++) {
      for (int x = 0; x < grid.length; x++) {
        for (int y = 0; y < grid[x].length; y++) {
          if (grid[x][y] != 0 && x > 0) {
            if (grid[x-1][y] == 0) {
              grid[x-1][y] = grid[x][y];
              grid[x][y] = 0;
            } else if (grid[x][y] == grid[x-1][y]) {
              grid[x-1][y] = grid[x][y]*2;
              grid[x][y] = 0;
            }
          }
        }
      }
    }
  }

  int x = round(random(grid.length-1));
  int y = round(random(grid[0].length-1));

  while (grid[x][y] != 0) {
    x = round(random(grid.length-1));
    y = round(random(grid[0].length-1));
  }

  grid[x][y] = 2;
}
