class Snake {
  ArrayList<String> way = new ArrayList();
  String wayAdd;
  int startingDirection = round(random(1, 4));
  float speed = 0;

  int[] prevPos = {0, 0};
  int[] walkPos = {0, 0};
  int[] headPos = {0, 0};

  boolean dead = false;
  float deadCounter = 0;

  float deadAnimation = 0;
  boolean deadIncrease = true;

  boolean drunk = false;
  boolean drunkIncrease = true;
  float drunkAnimation = 1; 
  int randomDrunkOrientation = round(random(0, 1));

  boolean poisoned = false;
  boolean poisonedIncrease = true;
  float poisonedAlpha = 0;
  float poisonedAnimation = 0;

  Snake() {
    prevPos[0] = width/2;
    prevPos[1] = height/2;

    walkPos[0] = width/2;
    walkPos[1] = height/2;
    headPos[0] = width/2;
    headPos[1] = height/2;

    for (int i = 0; i < 6; i++) {
      if (startingDirection == 1) {
        way.add("down");
      }
      if (startingDirection == 2) {
        way.add("right");
      }
      if (startingDirection == 3) {
        way.add("up");
      }
      if (startingDirection == 4) {
        way.add("left");
      }
    }
  }

  void drawSnake(Food foodObject, Beer beerObject, Poison poisonObject, Water waterObject, Attack[] attackObjects) {
    prevPos[0] = walkPos[0];
    prevPos[1] = walkPos[1];

    for (int i = 0; i < way.size(); i++) {
      if (way.get(i) == "up") {
        prevPos[1]+= 20;
      }
      if (way.get(i) == "down") {
        prevPos[1]-= 20;
      }
      if (way.get(i) == "left") {
        prevPos[0]+= 20;
      }
      if (way.get(i) == "right") {
        prevPos[0]-= 20;
      }

      if (i == 0) {
        headPos[0] = prevPos[0];
        headPos[1] = prevPos[1];
      } else if (headPos[0] == prevPos[0] && headPos[1] == prevPos[1] && !dead) {
        dead = true;
      }

      if (i != 0) {
        if (foodObject.pos[0] == prevPos[0] && foodObject.pos[1] == prevPos[1]) {
          foodObject.setPos();
          foodObject.alpha = 0;
        }
        if (beerObject.pos[0] == prevPos[0] && beerObject.pos[1] == prevPos[1]) {
          beerObject.setPos();
          beerObject.alpha = 0;
        }
        if (poisonObject.pos[0] == prevPos[0] && poisonObject.pos[1] == prevPos[1]) {
          poisonObject.setPos();
          poisonObject.alpha = 0;
        }
        if (waterObject.pos[0] == prevPos[0] && waterObject.pos[1] == prevPos[1]) {
          waterObject.setPos();
          waterObject.alpha = 0;
        }
      }

      for (int j = 0; j < attackObjects.length; j++) {
        for (int k = 0; k < attackObjects[j].size; k ++) {
          if (!dead && (attackObjects[j].positions[k][0] == prevPos[0] && attackObjects[j].positions[k][1] == prevPos[1])) {
            dead = true;
          }
        }
      }

      if (!dead) {
        if (!poisoned) {
          if (i != 0 && i != way.size() - 1) { 
            if ((way.get(i) == "right" && way.get(i + 1) == "down") || (way.get(i) == "up" && way.get(i + 1) == "left")) {
              image(curveUpDownRight, prevPos[0], prevPos[1], 20, 20);
            } else if ((way.get(i) == "left" && way.get(i + 1) == "down") || (way.get(i) == "up" && way.get(i + 1) == "right")) {
              image(curveUpDownLeft, prevPos[0], prevPos[1], 20, 20);
            } else if ((way.get(i + 1) == "up" && way.get(i) == "left") || (way.get(i + 1) == "right" && way.get(i) == "down")) {
              image(curveDownUpLeft, prevPos[0], prevPos[1], 20, 20);
            } else if ((way.get(i + 1) == "up" && way.get(i) == "right") || (way.get(i + 1) == "left" && way.get(i) == "down")) {
              image(curveDownUpRight, prevPos[0], prevPos[1], 20, 20);
            } else {
              if (way.get(i) == "up" || way.get(i) == "down") {
                image(upDown, prevPos[0], prevPos[1], 20, 20);
              }
              if (way.get(i) == "left" || way.get(i) == "right") {
                image(leftRight, prevPos[0], prevPos[1], 20, 20);
              }
            }
          } else if (i == 0) {
            if (way.get(i) == "up") {
              image(headUp, prevPos[0], prevPos[1], 20, 20);
            }
            if (way.get(i) == "down") {
              image(headDown, prevPos[0], prevPos[1], 20, 20);
            }
            if (way.get(i) == "right") {
              image(headRight, prevPos[0], prevPos[1], 20, 20);
            }
            if (way.get(i) == "left") {
              image(headLeft, prevPos[0], prevPos[1], 20, 20);
            }
          } else {
            if (way.get(i) == "up" || way.get(i) == "down") {
              image(upDown, prevPos[0], prevPos[1], 20, 20);
            }
            if (way.get(i) == "left" || way.get(i) == "right") {
              image(leftRight, prevPos[0], prevPos[1], 20, 20);
            }
          }
        } else {
          if (i == 0) {                  
            fill(255, 255, 255, poisonedAlpha);
            noStroke();
            rect(prevPos[0], prevPos[1], 20, 20);
          }
        }
      } else {
        fill(255, 0, 0);
        stroke(0);
        rect(prevPos[0], prevPos[1], 20 - deadAnimation, 20 - deadAnimation);
      }
    }

    if ((walkPos[0] - 10 > width || walkPos[0] < -10 || walkPos[1] - 10 > height || walkPos[1] < -10) && !dead) {
      dead = true;
    }
  }

