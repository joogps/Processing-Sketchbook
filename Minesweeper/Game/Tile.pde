class Tile {
  PVector position;
  float[] size;

  boolean preview = false;
  boolean showing = false;
  boolean isBomb = false;
  boolean bombExploded = false;

  boolean isFlagged = false;

  int bombsNear = 0;

  Tile(int x, int y, float size0, float size1) {
    position = new PVector(x, y);
    size = new float[2];
    size[0] = size0;
    size[1] = size1;
  }

  void show() {
    imageMode(CENTER);
    if (!showing) {
      if (!preview) {
        drawTile(position.x, position.y, size[0], size[1]);

        if (isFlagged) {
          image(flag, position.x + size[0]/2 + 1, position.y + size[1]/2 + 1, size[0] / 7 * 5, size[1] / 7 * 5);
        }
      } else {
        fill(130);
        stroke(0);
        rect(position.x, position.y, size[0] + 1, size[1] + 1);
      }
    } else {
      fill(win ? isBomb ? color(0, 255, 0) : color(130) : bombExploded ? color(255, 0, 0) : color(130));
      stroke(0);
      rect(position.x, position.y, size[0] + 1, size[1] + 1);

      if (isBomb) {
        fill(50);
        image(bomb, position.x + size[0]/2 + 1, position.y + size[1]/2 + 1, size[0] / 7 * 5, size[1] / 7 * 5);

        if (isFlagged && !bombExploded) {
          stroke(255, 0, 0);
          strokeWeight((size[0] + size[1]) / 2 * 0.1);
          line(position.x + size[0] / 6, position.y + size[1] / 6, position.x + size[0] / 6 * 5, position.y + size[1] / 6 * 5);
          line(position.x + size[0] / 6 * 5, position.y + size[1] / 6, position.x + size[0] / 6, position.y + size[1] / 6 * 5);
          strokeWeight(1);
        }
      } else if (bombsNear > 0) {
        colorMode(HSB);
        fill(map(bombsNear, 1, 5, 64, 0), 255, 255);
        textFont(pixelated);
        textSize((size[0] + size[1]) / 2 * 0.8);
        textAlign(CENTER, CENTER);
        text(bombsNear, position.x + size[0]/10 * 5, position.y + size[1]/10 * 4.5);
        colorMode(RGB);
      }
    }
  }

  void checkPress() {
    if (mousePressed && mouseX > position.x  && mouseX < position.x + size[0]  && mouseY > position.y && mouseY < position.y + size[1] && !showing && !gameOver && mouseButton == LEFT) {
      preview = true;
    } else if (preview && !showing) {
      preview = false;
    }
  }

  void checkRelease(int indexX, int indexY) {
    if (mouseX > position.x  && mouseX < position.x + size[0]  && mouseY > position.y && mouseY < position.y + size[1] && !showing) {
      if (!ui.countTime && !gameOver) {
        ui.countTime = true;
        ui.startingMillis = millis();
      }

      if (mouseButton == LEFT) {
        if (!isBomb) {
          if (isFlagged == true) {
            isFlagged = false;
            ui.updateFlag(isFlagged);
          }
          showing = true;

          if (bombsNear == 0) {
            reveal(indexX, indexY);
          }
        } else {
          bombExploded = true;
          gameOver();
        }
      } else {
        if (ui.bombs > 0 || isFlagged) {
          isFlagged = !isFlagged;
          ui.updateFlag(isFlagged);
        }
      }
    }
  }
}
