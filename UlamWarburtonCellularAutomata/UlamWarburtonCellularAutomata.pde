boolean[][] grid;
float w;
float h;

void setup() {
  size(640, 640);

  grid = new boolean[4][4];
  grid[ceil(grid.length/2.0)][ceil(grid[0].length/2.0)] = true;

  w = width/float(grid.length)-1/float(grid.length);
  h = height/float(grid[0].length)-1/float(grid[0].length);
}

void draw() {
  frameRate(10);

  boolean[][] newGrid = new boolean[grid.length][grid[0].length];
  boolean expand = false;

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      if (grid[x][y])
        fill(0);
      else
        fill(255);

      rect(x*w, y*h, w, h);

      boolean[] neighbors = {x < grid.length-1 && grid[x+1][y], y < grid[x].length-1 && grid[x][y+1], x > 0 && grid[x-1][y], y > 0 && grid[x][y-1]};
      boolean foundTrue = false;

      for (int i = 0; i < neighbors.length; i++) {
        if (neighbors[i]) {
          if (foundTrue) {
            foundTrue = false;
            break;
          } else
            foundTrue = true;
        }
      }

      newGrid[x][y] = grid[x][y] || foundTrue;
      expand = (newGrid[x][y] && (x == grid.length-1 || y == grid[x].length-1 || x == 0 || y == 0)) || expand;
    }
  }

  grid = newGrid;

  if (expand) {
    newGrid = new boolean[grid.length*2][grid[0].length*2];

    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        newGrid[x+grid.length/2][y+grid[x].length/2] = grid[x][y];
      }
    }

    grid = newGrid;
    w = width/float(grid.length)-1/float(grid.length);
    h = height/float(grid[0].length)-1/float(grid[0].length);
  }
}
