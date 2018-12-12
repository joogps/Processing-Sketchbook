class UI {
  String[] costumes = {"frog", "pig", "robot", "chicken"};
  int index = 0;

  boolean display = false;

  void display() {
    background(200);

    textAlign(CENTER, BASELINE);
    textSize(30);

    fill(0);
    text(costumes[index].substring(0, 1).toUpperCase() + costumes[index].substring(1, costumes[index].length()), width/2, height/2 - height/4);

    displayCostume(costumes[index], width/2, height/2 + height/4, width/3, height/3, 0, false);

    if (index > 0) {
      displayCostume(costumes[index-1], 0, height/2 + height/4, width/4, height/4, 0, false);
    }

    if (index < costumes.length-1) {
      displayCostume(costumes[index+1], width, height/2 + height/4, width/4, height/4, 0, false);
    }
  }

  void update() {
    if (display) {
      if (keyCode == RIGHT && index < costumes.length-1) {
        index+= 1;
      }

      if (keyCode == LEFT && index > 0) {
        index-= 1;
      }
    }

    if (keyCode == ALT || keyCode == CONTROL) {
      display = !display;
    }
  }

  void displayCostume(String costume, float x, float y, float _width, float _height, float theta, boolean adapt) {
    switch(costume) {
    case "frog":
      drawFrog(x, y, _width, _height, theta, adapt);
      break;
    case "pig":
      drawPig(x, y, _width, _height, theta, adapt);
      break;
    case "robot":
      drawRobot(x, y, _width, _height, theta, adapt);
      break;
    case "chicken":
      drawChicken(x, y, _width, _height, theta, adapt);
    }
  }

  color costumeColor(color defaultColor, boolean adapt) {
    return adapt ? !player.dead ? !player.poisoned ? player.slowdown == 1 ? defaultColor : color(255, 255, 22) : color(128, 100, 244) : color(255, 0, 30) : defaultColor;
  }

  void drawFrog(float x, float y, float _width, float _height, float theta, boolean adapt) {
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(theta);

    fill(costumeColor(color(0, 255, 50), adapt));
    rect(0, 0, _width, _height);

    fill(0);
    rect(-_width/5, -_height/3, _width/5, _height/5);
    rect(_width/5, -_height/3, _width/5, _height/5);
    popMatrix();
  }

  void drawPig(float x, float y, float _width, float _height, float theta, boolean adapt) {
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(theta);

    fill(costumeColor(color(229, 117, 255), adapt));
    rect(0, 0, _width, _height);

    fill(0);
    rect(-_width/5, -_height/3, _width/5, _height/5);
    rect(_width/5, -_height/3, _width/5, _height/5);

    fill(lerpColor(costumeColor(color(229, 117, 255), adapt), color(0), 0.3));
    rect(0, _height/5, _width * 0.4, _height * 0.3);
    popMatrix();
  }

  void drawRobot(float x, float y, float _width, float _height, float theta, boolean adapt) {
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(theta);

    fill(costumeColor(color(130), adapt));
    rect(0, 0, _width, _height);

    fill(lerpColor(costumeColor(color(100, 100, 255), adapt), color(100, 100, 255), 0.25));
    rect(-_width/5, -_height/3, _width/5, _height/5);
    rect(_width/5, -_height/3, _width/5, _height/5);

    fill(lerpColor(costumeColor(color(255), adapt), color(255), 0.25));
    for (int _x = 0; _x < 4; _x++) {
      for (int _y = 0; _y < 2; _y++) {
        rect((-_width * 0.6 / 4) * 1.5 + (_x * _width * 0.6 / 4), _height/10 + (_height * 0.6 / 4) * _y, _width * 0.6 / 4, _height * 0.6 / 4);
      }
    }
    popMatrix();
  }

  void drawChicken(float x, float y, float _width, float _height, float theta, boolean adapt) {
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(theta);

    fill(costumeColor(color(255), adapt));
    rect(0, 0, _width, _height);

    fill(lerpColor(costumeColor(color(0), adapt), color(0), 0.25));
    rect(-_width/5, -_height/8, _width/5, _height/5);
    rect(_width/5, -_height/8, _width/5, _height/5);

    fill(lerpColor(costumeColor(color(255, 0, 0), adapt), color(255, 0, 0), 0.25));
    rect(0, -_height/2 + _height/10, _width/3, _height/5);

    fill(lerpColor(costumeColor(color(255, 255, 0), adapt), color(255, 255, 0), 0.25));
    rect(0, _height/2 - _height/6, _width/3, _height/3);
    popMatrix();
  }
}
