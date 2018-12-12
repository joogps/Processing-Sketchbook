class Player {
  PVector pos;
  float playerWidth;
  float playerHeight;

  float theta = 0;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean poisoned = false;
  float slowdown = 1;

  Player(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    playerWidth = _width;
    playerHeight = _height;
  }

  void display() {
    rectMode(CENTER);
    ui.displayCostume(ui.costumes[ui.index], pos.x, pos.y, playerWidth*0.8, playerHeight*0.8, theta, true);
  }

  void update() {
    if (!dead && !reachedGoal) {
      pos.x = width/2 + round((pos.x - width/2) / playerWidth)*playerWidth;

      if (key == CODED) {
        if((!poisoned && keyCode == UP) || (poisoned && keyCode == DOWN)){
          if (pos.y - playerHeight*1.5 >= 0)
            pos.y-= playerHeight;

          theta = 0;
        }
        else if((!poisoned && keyCode == DOWN) || (poisoned && keyCode == UP)){
          if (pos.y + playerHeight*1.5 <= height)
            pos.y+= playerHeight;

          theta = PI;
        }
        else if((!poisoned && keyCode == LEFT) || (poisoned && keyCode == RIGHT)){
          if (pos.x - playerWidth*1.5 >= 0)
            pos.x-= playerWidth;

          theta = -HALF_PI;
        }
        else if((!poisoned && keyCode == RIGHT) || (poisoned && keyCode == LEFT)){
          if (pos.x + playerWidth*1.5 <= width)
            pos.x+= playerWidth;

          theta = HALF_PI;
        }
      } else {
        if (pos.y - playerHeight*1.5 >= 0 && !poisoned)
          pos.y-= playerHeight;
          theta = 0;
          
        if (pos.y + playerHeight*1.5 <= height && poisoned)
          pos.y+= playerHeight;
          theta = PI;

      }
    } else {
      if (reachedGoal) {
        level*= 2;
      }
      setGame();
    }
  }
}
