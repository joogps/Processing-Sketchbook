class Food {
  boolean draw = false;
  int[] pos = {0, 0};
  float alpha = 0;

  void setPos() {
    pos[0] = width / 2 + round(random(-width / 2, width / 2) / 20) * 20;
    pos[1] = height / 2 + round(random(-height / 2, height / 2) / 20) * 20;
  }

  Food() {
    setPos();
  }

  void updatePos(Beer beerObject, Poison poisonObject, Water waterObject) {
    if ((beerObject.pos[0] == pos[0] && beerObject.pos[1] == pos[1]) || (poisonObject.pos[0] == pos[0] && poisonObject.pos[1] == pos[1]) || (waterObject.pos[0] == pos[0] && waterObject.pos[1] == pos[1])) {
      setPos();
      alpha = 0;
    }

    if (pos[0] - 10 < 0 || pos[0] + 10 > width || pos[1] - 10 < 0 || pos[1] + 10 > height) {
      setPos();
      alpha = 0;
    }
  }

  void eatFood(Snake snakeObject) {
    if (snakeObject.headPos[0] == pos[0] && snakeObject.headPos[1] == pos[1] && draw) {
      snakeObject.way.add(snakeObject.way.get(0));
      if (snakeObject.speed <= 6) {
        snakeObject.speed+= 0.5;
      }
      alpha = 0;

      setItem();
      setPos();
    }
  }

  void drawFood() {
    if (draw) {
      fill(255, 0, 0, alpha);
      stroke(0, 0, 0, alpha);
      rect(pos[0], pos[1], 10, 10);
      alpha+= 10;
    }
  }
}
