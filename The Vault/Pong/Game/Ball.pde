class Ball {
  PVector position;
  PVector speed;

  int size;  

  PVector newSpeed;

  Ball(int x, int y, PVector _speed) {
    position = new PVector(x, y);
    speed = new PVector(round(random(0, 1)) == 1 ? -_speed.x : _speed.x, round(random(0, 1)) == 1 ? -_speed.y : _speed.y);

    size = 35;
  }

  void display() {
    ellipse(position.x, position.y, size, size);
  }

  void move() {
    position.x+= speed.x;
    position.y+= speed.y;
  }

  void wallKick() {
    if (position.y - size/2 < 0 || position.y + size/2 > height) {
      speed.y*= -1;
    }
  }

  void addPoint() {
    if (speed.x < 7 && speed.y < 7) {
      newSpeed = new PVector(abs(speed.x) + 0.2, abs(speed.y) + 0.2);
    } else {
      newSpeed = new PVector(abs(speed.x), abs(speed.y));
    }

    if (position.x + size/2 < 0) {
      padAI.points++;
      ball = new Ball(width / 2, height / 2, newSpeed);
    }

    if (position.x - size/2 > width) {
      pad1.points++;
      ball = new Ball(width / 2, height / 2, newSpeed);
    }
  }

  void padKick(Pad pad) {
    boolean xCheck = pad == pad1 ? position.x - size/2 <= pad.position.x + pad.size[0] / 2 : position.x + size/2 >= pad.position.x - pad.size[0] / 2;
    boolean xCheck2 = pad == pad1 ? position.x - size/2 < pad.position.x + pad.size[0] / 3 : position.x + size/2 > pad.position.x - pad.size[0] / 3;

    if ((position.y + size/2 > pad.position.y - pad.size[1] / 2 && position.y + size/2 < pad.position.y + pad.size[1] / 2) && xCheck2) {
      position.y = pad.position.y - pad.size[1] / 2 - size / 2;
      speed.y*= -1;
    } else if ((position.y - size/2 < pad.position.y + pad.size[1] / 2 && position.y - size/2 > pad.position.y - pad.size[1] / 2) && xCheck2) {
      position.y = pad.position.y + pad.size[1] / 2 + size / 2;
      speed.y*= -1;
    } else if ((position.y + size/2 >= pad.position.y - pad.size[1] / 2 && position.y - size/2 <= pad.position.y + pad.size[1] / 2) && xCheck) {
      speed.x*= -1;
    }
  }
}
