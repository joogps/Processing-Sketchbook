Tile[][] grid;
HUD hud;

PImage icon;
PFont timerFont;

float spacing;

void setup() {
  size(640, 760);

  icon = loadImage("../Assets/Icon1/icon1.png");
  timerFont = createFont("../Assets/ProductSans.ttf", 1);

  spacing = height-width;

  surface.setTitle("Tic-Tac-Toe");
  surface.setIcon(icon);

  setGame();
}

void draw() {
  checkHorizontal();
  checkVertical();

  checkDiagonalLeftToRight();
  checkDiagonalRightToLeft();

  checkTie();

  hud.display();
  hud.update();

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y].display();
      grid[x][y].update();
    }
  }

  hud.displayGameOverLine();
}

void mouseReleased() {
  hud.updateTiles();
}

void setGame() {
  grid = new Tile[3][3];
  hud = new HUD();

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y] = new Tile(x, y, (width-1)/float(grid.length), (width-1)/float(grid[0].length));
    }
  }
}
