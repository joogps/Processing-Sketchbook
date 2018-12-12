class Beer {
  boolean draw = false;
  int[] pos = {0, 0};
  float alpha = 0;

  void setPos() {
    pos[0] = width / 2 + round(random(-width / 2, width / 2) / 20) * 20;
    pos[1] = height / 2 + round(random(-height / 2, height / 2) / 20) * 20;
  }

  Beer() {
    setPos();
  }

  void updatePos(Food foodObject, Poison poisonObject, Water waterObject) {
    if ((foodObject.pos[0] == pos[0] && foodObject.pos[1] == pos[1]) || (poisonObject.pos[0] == pos[0] && poisonObject.pos[1] == pos[1]) || (waterObject.pos[0] == pos[0] && waterObject.pos[1] == pos[1])) {
      setPos();
      alpha = 0;
    }

    if (pos[0] - 10 < 0 || pos[0] + 10 > width || pos[1] - 10 < 0 || pos[1] + 10 >= height) {
      setPos();
      alpha = 0;
    }
  }

  void drinkBeer(Snake snakeObject, Water waterObject) {
    if (snakeObject.headPos[0] == pos[0] && snakeObject.headPos[1] == pos[1] && draw) {
      draw = false;
      alpha = 0;
      setPos();
      waterObject.draw = true;
      snakeObject.drunk = true;
      snakeObject.randomDrunkOrientation = round(random(0, 1));
    }
  }

  void drawBeer() {
    if (draw) {
      fill(255, 255, 0, alpha);
      stroke(0, 0, 0, alpha);
      rect(pos[0], pos[1], 10, 10);
      alpha+= 20;
    }
  }
}
