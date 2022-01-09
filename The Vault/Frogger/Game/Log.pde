class Log {
  PVector pos;

  float logWidth;
  float logHeight;

  float speed;

  boolean killPlayer;

  Log(float x, float y, float _width, float _height, float _speed) {
    pos = new PVector(x, y);

    logWidth = _width;
    logHeight = _height;
    speed = _speed;
  }

  void display() {
    rectMode(CORNER);

    fill(119, 51, 25);
    rect(pos.x, pos.y, logWidth, logHeight);
    
    fill(100, 40, 15);
    rect(pos.x + logWidth/10, pos.y + logHeight/10, logWidth - logWidth/5, logHeight - logHeight/5);
  }

  void update() {
    float newSpeed = (speed + map(noise(frameCount), 0, 1, -speed/2, speed/4)) * player.slowdown;
    pos.x+= newSpeed;

    if (speed > 0 && pos.x > width + random(logWidth)) {
      pos.x = -logWidth;
    }

    if (speed < 0 && pos.x + logWidth < 0 - random(logWidth)) {
      pos.x = width;
    }

    if (player.pos.x - player.playerWidth/2 > pos.x && player.pos.x + player.playerWidth/2 < pos.x + logWidth && player.pos.y - player.playerHeight/2 >= pos.y && player.pos.y + player.playerHeight/2 <= pos.y + logHeight) {
      killPlayer = false;
      if (player.pos.x + player.playerWidth <= width && player.pos.x - player.playerWidth >= 0 && !player.dead) {
        player.pos.x+= newSpeed;
      }
    } else if (player.pos.y - player.playerHeight/2 >= pos.y && player.pos.y + player.playerHeight/2 <= pos.y + logHeight) {
      killPlayer = true;
    } else {
      killPlayer = false;
    }
  }
}
