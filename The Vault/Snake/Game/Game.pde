PImage upDown;
PImage leftRight;
PImage curveUpDownRight;
PImage curveUpDownLeft;
PImage curveDownUpRight;
PImage curveDownUpLeft;
PImage headUp;
PImage headDown;
PImage headRight;
PImage headLeft;

Snake snake;

int randomItemAppear;

Food food;
Beer beer;
Poison poison;
Water water;

int randomAttackDirection;
int randomAttackType;

Attack[] attacks;
Attack attackCheck;

void setItem() {
  randomItemAppear = round(random(1, 3));

  if (randomItemAppear == 1) {
    food.draw = true;

    beer.draw = false;
    poison.draw = false;
  }

  if (randomItemAppear == 2) {
    beer.draw = true;

    food.draw = false;
    poison.draw = false;
  }

  if (randomItemAppear == 3) {
    poison.draw = true;

    food.draw = false;
    beer.draw = false;
  }
}

void setAttacks() {
  randomAttackDirection = round(random(1, 4));
  randomAttackType = round(random(1, 2));

  if (randomAttackDirection == 1) {
    if (randomAttackType == 1) {
      attacks = new Attack[3];

      attacks[0] = new Attack("down", width / 2, height / 2 - round((width / 2) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("down", width / 2 - round((width / 3) / 20) * 20, height / 2 - round((height / 2 + 80) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[2] = new Attack("down", width / 2 + round((width / 3) / 20) * 20, height / 2 - round((height / 2 + 80) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[1];
    } else if (randomAttackType == 2) {
      attacks = new Attack[2];

      attacks[0] = new Attack("down", width / 2 - round((width / 3) / 20) * 20, height / 2 - round((height / 2) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("down", width / 2 + round((width / 3) / 20) * 20, height / 2 - round((height / 2) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[0];
    }
  }

  if (randomAttackDirection == 2) {
    if (randomAttackType == 1) {
      attacks = new Attack[3];

      attacks[0] = new Attack("right", width / 2 - round((width / 2) / 20) * 20, height / 2, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("right", width / 2 - round((width / 2 + 80) / 20) * 20, height / 2 - round((height / 3) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[2] = new Attack("right", width / 2 - round((width / 2 + 80) / 20) * 20, height / 2 + round((height / 3) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[1];
    } else if (randomAttackType == 2) {
      attacks = new Attack[2];

      attacks[0] = new Attack("right", width / 2 - round((width / 2) / 20) * 20, height / 2 - round((height / 3) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("right", width / 2 - round((width / 2) / 20) * 20, height / 2 + round((height / 3) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[0];
    }
  }

  if (randomAttackDirection == 3) {
    if (randomAttackType == 1) {
      attacks = new Attack[3];

      attacks[0] = new Attack("up", width / 2, height / 2 + round((height / 2) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("up", width / 2 - round((width / 3) / 20) * 20, height / 2 + round((height / 2 + 80) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[2] = new Attack("up", width / 2 + round((width / 3) / 20) * 20, height / 2 + round((height / 2 + 80) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[1];
    } else if (randomAttackType == 2) {
      attacks = new Attack[2];

      attacks[0] = new Attack("up", width / 2 - round((width / 3) / 20) * 20, height / 2 + round((height / 2) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("up", width / 2 + round((width / 3) / 20) * 20, height / 2 + round((height / 2) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[0];
    }
  }

  if (randomAttackDirection == 4) {
    if (randomAttackType == 1) {
      attacks = new Attack[3];

      attacks[0] = new Attack("left", width / 2 + round((width / 2) / 20) * 20, height / 2, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("left", width / 2 + round((width / 2 + 80) / 20) * 20, height / 2 - round((height / 3) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);
      attacks[2] = new Attack("left", width / 2 + round((width / 2 + 80) / 20) * 20, height / 2 + round((height / 3) / 20) * 20, 4 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[1];
    } else if (randomAttackType == 2) {
      attacks = new Attack[2];

      attacks[0] = new Attack("left", width / 2 + round((width / 2) / 20) * 20, height / 2 - round((height / 3) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);
      attacks[1] = new Attack("left", width / 2 + round((width / 2) / 20) * 20, height / 2 + round((height / 3) / 20) * 20, 6 + round(snake.way.size() / 3), 60 * 3);

      attackCheck = attacks[0];
    }
  }
}

void settings() {
  size(650, 450);
}

void setup() {
  upDown = loadImage("..\\Assets\\snakeBodyUpDown.png");
  leftRight = loadImage("..\\Assets\\snakeBodyLeftRight.png"); 
  curveUpDownRight = loadImage("..\\Assets\\snakeCurveUpDownRight.png");
  curveUpDownLeft = loadImage("..\\Assets\\snakeCurveUpDownLeft.png");
  curveDownUpRight = loadImage("..\\Assets\\snakeCurveDownUpRight.png");
  curveDownUpLeft = loadImage("..\\Assets\\snakeCurveDownUpLeft.png");
  headUp = loadImage("..\\Assets\\snakeHeadUp.png");
  headDown = loadImage("..\\Assets\\snakeHeadDown.png");
  headRight = loadImage("..\\Assets\\snakeHeadRight.png");
  headLeft = loadImage("..\\Assets\\snakeHeadLeft.png");

  snake = new Snake();
  food = new Food();
  beer = new Beer();
  poison = new Poison();
  water = new Water();

  setItem();

  setAttacks();

  surface.setTitle("Snake");
  surface.setIcon(headUp);
};

void draw() {
  if ((attackCheck.positions[attackCheck.positions.length - 1][0] + 10 < 0 && attackCheck.direction == "left") || (attackCheck.positions[attackCheck.positions.length - 1][1] + 10 < 0 && attackCheck.direction == "up") || (attackCheck.positions[attackCheck.positions.length - 1][0] - 10 > width && attackCheck.direction == "right") || (attackCheck.positions[attackCheck.positions.length - 1][1] - 10 > height && attackCheck.direction == "down")) {
    setAttacks();
  }

  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);

  if (snake.drunk) {
    background(160 - (snake.drunkAnimation * 3), 160 - (snake.drunkAnimation * 3), 220 + (snake.drunkAnimation * 3));
  } else if (snake.poisoned) {
    background(180 - snake.poisonedAnimation);
  } else {
    background(180);
  }

  for (int i = 0; i < attacks.length; i++) {
    attacks[i].setPos();
  }

  snake.drunkEffect();
  snake.poisonedEffect();

  food.updatePos(beer, poison, water);
  beer.updatePos(food, poison, water);
  poison.updatePos(food, beer, water);
  water.updatePos(food, poison, beer);

  beer.drinkBeer(snake, water);
  poison.drinkPoison(snake, water);
  water.drinkWater(snake, food);

  if (frameCount % 12 - round(snake.speed) == 1) {
    food.eatFood(snake);
    snake.moveUpdate();

    for (int i = 0; i < attacks.length; i++) {
      attacks[i].move();
    }
  }

  food.drawFood();
  beer.drawBeer();
  poison.drawPoison();
  water.drawWater(snake);

  snake.drawSnake(food, beer, poison, water, attacks);

  for (int i = 0; i < attacks.length; i++) {
    attacks[i].drawAttack(snake);
  }

  snake.dead();
};

void keyPressed() {
  if (snake.dead) {
    if (snake.deadCounter >= frameRate / 1.5) {
      snake = new Snake();
      food = new Food();
      beer = new Beer();
      poison = new Poison();
      water = new Water();

      setItem();

      setAttacks();

      snake.way.clear();

      if (keyCode == DOWN) {
        snake.startingDirection = 1;
      }
      if (keyCode == RIGHT) {
        snake.startingDirection = 2;
      }
      if (keyCode == UP) {
        snake.startingDirection = 3;
      }
      if (keyCode == LEFT) {
        snake.startingDirection = 4;
      }

      for (int i = 0; i < 6; i++) {
        if (snake.startingDirection == 1) {
          snake.way.add("down");
        }
        if (snake.startingDirection == 2) {
          snake.way.add("right");
        }
        if (snake.startingDirection == 3) {
          snake.way.add("up");
        }
        if (snake.startingDirection == 4) {
          snake.way.add("left");
        }
      }
    } else {
      snake.deadCounter = frameRate / 1.5;
    }
  }

  snake.keyCheck();
};
