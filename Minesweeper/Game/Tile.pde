class Tile {
  PVector position;
  float w;
  float h;

  boolean preview = false;
  boolean showing = false;
  boolean isBomb = false;
  boolean bombExploded = false;

  boolean isFlagged = false;

  int bombsNear = 0;

  Tile(float x, float y, float _w, float _h) {
    position = new PVector(x, y);
    w = _w;
    h = _h;
  }

  void show() {
    imageMode(CENTER);
    if (!showing) {
      if (!preview) {
        drawTile(position.x, position.y, w, h);

        if (isFlagged) {
          image(flag, position.x+w/2.0+1, position.y+h/2.0+1, w/7*5.0, h/7*5.0);
        }
      } else {
        fill(130);
        stroke(0);
        rect(position.x, position.y, w+1, h+1);
      }
    } else {
      fill(win ? isBomb ? color(0, 255, 0) : color(130) : bombExploded ? color(255, 0, 0) : color(130));
      stroke(0);
      rect(position.x, position.y, w+1, h+1);

      if (isBomb) {
        fill(50);
        image(bomb, position.x+w/2.0+1, position.y+h/2.0+1, w*5/7.0, h*5/7.0);

        if (isFlagged && !bombExploded) {
          stroke(255, 0, 0);
          strokeWeight((w+h)*0.05);
          line(position.x+w/6.0, position.y+h/6.0, position.x+w*5/6.0, position.y+h*5/6.0);
          line(position.x+w*5/6.0, position.y+h/6.0, position.x+w/6.0, position.y+h*5/6.0);
          strokeWeight(1);
        }
      } else if (bombsNear > 0) {
        colorMode(HSB);
        fill(map(bombsNear, 1, 5, 64, 0), 255, 255);
        textFont(pixelated);
        textSize((w+h)*0.3);
        textAlign(CENTER, CENTER);
        text(bombsNear, position.x+w/2.0, position.y+h*4.5/10.0+textDescent()/2.0);
        colorMode(RGB);
      }
    }
  }

  void checkPress() {
    if (mousePressed && mouseX > position.x  && mouseX < position.x + w  && mouseY > position.y && mouseY < position.y + h && !showing && !gameOver && mouseButton == LEFT) {
      preview = true;
    } else if (preview && !showing) {
      preview = false;
    }
  }

  void checkRelease(int indexX, int indexY) {
    if (mouseX > position.x  && mouseX < position.x + w  && mouseY > position.y && mouseY < position.y + h && !showing) {
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
          gameOverGame();
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
