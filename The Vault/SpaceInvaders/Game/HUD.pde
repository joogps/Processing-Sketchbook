class HUD {
  int time = millis();
  int startingMillis = millis();

  int attempts;
  int points;

  boolean start;

  boolean win;
  boolean gameOver;

  float size = 130;
  float limit = height-165;

  HUD() {
    deathSound.rewind();

    startSound.rewind(); 
    startSound.play();
  }

  void display() {
    if (win)
      win();
    else if (gameOver)
      gameOver();
    else
      score();
  }

  void update() {
    if (!win && !gameOver)
      time = millis()-startingMillis;

    if (time > startSound.length()*1.5)
      start = true;
  }

  void restart() {
    if (win || gameOver)
      setGame();
  }

  void score() {
    fill(255);

    textSize(40);
    textAlign(LEFT, TOP);
    text(nf(round(time/1000/60), 2)+":"+nf((time/1000) % 60, 2), 8, 10);
    textSize(44);
    text(nf(attempts, 4), 8, 10+40);
    text(nf(points, 4), 8, 10+43*2);

    textSize(65);
    textLeading(60);
    textAlign(LEFT, BOTTOM);
    text("Spa\nce\nInv\nad\ners", 8, height-10);

    pushMatrix();
    translate(13, height/2.25);
    rotate(-PI/2);
    scale(0.1);
    image(monster, 0, 0);
    popMatrix();

    strokeWeight(2);
    stroke(255);

    line(size, 0, size, height);
    line(size, limit, width, limit);
  }

  void win() {
    fill(255);

    textSize(70);
    textAlign(CENTER);
    text("CONGRATULATIONS", width/2, height/3);

    text(nf(round(time/1000/60), 2)+":"+nf((time/1000) % 60, 2), width/2, height/1.8);
    text(attempts, width/2, height/1.8+85);
    text(points, width/2, height/1.8+85*2);
  }

  void gameOver() {
    fill(255);

    textSize(70);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/3);

    text(nf(round(time/1000/60), 2)+":"+nf((time/1000) % 60, 2), width/2, height/1.8);
    text(attempts, width/2, height/1.8+85);
    text(points, width/2, height/1.8+85*2);
  }
}
