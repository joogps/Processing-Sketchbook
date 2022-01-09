class HUD {
  int score;

  int level = 1;
  int[] levelGoals = {10, 30, 60};

  boolean transition;

  int levelChangeCurrent;
  float levelChangeFade;
  float levelChangeSwap;
  float levelChangeShowChanges;
  boolean levelChangeFadeOut;

  void display() {
    textFont(hudFont);
    textSize(40);

    fill(player.superShot*255);
    rectMode(CORNERS);
    rect(0, 0, textDescent()*1.75+textWidth(nf(score, str(levelGoals[level-1]).length())+" = "+levelGoals[level-1]), textDescent()+textAscent(), 0, 0, 10, 0);

    fill((1-player.superShot)*255);

    textAlign(LEFT, TOP);
    text(nf(score, str(levelGoals[level-1]).length())+" | "+levelGoals[level-1], textDescent(), 0);
  }

  void levelChange() {
    if (score >= levelGoals[level-1] || transition) {
      if (!transition)
        levelChangeCurrent = level;
      transition = true;

      fill((1-player.superShot)*255, levelChangeFade*255);
      rect(0, 0, width, height*2);

      pushMatrix();
      translate(0, -levelChangeShowChanges*height);

      fill(player.superShot*2555, levelChangeFade*255);
      textAlign(CENTER, CENTER);

      textSize(30);
      text("LEVEL", width/2, height/4-textDescent());

      textSize(160);
      for (int i = 1; i <= levelGoals.length; i++)
        text(i, width/2*(i-levelChangeCurrent+1-levelChangeSwap), height/2-textDescent()+height/4);

      translate(0, height);
      if (levelChangeCurrent+1 == 2)
        secondLevelChanges(levelChangeFade*255);
      popMatrix();

      if (!levelChangeFadeOut)
        levelChangeFade = lerp(levelChangeFade, 1, 0.05);
      else {
        levelChangeFade = lerp(levelChangeFade, 0, 0.05);
        if (levelChangeFade < 0.05) {
          levelChangeSwap = 0;
          levelChangeShowChanges = 0;
          levelChangeFadeOut = false;
          transition = false;
        }
      }

      if (levelChangeFade > 0.99)
        levelChangeSwap = lerp(levelChangeSwap, 1, 0.05);

      if (levelChangeSwap > 0.999)
        levelChangeShowChanges = lerp(levelChangeShowChanges, 1, 0.05);

      if (levelChangeShowChanges > 0.99999) {
        if (!levelChangeFadeOut) {
          level++;
          score = 0;
          setGame();
        }
        levelChangeFadeOut = true;
      }
    }

    println(level);
  }

  void secondLevelChanges(float alpha) {
    stroke(0, alpha);
    line(width/2, height/10, width/2, height*9/10);

    textSize(20);
    textAlign(CENTER, CENTER);

    fill(0, alpha);
    text("HOLD FOR SUPER SHOT", width*3/4, height/5);
    text("STRONGER ENEMIES", width/4, height/5);

    noFill();
    rectMode(CENTER);
    rect(width*3/4, height*3/5+textWidth("SUPER SHOT")/3, textWidth("SUPER SHOT"), textWidth("SUPER SHOT"));
    line(width*3/4, height*3/5-textWidth("SUPER SHOT")/6, width*3/4, height*3/5-textWidth("SUPER SHOT")/6-textWidth("SUPER SHOT")/3*2*abs(sin(frameCount/240.0*TWO_PI)));

    ellipse(width/4, height*3/5, textWidth("STRONGER ENEMIES"), textWidth("STRONGER ENEMIES"));
    for (int i = 0; i < 3; i++) {
      stroke(0, abs(sin((frameCount+i*15.0)/240.0*TWO_PI))*alpha);
      ellipse(width/4, height*3/5, textWidth("STRONGER ENEMIES")*(0.8-i*0.2), textWidth("STRONGER ENEMIES")*(0.8-i*0.2));
    }
  }

  void score() {
    score++;
  }
}
