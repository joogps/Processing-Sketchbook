class Body {
  ArrayList<Floor> floors;
  Ball ball;

  float angle;
  float angleTarget;

  float camera;

  color bodyColor;

  ArrayList<Particle[]> pSystem;
  ArrayList<Drop> drops;

  int numFloors;
  int target;

  float focus;

  Body(int level) {
    target = level;

    bodyColor = color(random(0, 255), random(0, 255), random(0, 255));
    ball = new Ball(0, 75, 175, bodyColor);

    numFloors = 0;

    floors = new ArrayList<Floor>();
    for (int i = 0; i < (target > 5 ? 5 : target+1); i++) {
      if (numFloors < target)
        floors.add(new Floor(0, 0, i*-200, bodyColor, abs(ball.leftSide - ball.rightSide), false));
      else if (numFloors == target)
        floors.add(new Floor(0, 0, i*-200, bodyColor, abs(ball.leftSide - ball.rightSide), true));

      numFloors++;
    }

    angle = HALF_PI;
    angleTarget = HALF_PI;

    camera = -ball.pos.z;

    pSystem = new ArrayList<Particle[]>();
    drops = new ArrayList<Drop>();
  }

  void display() {
    translate(width/2, height/2, 20+focus);
    rotateX(QUARTER_PI * 1.5);

    fill(bodyColor);
    cylinder(0, 50, 0, 50, height, height, 0, TWO_PI, 100);

    translate(0, 0, camera);
    for (int i = floors.size()-1; i >= 0; i--) {
      if (floors.get(i) != null) {
        floors.get(i).display();
      }
    }

    ball.display();

    for (int i = 0; i < pSystem.size(); i++) {
      if (pSystem.get(i) != null) {
        for (int j = 0; j < pSystem.get(i).length; j++) {
          pSystem.get(i)[j].display();
          pSystem.get(i)[j].update();
          pSystem.get(i)[j].kill();

          if (pSystem.get(i)[j].alpha < 5) {
            pSystem.set(i, null);
            break;
          }
        }
      }
    }

    for (int i = 0; i < drops.size(); i++) {
      if (drops.get(i) != null) {
        drops.get(i).display();
        drops.get(i).kill();

        if (drops.get(i).alpha < 10) {
          drops.set(i, null);
          break;
        }
      }
    }
  }

  void update() {
    ball.update();

    for (int i = floors.size()-1; i >= 0; i--) {
      if (floors.get(i) != null) {
        ball.collide(floors.get(i));

        if (floors.get(i).mains[0].pos.z - floors.get(i).mains[0].bDepth + camera > height/2 || floors.get(i).floorAlpha < 5) {
          if (numFloors <= target) {
            floors.add(new Floor(0, 0, floors.get(floors.size()-1).mains[0].pos.z -200, bodyColor, abs(ball.leftSide - ball.rightSide), numFloors == target));
            numFloors++;
          }

          floors.set(i, null);
        }
      }

      if (floors.get(i) != null && (floors.get(i).mains[0].pos.z - floors.get(i).mains[0].bDepth > ball.pos.z + ball.radius || floors.get(i).floorAlpha < 255 || floors.get(i).kill)) {
        floors.get(i).die();
      }
    }

    if (!ball.dead && !ball.finished) {
      if (keyPressed) {
        if (keyCode == RIGHT || key == 'd' || key == 'D')
          angleTarget+= (TWO_PI/200);
        if (keyCode == LEFT || key == 'a' || key == 'A')
          angleTarget+= (TWO_PI/200)*-1;
        if (pmouseX > mouseX) {
          angleTarget+= (TWO_PI/200)*2;
        } else if (pmouseX < mouseX) {
          angleTarget-= (TWO_PI/200)*2;
        }
      }
    }

    angle = lerp(angle, angleTarget, 0.25);

    camera = lerp(camera, -ball.pos.z, 0.05);
  }
}
