class Water {
  boolean draw = false;
  int[] pos = {0, 0};
  float alpha = 0;

  void setPos() {
    pos[0] = width / 2 + round(random(-width / 2, width / 2) / 20) * 20;
    pos[1] = height / 2 + round(random(-height / 2, height / 2) / 20) * 20;
  }

  Water() {
    setPos();
  }

  void updatePos(Food foodObject, Poison poisonObject, Beer beerObject) {
    if ((foodObject.pos[0] == pos[0] && foodObject.pos[1] == pos[1]) || (poisonObject.pos[0] == pos[0] && poisonObject.pos[1] == pos[1]) || (beerObject.pos[0] == pos[0] && beerObject.pos[1] == pos[1])) {
      setPos();
      alpha = 0;
    }

    if (pos[0] - 10 < 0 || pos[0] + 10 > width || pos[1] - 10 < 0 || pos[1] + 10 > height) {
      setPos();
      alpha = 0;
    }
  }

  void drinkWater(Snake snakeObject, Food foodObject) {
    if (snakeObject.headPos[0] == pos[0] && snakeObject.headPos[1] == pos[1] && draw) {
      setPos();
      draw = false;
      alpha = 0;
      foodObject.draw = true;
      snakeObject.drunk = false;
      snakeObject.drunkAnimation = 1;
      snakeObject.drunkIncrease = true;

      snakeObject.poisoned = false;
      snakeObject.poisonedAlpha = 0;
      snakeObject.poisonedAnimation = 0;
    }
  }

  void drawWater(Snake snakeObject) {
    if (draw) {
      if (snakeObject.drunk) {
        fill(50, 50, 255, alpha);
        stroke(0, 0, 0, alpha);
      }

      if (snakeObject.poisoned) {
        fill(255, 255, 255, alpha);
        stroke(255, 255, 255, alpha);
      }

      rect(pos[0], pos[1], 10, 10);
      alpha+= 10;
    }
  }
}
