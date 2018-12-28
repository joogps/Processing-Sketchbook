Tile[][] tiles;
UI ui;

PImage bomb;
PImage flag;

PFont digital;
PFont pixelated; 

int cols;
int rows;

int numBombs;

float w;
float h;

boolean win;
boolean gameOver;

int spacing;

void setup() {
  size(640, 760);

  bomb = loadImage("../Assets/bomb.png");
  flag = loadImage("../Assets/flag.png");

  digital = createFont("../Assets/digital.otf", 1);
  pixelated = createFont("../Assets/pixelated.otf", 1);

  cols = 10;
  rows = 10;

  spacing = height-width;

  surface.setTitle("Minesweeper");
  surface.setIcon(bomb);

  ui = new UI();
  setGame();
}

void draw() {
  background(160);

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tiles[x][y].show();
    }
  }

  ui.updateTime();
  ui.updateSelectors("press");
  ui.show();

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tiles[x][y].checkPress();
    }
  }
}

void mouseReleased() {
  if (!gameOver && !win) {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        tiles[x][y].checkRelease(x, y);
      }
    }
    checkWin();
  } else {
    setGame();
  }

  ui.updateSelectors("release");
}

void winGame() {
  win = true;
  ui.countTime = false;

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y].isBomb)
        tiles[x][y].showing = true;
    }
  }
}

void gameOverGame() {
  gameOver = true;
  ui.countTime = false;

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y].isBomb)
        tiles[x][y].showing = true;
    }
  }
}

void reveal(int _x, int _y) {
  int revealWidth =  floor(cols/3);
  int revealHeight = floor(rows/3);

  for (int x = _x + (_x <= 1 || _x >= cols - 2 ? ((_x <= 1 ? (_x == 0 ? 0 : -1) : (_x == cols - 1 ? -(revealWidth-1) : -(revealWidth-2)))) : -floor(revealWidth/2)); x <= _x + (_x <= 1 || _x >= cols - 2 ? ((_x <= 1 ? (_x == 0 ? (revealWidth-1) : (revealWidth-2)) : (_x == cols ? 0 : 1))) : floor(revealWidth/2)); x++) {
    for (int y = _y + (_y <= 1 || _y >= rows - 2 ? ((_y <= 1 ? (_y == 0 ? 0 : -1) : (_y == rows - 1 ? -(revealHeight-1) : -(revealHeight-2)))) : -floor(revealHeight/2)); y <= _y + (_y <= 1 || _y >= rows - 2 ? ((_y <= 1 ? (_y == 0 ? (revealHeight-1) : revealHeight-2) : (_y == rows ? 0 : 1))) : floor(revealHeight/2)); y++) {
      if (x >= 0 && y >= 0 && x < cols && y < rows && !tiles[x][y].isBomb &&!tiles[x][y].showing) {
        tiles[x][y].preview = true;
        tiles[x][y].showing = true;
        if (tiles[x][y].isFlagged) {
          tiles[x][y].isFlagged = false;
          ui.updateFlag(tiles[x][y].isFlagged);
        }
      }
    }
  }
}

void setGame() {
  w = (width-1)/float(cols);
  h = (width-1)/float(rows);

  tiles = new Tile[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tiles[x][y] = new Tile(x*w, y*h+spacing, w, h);
    }
  }

  numBombs = 0;
  while (numBombs < round((cols * rows) * 0.2)) {
    boolean found = false;

    while (!found) {
      int randomX = round(random(0, cols - 1));
      int randomY = round(random(0, rows - 1));

      if (!tiles[randomX][randomY].isBomb) {
        tiles[randomX][randomY].isBomb = true;
        numBombs++;
        found = true;
      }
    }
  }

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int bombsNear = 0;

      PVector[] tilesToCheck = {new PVector(x + 1, y), new PVector(x - 1, y), new PVector(x, y + 1), new PVector(x, y - 1), new PVector(x + 1, y + 1), new PVector(x - 1, y + 1), new PVector(x + 1, y - 1), new PVector(x - 1, y - 1)};

      for (int i = 0; i < tilesToCheck.length; i++) {
        if (tilesToCheck[i].x >= 0 && tilesToCheck[i].y >= 0 && tilesToCheck[i].x < cols && tilesToCheck[i].y < rows)
          bombsNear+= tiles[int(tilesToCheck[i].x)][int(tilesToCheck[i].y)].isBomb ? 1 : 0;
      }

      tiles[x][y].bombsNear = bombsNear;
    }
  }

  ui.bombs = numBombs;
  ui.startingMillis = millis();
  ui.time = 0;
  ui.countTime = false;

  win = false;
  gameOver = false;
}

void checkWin() {
  int numShowing = numBombs;
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y].showing)
        numShowing++;
    }
  }

  if (numShowing >= cols*rows)
    winGame();
}
