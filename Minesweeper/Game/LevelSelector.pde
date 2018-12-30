class LevelSelector {
  PVector position;
  float w;
  float h;

  int levelCols;
  int levelRows;

  boolean beingPressed = false;
  boolean selected;

  LevelSelector(float x, float y, float _w, float _h, int lC, int lR, boolean _selected) {
    position = new PVector(x, y);
    w = _w;
    h = _h;

    levelCols = lC;
    levelRows = lR;

    selected = _selected;
  }

  void show() {
    if (!beingPressed && !selected)
      drawTile(position.x, position.y, w, h);
    else {
      fill(130);
      stroke(0);
      rect(position.x, position.y, w, h);
    }

    if (!beingPressed) {
      fill(selected ? 190 : 90);
      textFont(pixelated);
      textAlign(CENTER, CENTER);
      autoTextSize(levelCols+"\n x"+levelRows, w*2/3.0, h*2/3.0, 2);
      text(levelCols+"\n x"+levelRows, position.x+w/2.0, position.y+h/2.0);
    }
  }

  void checkPress() {
    if (mousePressed && mouseX > position.x && mouseX < position.x + w && mouseY > position.y && mouseY < position.y + h && mouseButton == LEFT) {
      beingPressed = true;
    } else if (beingPressed) {
      beingPressed = false;
    }
  }

  void checkRelease() {
    if (mouseX > position.x && mouseX < position.x + w && mouseY > position.y && mouseY < position.y + h && mouseButton == LEFT) {
      for (int i = 0; i < ui.levelSelectors.length; i++)
        ui.levelSelectors[i].selected = false;


      selected = true;

      cols = levelCols;
      rows = levelRows;
      setGame();
    }
  }
}
