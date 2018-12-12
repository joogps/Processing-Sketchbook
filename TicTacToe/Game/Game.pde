Tile[][] grid;
HUD hud;

PImage icon;
PFont timerFont;

void setup() {
  size(400, 501);
  setGame();

  surface.setTitle("TicTacToe");

  icon = loadImage("..\\Assets\\Icon2\\icon2.png");
  surface.setIcon(icon);
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

  if (timerFont == null)
    timerFont = createFont("..\\Assets\\ProductSans.ttf", 1);

  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y] = new Tile(x, y, width/float(grid.length), (height-hud.spacing)/float(grid[0].length));
    }
  }
}
