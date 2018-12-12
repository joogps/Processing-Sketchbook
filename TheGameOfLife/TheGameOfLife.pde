int cols;
int rows;

boolean[][] grid;

int size;

void setup() {
  fullScreen();

  size = int(((width/128.0)+(height/72.0))/2.0);

  cols = width/size;
  rows = height/size;

  grid = new boolean[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = false;
    }
  }

  for (int i = 0; i < cols/2; i++) {
    for (int j = 0; j < rows/2; j++) {
      boolean sucessful = false;

      while (!sucessful) {
        int randomX = int(random(0, cols));
        int randomY = int(random(0, rows));

        if (!grid[randomX][randomY]) {
          grid[randomX][randomY] = true;
          sucessful = true;
        } else {
          continue;
        }
      }
    }
  }

  colorMode(HSB);
};

void draw() {
  frameRate(30);

  boolean[][] newGrid = new boolean[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int aliveNeighbors = 0;

      if (i+1 < cols && grid[i+1][j])
        aliveNeighbors++;

      if (i-1 >= 0 && grid[i-1][j])
        aliveNeighbors++;

      if (j+1 < rows && grid[i][j+1])
        aliveNeighbors++;

      if (j-1 >= 0 && grid[i][j-1])
        aliveNeighbors++;

      if (i + 1 < cols && j + 1 < rows && grid[i+1][j+1])
        aliveNeighbors++;

      if (i + 1 < cols && j - 1 > 0 && grid[i+1][j-1])
        aliveNeighbors++;

      if (i - 1 > 0 && j + 1 < rows && grid[i-1][j+1])
        aliveNeighbors++;

      if (i - 1 > 0 && j - 1 > 0 && grid[i-1][j-1])
        aliveNeighbors++;

      if (grid[i][j]) {
        if (aliveNeighbors == 2 || aliveNeighbors == 3) {
          newGrid[i][j] = true;
        }

        if (aliveNeighbors < 2 || aliveNeighbors > 3) {
          newGrid[i][j] = false;
        }
      } else {
        if (aliveNeighbors == 3) {
          newGrid[i][j] = true;
        } else {
          newGrid[i][j] = false;
        }
      }
    }
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (newGrid[i][j]) {
        fill(map(i*j, 0, cols*rows, 0, 255), 255, 255);
        stroke(0, 0, 255);
      } else {
        fill(0, 0, 255, 150);
        stroke(map(i*j, 0, cols*rows, 0, 255), 255, 255);
      }

      rect(i*size, j*size, size, size);
    }
  }

  grid = newGrid;
}

void mouseMoved() {
  grid = new boolean[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = false;
    }
  }

  for (int i = 0; i < cols/map((mouseX * mouseY), 0, width * height, 5, 2); i++) {
    for (int j = 0; j < rows/map((mouseX * mouseY), 0, width * height, 5, 2); j++) {
      boolean sucessful = false;

      while (!sucessful) {
        int randomX = int(random(0, cols));
        int randomY = int(random(0, rows));

        if (!grid[randomX][randomY]) {
          grid[randomX][randomY] = true;
          sucessful = true;
        } else
          continue;
      }
    }
  }
}

void mouseClicked() {
  grid = new boolean[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = false;
    }
  }

  for (int i = 0; i < cols/map((mouseX * mouseY), 0, width * height, 5, 2); i++) {
    for (int j = 0; j < rows/map((mouseX * mouseY), 0, width * height, 5, 2); j++) {
      boolean sucessful = false;

      while (!sucessful) {
        int randomX = int(random(0, cols));
        int randomY = int(random(0, rows));

        if (!grid[randomX][randomY]) {
          grid[randomX][randomY] = true;
          sucessful = true;
        } else
          continue;
      }
    }
  }
}