  void moveUpdate() {
    if (wayAdd == "down" || wayAdd == "up" || wayAdd == "left" || wayAdd == "right") {
      if (wayAdd == "left" || wayAdd == "right") {
        if (way.get(0) == "up") {
          walkPos[1]+= 20;
        } else if (way.get(0) == "down") {
          walkPos[1]-= 20;
        }
      }

      if (wayAdd == "up" || wayAdd == "down") {
        if (way.get(0) == "left") {
          walkPos[0]+= 20;
        } else if (way.get(0) == "right") {
          walkPos[0]-= 20;
        }
      }

      if (wayAdd == "left") {
        walkPos[0]-= 20;
      }
      if (wayAdd == "right") {
        walkPos[0]+= 20;
      }
      if (wayAdd == "up") {
        walkPos[1]-= 20;
      }
      if (wayAdd == "down") {
        walkPos[1]+= 20;
      }

      way.set(0, wayAdd);
      wayAdd = "false";
    }

    for (int i = way.size() - 1; i > 0; i--) {
      if (!dead) {
        way.set(i, way.get(i - 1));
      }
    }

    if (!dead) {
      if (way.get(0) == "left") {
        walkPos[0]-= 20;
      }
      if (way.get(0) == "right") {
        walkPos[0]+= 20;
      }
      if (way.get(0) == "down") {
        walkPos[1]+= 20;
      }
      if (way.get(0) == "up") {
        walkPos[1]-= 20;
      }
    }
  }

  void dead() {
    if (dead) {
      deadCounter++;

      if (deadAnimation >= 5) {
        deadIncrease = false;
      }

      if (deadAnimation <= 1) {
        deadIncrease = true;
      }

      if (deadIncrease) {
        deadAnimation+= 0.25;
      } else {
        deadAnimation-= 0.25;
      }
    }
  }

  void keyCheck() {
    if (!dead) {
      if (!drunk) {
        if ((way.get(0) == "up" || way.get(0) == "down") && keyCode == LEFT) {        
          wayAdd = "left";
        }
        if ((way.get(0) == "up" || way.get(0) == "down") && keyCode == RIGHT) {  
          wayAdd = "right";
        }
        if ((way.get(0) == "right" || way.get(0) == "left") && keyCode == UP) {        
          wayAdd = "up";
        }
        if ((way.get(0) == "right" || way.get(0) == "left") && keyCode == DOWN) {
          wayAdd = "down";
        }
      } else {
        if ((way.get(0) == "up" || way.get(0) == "down") && keyCode == RIGHT) {        
          wayAdd = "left";
        }
        if ((way.get(0) == "up" || way.get(0) == "down") && keyCode == LEFT) {  
          wayAdd = "right";
        }
        if ((way.get(0) == "right" || way.get(0) == "left") && keyCode == DOWN) {        
          wayAdd = "up";
        }
        if ((way.get(0) == "right" || way.get(0) == "left") && keyCode == UP) {
          wayAdd = "down";
        }
      }
    }
  }

  void drunkEffect() {
    if (drunk) {
      stroke(0, 0, 150);
      fill(100, 100, 200, drunkAnimation * 15);
      for (float i = -(width / 5); i <= width + width / 5; i += width / 5) { 
        if (randomDrunkOrientation == 0) {
          bezier(i - width / (10 - drunkAnimation), 0, i - width / (10 - drunkAnimation), (height / 4), i + width / (10 - drunkAnimation), (height / 4) * 3, i + width / (10 - drunkAnimation), height);
        } else {
          bezier(i + width / (10 - drunkAnimation), 0, i + width / (10 - drunkAnimation), (height / 4), i - width / (10 - drunkAnimation), (height / 4) * 3, i - width / (10 - drunkAnimation), height);
        }
      }

      if (drunkIncrease) {
        drunkAnimation*= 1.1 - drunkAnimation / 70;
      } else {
        drunkAnimation/= 1.1 - drunkAnimation / 70;
      }

      if (drunkAnimation >= 6) {
        drunkIncrease = false;
      }

      if (drunkAnimation < 0.3) {
        drunkIncrease = true;
      }
    }
  }

  void poisonedEffect() {
    if (poisoned) {
      if (poisonedIncrease) {
        poisonedAlpha+= 0.1;
      } else {
        poisonedAlpha-= 0.5;
      }

      if (poisonedAlpha >= 25) {
        poisonedIncrease = false;
      }
      if (poisonedAlpha <= 0) {
        poisonedIncrease = true;
      }

      poisonedAnimation+= 10;
    }
  }
}
