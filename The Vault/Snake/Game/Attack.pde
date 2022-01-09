class Attack {
  int[][] positions;
  int move = 0; 

  String direction;
  int X;
  int Y;
  int size;
  int timeToWait;

  Attack(String defineDirection, int defineX, int defineY, int defineSize, int defineTimeToWait) {
    direction = defineDirection;
    X = defineX;
    Y = defineY;
    size = defineSize;
    timeToWait = defineTimeToWait;
    positions = new int[size][2];
  };

  void setPos() {
    for (int i = 0; i < size; i++) {
      if (direction == "right") {
        positions[i][0] = X + (move - i * 20);
        positions[i][1] = Y;
      }
      if (direction == "left") {
        positions[i][0] = X + (move + i * 20);
        positions[i][1] = Y;
      }
      if (direction == "down") {
        positions[i][0] = X;
        positions[i][1] = Y + (move - i * 20);
      }
      if (direction == "up") {
        positions[i][0] = X;
        positions[i][1] = Y + (move + i * 20);
      }
    }
  }

  void drawAttack(Snake snakeObject) {
    if (timeToWait < 0) {
      if (snakeObject.poisoned) {
        fill(snakeObject.poisonedAnimation * 2, snakeObject.poisonedAnimation * 2, snakeObject.poisonedAnimation * 2, 200);
      } else {
        fill(0, 0, 0, 200);
      }

      noStroke();

      for (int i = 0; i < size; i++) {
        rect(positions[i][0], positions[i][1], 20, 20);
      }
    }

    if (!snakeObject.dead) {
      timeToWait--;
    }
  };

  void move() {
    if (timeToWait < 0) {
      if (direction == "right" || direction == "down") {
        move+= 20;
      }
      if (direction == "left" || direction == "up") {
        move-= 20;
      }
    }
  }
}
