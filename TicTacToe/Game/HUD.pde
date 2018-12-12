class HUD {
  int timer;
  int timerOffset;

  boolean playing;

  float timerAnimation;

  float spacing = 100;

  float playerAnimation;
  String currentPlayer;

  boolean gameOver;
  float gameOverAnimation;

  String winner;

  float gridAnimation;

  PVector gameOverLinePos1;
  PVector gameOverLinePos2;
  PVector gameOverLineStart;
  float gameOverLineAnimation;

  HUD() {
    timer = millis();
    timerOffset = millis();

    currentPlayer = random(1) < 0.5 ? "x" : "o";
  }

  void display() {
    gridAnimation = lerp(gridAnimation, 1, 0.1);

    noStroke();
    fill(255-(gridAnimation*(255-150)));
    rect(0, spacing, width, height-spacing);

    stroke(255);
    strokeWeight(3);
    strokeCap(SQUARE);

    for (int x = 1; x < grid.length; x++)
      line(x*(width/float(grid.length)), spacing+(height-spacing)/2-((height-spacing)/2)*gridAnimation, x*(width/float(grid.length)), spacing+(height-spacing)/2+((height-spacing)/2)*gridAnimation);

    for (int y = 1; y < grid[0].length; y++)
      line(width/2-(width/2)*gridAnimation, spacing+y*((height-spacing)/float(grid[0].length)), width/2+(width/2)*gridAnimation, spacing+y*((height-spacing)/float(grid[0].length)));

    noStroke();
    fill(255);
    rect(0, 0, width, spacing);

    fill(255-(gridAnimation*(255-150)));
    textFont(timerFont);
    textAlign(LEFT, TOP);
    autoTextSize(str(timer/1000), width/3, spacing/2);
    text(timer/1000, 15, spacing/2-(textAscent()-textDescent())/2-textDescent());

    if (gridAnimation > 0.8)
      timerAnimation = lerp(timerAnimation, 1, 0.1);

    fill(255);
    rect(15, 0, textWidth(str(timer/1000))*(1-timerAnimation), spacing);

    if (!gameOver) {
      playerAnimation = lerp(playerAnimation, 1, 0.075);

      if (currentPlayer == "x")
        drawX(width-spacing*0.75-10, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, playerAnimation);
      else if (currentPlayer == "o")
        drawO(width-spacing*0.75-10, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, playerAnimation);
    } else {
      gameOverAnimation = lerp(gameOverAnimation, 1, 0.1);
      textAlign(RIGHT, TOP);

      if (winner == null) {
        fill(255-(gameOverAnimation*(255-130)));

        autoTextSize("DRAW", width*0.75-textWidth(str(timer/1000))-spacing*0.75*1.5, spacing/2);
        text("DRAW", width-10, spacing/2-(textAscent()-textDescent())/2-textDescent());

        fill(255);
        noStroke();
        rect(width-10, 0, -textWidth("DRAW")*(1-gameOverAnimation), spacing);

        drawO(width-textWidth("DRAW")-spacing*0.75, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, gameOverAnimation);
        drawX(width-textWidth("DRAW")-spacing*0.75*1.5, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, gameOverAnimation);
      } else {
        if (winner == "x") {
          fill(255-(gameOverAnimation*(255-130)));

          autoTextSize("WINS", width*0.75-textWidth(str(timer/1000))-spacing*0.75, spacing/2);
          text("WINS", width-10, spacing/2-(textAscent()-textDescent())/2-textDescent());

          fill(255);
          noStroke();
          rect(width-10, 0, -textWidth("WINS")*(1-gameOverAnimation), spacing);

          drawX(width-10-textWidth("WINS")-spacing*0.75, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, gameOverAnimation);
        } else if (winner == "o") {
          fill(255-(gameOverAnimation*(255-130)));

          autoTextSize("WINS", width*0.75-textWidth(str(timer/1000))-spacing*0.75, spacing/2);
          text("WINS", width-10, spacing/2-(textAscent()-textDescent())/2-textDescent());

          fill(255);
          noStroke();
          rect(width-10, 0, -textWidth("WINS")*(1-gameOverAnimation), spacing);

          drawO(width-10-textWidth("WINS")-spacing*0.75, spacing/2-spacing*0.75/2, spacing*0.75, spacing*0.75, gameOverAnimation);
        }
      }
    }
  }

  void displayGameOverLine() {
    if (gameOver && winner != null) {
      gameOverLineAnimation = lerp(gameOverLineAnimation, 1, 0.1);

      float a1 = atan2(gameOverLinePos1.y-gameOverLineStart.y, gameOverLinePos1.x-gameOverLineStart.x);
      float a2 = atan2(gameOverLinePos2.y-gameOverLineStart.y, gameOverLinePos2.x-gameOverLineStart.x);

      stroke(255);
      strokeWeight(10);
      strokeCap(ROUND);

      line(gameOverLineStart.x+cos(a1)*gameOverLineAnimation*dist(gameOverLinePos1.x, gameOverLinePos1.y, gameOverLineStart.x, gameOverLineStart.y), gameOverLineStart.y+sin(a1)*gameOverLineAnimation*dist(gameOverLinePos1.x, gameOverLinePos1.y, gameOverLineStart.x, gameOverLineStart.y), gameOverLineStart.x+cos(a2)*gameOverLineAnimation*dist(gameOverLinePos2.x, gameOverLinePos2.y, gameOverLineStart.x, gameOverLineStart.y), gameOverLineStart.y+sin(a2)*gameOverLineAnimation*dist(gameOverLinePos2.x, gameOverLinePos2.y, gameOverLineStart.x, gameOverLineStart.y));
    }
  }

  void update() {
    if (!playing)
      timerOffset = millis();

    if (!gameOver)
      timer = millis()-timerOffset;
  }

  void updateTiles() {
    playing = true;

    if (!gameOver) {
      if (gridAnimation > 0.9) {
        for (int x = 0; x < grid.length; x++) {
          for (int y = 0; y < grid[x].length; y++) {
            if (grid[x][y].setPlayer(currentPlayer)) {
              if (currentPlayer == "x")
                currentPlayer = "o";
              else if (currentPlayer == "o")
                currentPlayer = "x";

              playerAnimation = 0;
            }

            checkHorizontal();
            checkVertical();

            checkDiagonalLeftToRight();
            checkDiagonalRightToLeft();

            if (gameOver)
              break;
          }
          if (gameOver)
            break;
        }
      }
    } else
      setGame();
  }
}

void autoTextSize(String string, float _width, float _height) {
  float size = 1;
  textSize(size);
  while (textWidth(string) < _width && textAscent()-textDescent() < _height) {
    size+= 0.1;
    textSize(size);
  }
  textSize(size);
}
