float x, y;

int xDirection;
int yDirection;

int prevXDirection;
int prevYDirection;

int cols;
int rows;
float[] size;

Tile[][] tiles;

void setup() {
  size(640, 640);

  cols = 4;
  rows = 4;

  size = new float[2];
  size[0] = width / cols;
  size[1] = height / cols;

  tiles = new Tile[cols][rows];

  for (int i = 0; i < 2; i++) {
    while (true) {
      int x = round(random(0, cols-1));
      int y = round(random(0, rows-1));

      if (tiles[x][y] == null) {
        tiles[x][y] = new Tile(x * size[0], y * size[1], size[0], size[1]);
        break;
      }
    }
  }
}

void draw() {
  background(100);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] != null) {
        tiles[x][y].show();
      }
    }
  }

  x = mouseX - pmouseX;
  y = mouseY - pmouseY;

  xDirection = int(x / abs(x));
  yDirection = int(y / abs(y));

  if (mousePressed && (xDirection != prevXDirection || xDirection != prevXDirection) && xDirection != 0 && yDirection != 0) {
    moveTiles(abs(x) > abs(y) ? xDirection : 0, abs(y) > abs(x) ? yDirection : 0);
  }

  prevXDirection = xDirection;
  prevYDirection = yDirection;
}

void moveTiles(int dirX, int dirY) {
  ArrayList<PVector> notToCheck = new ArrayList<PVector>();

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] != null && !notToCheck.contains(new PVector(x, y))) {
        tiles[x][y].x = constrain((x + dirX), 0, cols-1) * size[0];
        tiles[x][y].y = constrain((y + dirY), 0, rows-1) * size[1];

        tiles[constrain((x + dirX), 0, cols-1)][constrain((y + dirY), 0, rows-1)] = tiles[x][y];
        notToCheck.add(new PVector(constrain((x + dirX), 0, cols-1), constrain((y + dirY), 0, rows-1)));
        tiles[x][y] = null;
      }
    }
  }
}
