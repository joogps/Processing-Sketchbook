class Goal {
  PVector pos;
  float goalWidth;
  float goalHeight;

  Goal(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    goalWidth = _width;
    goalHeight = _height;
  }

  void display() {
    rectMode(CENTER);

    fill(80);
    rect(pos.x, pos.y, goalWidth, goalHeight);
    
    fill(60);
    rect(pos.x, pos.y, goalWidth - goalWidth/5, goalHeight - goalHeight/5);
  }

  void update() {
    if (player.pos.x - player.playerWidth/2 >= pos.x - goalWidth/2 && player.pos.x + player.playerWidth/2 <= pos.x + goalWidth/2 && player.pos.y - player.playerHeight/2 >= pos.y - goalHeight/2 && player.pos.y + player.playerHeight/2 <= pos.y + goalHeight/2) {
      player.reachedGoal = true;
    }
  }
}
