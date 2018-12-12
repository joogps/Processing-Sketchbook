class River {
  PVector pos;

  float riverWidth;
  float riverHeight;

  int numLogs = round(random(1, 2));
  float logSpeed = random(0.5, 5)*(random(1) < 0.5 ? -1 : 1);

  Log[] logs = new Log[numLogs];

  River(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    riverWidth = _width;
    riverHeight = _height;

    for (int i = 0; i < logs.length; i++) {
      logs[i] = new Log((i*width/numLogs) + width/(numLogs + 1), pos.y, width/(numLogs + 1), riverHeight, logSpeed);
    }
  }

  void display() {
    rectMode(CORNER);

    fill(0, 125, 255);
    rect(pos.x, pos.y, riverWidth, riverHeight);

    for (int i = 0; i < logs.length; i++) {
      logs[i].display();
    }
  }

  void update() {
    int logsKillPlayer = 0;

    for (int i = 0; i < logs.length; i++) {
      logs[i].update();
      logsKillPlayer+= logs[i].killPlayer ? 1 : 0;
    }
    
    if(logsKillPlayer == logs.length){
      player.dead = true;
    }
  }
}
