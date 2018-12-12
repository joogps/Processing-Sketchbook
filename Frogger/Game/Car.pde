class Car {
  PVector pos;

  float carWidth;
  float carHeight;

  float speed;

  Car(float x, float y, float _width, float _height, float _speed) {
    pos = new PVector(x, y);

    carWidth = _width;
    carHeight = _height;
    speed = _speed;
  }

  void display() {
    rectMode(CORNER);
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    fill(50);
    rect(0, 0, carWidth, carHeight);

    fill(25);
    rect(speed > 0 ? carWidth - player.playerWidth/2 : 0, 0, (player.playerWidth/2), carHeight);
    popMatrix();
  }

  void update() {
    pos.x+= speed * player.slowdown;

    if (speed > 0 && pos.x > width) {
      pos.x = -carWidth;
    }

    if (speed < 0 && pos.x + carWidth < 0) {
      pos.x = width;
    }

    if (player.pos.x + player.playerWidth/2 > pos.x && player.pos.x - player.playerWidth/2 < pos.x + carWidth && player.pos.y + player.playerHeight/2 > pos.y && player.pos.y - player.playerHeight/2 < pos.y + carHeight) {
      player.dead = true;
    }
  }
}
