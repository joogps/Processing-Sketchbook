class HUD {
  float score;
  float highScore;

  int framesOff = 0;

  float startX = 0;

  void display() {
    textFont(hudFont);
    textAlign(RIGHT, TOP);

    fill(!dinosaur.dead && score % 100 < 30 && score >= 100 ? map(round(map((frameCount-framesOff)%25, 0, 25, 0, 1)), 0, 1, 83, 255) : 83);
    text(nf(round(score), 5), width-10, 10);

    if (highScore != 0) {
      fill(121);
      text("HI " + nf(round(highScore), 5), width-10-textWidth(nf(round(score), 5) + " "), 10);
    }

    if (dinosaur.dead) {
      fill(83);

      textAlign(CENTER, CENTER);
      text("G A M E  O V E R", width/2, height/2.6);

      pushStyle();
      imageMode(CENTER);
      image(restartSprite, width/2, height/1.8, restartSprite.width*1.5, restartSprite.height*1.5);
      popStyle();
    }

    noStroke();
    fill(255);
    rect(dinosaur.pos.x+dinosaur.w*1.25+startX, 0, width, height);
  }

  void update() {
    if (dinosaur.move && !dinosaur.dead) {
      score+= 0.15;

      if (score >= 100 && score % 100 < 30) {
        hudScoreSound.play();

        if (!hudScoreSound.isPlaying())
          framesOff = frameCount;
      } else if (score % 100 > 30)
        hudScoreSound.rewind();
    }

    if (dinosaur.move)
      startX+=15;
  }

  void restart() {
    if (dinosaur.dead && mouseX > width/2-restartSprite.width*1.5/2 && mouseX < width/2+restartSprite.width*1.5/2 && mouseY > height/1.8-restartSprite.height*1.5/2 && mouseY < height/1.8+restartSprite.height*1.5/2)
      setGame();
  }
}
