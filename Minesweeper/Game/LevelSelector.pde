class LevelSelector {
  PVector position;
  float[] size;

  int levelCols;
  int levelRows;

  boolean beingPressed = false;
  boolean selected;

  LevelSelector(int x, int y, float size0, float size1, int lC, int lR, boolean _selected) {
    position = new PVector(x, y);
    size = new float[2];
    size[0] = size0;
    size[1] = size1;

    levelCols = lC;
    levelRows = lR;

    selected = _selected;
  }

  void show() {
    if (!beingPressed && !selected) {
      drawTile(position.x, position.y, size[0], size[1]);
    } else {
      fill(130);
      stroke(0);
      rect(position.x, position.y, size[0], size[1]);
    }

    if (!beingPressed) {
      fill(selected ? 190 : 90);
      textFont(pixelated);
      textSize(30);
      textAlign(CENTER, CENTER);
      textLeading(20);
      text(levelCols + "\n x" + levelRows, position.x + size[0] / 2, position.y + size[1] / 7 * 3);
    }
  }

  void checkPress() {
    if (mousePressed && mouseX > position.x && mouseX < position.x + size[0] && mouseY > position.y && mouseY < position.y + size[1] && mouseButton == LEFT) {
      beingPressed = true;
    } else if (beingPressed) {
      beingPressed = false;
    }
  }

  void checkRelease() {
    if (mouseX > position.x && mouseX < position.x + size[0] && mouseY > position.y && mouseY < position.y + size[1] && mouseButton == LEFT) {
      for (int i = 0; i < ui.levelSelectors.length; i++) {
        ui.levelSelectors[i].selected = false;
      }

      selected = true;

      cols = levelCols;
      rows = levelRows;
      setGame();
    }
  }
}
