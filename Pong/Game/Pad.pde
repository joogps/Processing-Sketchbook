class Pad {
  PVector position;
  int[] size;

  int points;

  boolean AIIncrease;

  Pad(int x, int y, int size1, int size2) {
    position = new PVector(x, y);
    size = new int[2];
    size[0] = size1;
    size[1] = size2;

    AIIncrease = round(random(0, 1)) == 1 ? true : false;
  }

  void display() {
    rectMode(CENTER);
    fill(255);
    rect(position.x, position.y, size[0], size[1]);
  }

  void playerMove() {
    if (keyPressed && down && !up && position.y + size[1] / 2 < height - position.x / 2) {
      position.y+= 3;
    }

    if (keyPressed && up && !down && keyCode == UP && position.y - size[1] / 2 > position.x / 2) {
      position.y-= 3;
    }
  }

  void AIMove() {
    if (AIIncrease) {
      position.y+= 3;
    } else {
      position.y-= 3;
    }

    if (position.y + size[1] / 2 > height - (width - position.x) / 2) {
      AIIncrease = false;
    }

    if (position.y - size[1] / 2 < (width - position.x) / 2) {
      AIIncrease = true;
    }
  }
}
