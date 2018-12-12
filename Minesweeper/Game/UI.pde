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
    
    for(int i = 0; i < levelSelectors.length; i++){
      levelSelectors[i] = new LevelSelector(int(width / 2 + (-2.5*75) + 75 * i), 35, 75, 75, lSColsAndRows[i][0], lSColsAndRows[i][1], lSColsAndRows[i][0] == cols && lSColsAndRows[i][1] == rows);
    }
  }

  void show() {
    fill(0);
    rect(20, 35, 125, 75);

    fill(0);
    rect(width - 20 - 125, 35, 125, 75);

    textFont(digital);
    textSize(75);

    textAlign(LEFT, TOP);
    fill(60, 0, 0);
    text("888", 32, 32);


    fill(255, 0, 0);
    text(nf(constrain(bombs, 0, cols * rows), 3), 32, 32);

    stroke(255);

    textAlign(RIGHT, TOP);
    fill(60, 0, 0);
    text("888", width - 32, 32);

    fill(255, 0, 0);
    text(nf(time, 3), width - 32, 32);

    for (int i = 0; i < levelSelectors.length; i++) {
      levelSelectors[i].show();
    }
  }

  void updateTime() {
    if (countTime) {
      time = (millis() - startingMillis) / 1000;
    }
  }

  void updateFlag(boolean flag) {
    bombs+= flag ? -1 : 1;
  }

  void updateSelectors(String update) {
    if (update == "press") {
      for (int i = 0; i < levelSelectors.length; i++) {
        levelSelectors[i].checkPress();
      }
    }

    if (update == "release") {
      for (int i = 0; i < levelSelectors.length; i++) {
        levelSelectors[i].checkRelease();
      }
    }
  }
}
