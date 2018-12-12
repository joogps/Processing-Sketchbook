Cell[][] grid;

Cell current;
ArrayList<Cell> stack;

boolean complete;

void setup() {
  size(362, 362);

  grid = new Cell[30][30];
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y] = new Cell(x, y, width/float(grid.length)-(1/float(grid.length)), height/float(grid[x].length)-(1/float(grid[x].length)));
    }
  }

  current = grid[round(random(grid.length-1))][round(random(grid[0].length-1))];
  current.visited = true;

  stack = new ArrayList<Cell>();
}

void draw() {
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y].display();
    }
  }

  current.update();

  fill(complete ? 255 : 0);
  rect(current.x*current.w, current.y*current.h, current.w, current.h);
}
