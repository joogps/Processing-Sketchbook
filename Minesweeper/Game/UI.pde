class UI {
  int bombs;
  int time;

  boolean countTime;
  int startingMillis;

  LevelSelector[] levelSelectors;

  UI() {
    bombs = numBombs;

    int[][] lSColsAndRows = {{5, 5}, {10, 10}, {15, 15}, {20, 20}, {25, 25}};
    levelSelectors = new LevelSelector[lSColsAndRows.length];

    for (int i = 0; i < levelSelectors.length; i++)
      levelSelectors[i] = new LevelSelector(width/2+(-2.5*width/11.0)+width/11.0*i, spacing/2.0-width/22.0, width/11.0, width/11.0, lSColsAndRows[i][0], lSColsAndRows[i][1], lSColsAndRows[i][0] == cols && lSColsAndRows[i][1] == rows);
  }

  void show() {
    fill(0);
    rect(20, spacing/4.0, width/5.0, spacing/2.0);

    fill(0);
    rect(width-20-width/5.0, spacing/4.0, width/5.0, spacing/2.0);

    textFont(digital);
    textAlign(CENTER, CENTER);
    autoTextSize("888", width*2/5.0, spacing, 1);

    fill(60, 0, 0);
    text("888", 20+width/10.0, spacing/2.0-textDescent()/2.0);


    fill(255, 0, 0);
    text(nf(constrain(bombs, 0, cols*rows), 3), 20+width/10.0, spacing/2.0-textDescent()/2.0);

    stroke(255);

    textAlign(CENTER, CENTER);
    fill(60, 0, 0);
    text("888", width-20-width/10.0, spacing/2.0-textDescent()/2.0);

    fill(255, 0, 0);
    text(nf(time, 3), width-20-width/10.0, spacing/2.0-textDescent()/2.0);

    for (int i = 0; i < levelSelectors.length; i++)
      levelSelectors[i].show();
  }

  void updateTime() {
    if (countTime) {
      time = (millis()-startingMillis)/1000;
    }
  }

  void updateFlag(boolean flag) {
    bombs+= flag ? -1 : 1;
  }

  void updateSelectors(String update) {
    if (update == "press") {
      for (int i = 0; i < levelSelectors.length; i++)
        levelSelectors[i].checkPress();
    }

    if (update == "release") {
      for (int i = 0; i < levelSelectors.length; i++)
        levelSelectors[i].checkRelease();
    }
  }
}

void autoTextSize(String str, float w, float h, int l) {
  textSize(1);
  float minW = w/textWidth(str);
  float minH = h/(l > 0 ? g.textLeading*(l-1)+(textDescent()+textAscent()) : textDescent()+textAscent());
  textSize(min(minW, minH));
}
