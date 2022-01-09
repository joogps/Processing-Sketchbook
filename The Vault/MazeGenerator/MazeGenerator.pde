Cell[][] grid;

Cell current;
ArrayList<Cell> stack;

boolean complete;

PVector player;

void setup() {
  size(362, 362);

  grid = new Cell[30][30];
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y] = new Cell(x, y, width/float(grid.length)-(1/float(grid.length)), height/float(grid[x].length)-(1/float(grid[x].length)));
    }
  }

  player = new PVector(round(random(grid.length-1)), round(random(grid[0].length-1)));

  current = grid[int(player.x)][int(player.y)];
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
  rect((current.x+0.25)*current.w, (current.y+0.25)*current.h, current.w*0.5, current.h*0.5);

  if (complete)
    current = grid[int(player.x)][int(player.y)];
}

void keyPressed() {
  if (complete) {
    if (keyCode == RIGHT && player.x < grid.length-1 && !current.walls[0])
      player.x++;

    if (keyCode == DOWN && player.y < grid[int(player.x)].length-1 && !current.walls[1])
      player.y++;

    if (keyCode == LEFT && player.x > 0 && !current.walls[2])
      player.x--;

    if (keyCode == UP && player.y > 0 && !current.walls[3])
      player.y--;

    current = grid[int(player.x)][int(player.y)];
  }
}
