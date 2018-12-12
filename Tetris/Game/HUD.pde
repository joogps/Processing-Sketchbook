class HUD {
  int score;
  int lines;
  int level;

  float time;
  float timeOff;

  float spacing;
  float limit;

  int[] indexes;
  int[] rotations;

  Integer holdIndex;
  Integer holdRotations;

  boolean updateHold;

  PVector restartPos;
  PVector pausePos;

  float buttonSize;
  float iconSize;

  boolean pause;
  boolean gameOver;

  HUD(int l) {
    level = l;

    spacing = width/4.81;
    limit = height/8.0125;

    indexes = new int[3];
    rotations = new int[indexes.length];
    for (int i = 0; i < indexes.length; i++) {
      indexes[i] = round(random(0, matrixes.length-1));
      rotations[i] = round(random(0, 3));
    }

    updateHold = true;

    restartPos = new PVector(width-spacing/5*4, spacing/5*13);
    pausePos = new PVector(width-spacing/5*2, spacing/5*13);

    buttonSize = spacing/5;
    iconSize = spacing/5*3/4;

    timeOff = millis();
    time = millis()-timeOff;
  }

  void display() {
    pushStyle();
    fill(100);
    rect(spacing, -1, width-spacing*2-1, height+1);
    line(spacing, limit, width-spacing-1, limit);

    pushMatrix();
    translate(width-spacing/5*4, spacing/5);

    for (int i = 0; i < indexes.length; i++) {
      pushMatrix();
      translate(0, i*spacing/5*4);

      rect(0, 0, spacing/5*3, spacing/5*3);
      drawBrick(matrixes[indexes[i]], rotations[i], colors[indexes[i]], spacing/5*3, spacing/5*3);
      popMatrix();
    }
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    fill(100);

    translate(restartPos.x, restartPos.y);
    rect(0, 0, buttonSize, buttonSize);

    fill(200);
    noStroke();
    translate(iconSize/4, iconSize/4);
    drawRestart(iconSize, iconSize);
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    fill(100);

    translate(pausePos.x, pausePos.y);
    rect(0, 0, buttonSize, buttonSize);

    fill(200);
    noStroke();
    translate(iconSize/4, iconSize/4);

    if (gameOver)
      drawGameOver(iconSize, iconSize);
    else {
      if (pause)
        drawPlay(iconSize, iconSize);
      else
        drawPause(iconSize, iconSize);
    }  
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    translate(spacing/5, spacing/5);

    fill(100);
    rect(0, 0, spacing/5*3, spacing/5*3);
    if (holdIndex != null && holdRotations != null)
      drawBrick(matrixes[holdIndex], holdRotations, colors[holdIndex], spacing/5*3, spacing/5*3);
    popMatrix();
    popStyle();

    pushStyle();
    textAlign(LEFT, TOP);
    fill(50);

    autoTextSize("SCORE", spacing/5*3, spacing/5*2);
    text("SCORE", spacing/5, spacing/5*4.5);

    autoTextSize(nf(score, 5), spacing/5*3, spacing/5*2);
    text(nf(score, 5), spacing/5, spacing/5*5.7);

    autoTextSize("LINES", spacing/5*3, spacing/5*2);
    text("LINES", spacing/5, spacing/5*7);

    autoTextSize(nf(lines, 5), spacing/5*3, spacing/5*2);
    text(nf(lines, 5), spacing/5, spacing/5*8.2);

    autoTextSize("LEVEL", spacing/5*3, spacing/5*2);
    text("LEVEL", spacing/5, spacing/5*9.5);

    autoTextSize(nf(level, 5), spacing/5*3, spacing/5*2);
    text(nf(level, 5), spacing/5, spacing/5*10.7);

    autoTextSize("TIME", spacing/5*3, spacing/5*2);
    text("TIME", spacing/5, spacing/5*12);

    autoTextSize(nf(int(time/1000), 5), spacing/5*3, spacing/5*2);
    text(nf(int(time/1000), 5), spacing/5, spacing/5*13.2);
    popStyle();
  }

  void alert() {
    if (pause || gameOver) {
      pushStyle();
      fill(200);
      rect(spacing*1.25, limit-spacing/2, width-spacing*2.5, spacing);

      fill(75);
      textAlign(CENTER, CENTER);

      if (pause) {
        autoTextSize("PAUSED", (width-spacing*2.5)*0.8, spacing*0.8);
        text("PAUSED", spacing*1.25+(width-spacing*2.5)/2, limit-spacing/2+spacing/2);
      } else if (gameOver) {
        autoTextSize("GAME OVER", (width-spacing*2.5)*0.8, spacing*0.8);
        text("GAME OVER", spacing*1.25+(width-spacing*2.5)/2, limit-spacing/2+spacing/2);
      }
      popStyle();
    }
  }

  void drawBrick(int[][] matrix, int rotations, color c, float _w, float _h) {
    float w = _w/(matrix.length+1);
    float h = _h/(matrix[0].length+1);

    matrix = cleanMatrix(matrix);

    if (rotations > 0) {
      for (int j = 0; j < rotations; j++) {
        int[][] rotatedMatrix = new int[matrix[0].length][matrix.length];

        for (int y = 0; y < matrix.length; y++) {
          for (int x = 0; x < matrix[y].length; x++) {
            rotatedMatrix[x][(matrix.length-1)-y] = matrix[y][x];
          }
        }

        matrix = rotatedMatrix;
      }
    }

    PVector pos = new PVector((_w-matrix[0].length*w)/2, (_h-h*matrix.length)/2);

    pushMatrix();
    translate(pos.x, pos.y);

    pushStyle();
    fill(c);

    for (int y = 0; y < matrix.length; y++) {
      for (int x = 0; x < matrix[y].length; x++) {
        if (matrix[y][x] == 1)
          rect(x*w, y*h, w, h);
      }
    }
    popStyle();
    popMatrix();
  }

  void drawRestart(float w, float h) {
    beginShape();
    vertex(w-w/8, h-h/8*2.75);
    vertex(w-w/8, h-h/8);
    vertex(w/8, h-h/8);
    vertex(w/8, h/8);
    vertex(w-w/8*2.75, h/8);
    vertex(w-w/8*2.75, h/8-h/8);
    vertex(w-w/8*0.75, h/8*1.75);
    vertex(w-w/8*2.75, h/8*2.5+h/8);
    vertex(w-w/8*2.75, h/8*2.5);
    vertex(w/8*2.75, h/8*2.5);
    vertex(w/8*2.75, h-h/8*2.75);
    endShape(CLOSE);
  }

  void drawPause(float w, float h) {
    beginShape();
    vertex(w/8*1.5, h/8);
    vertex(w/8*1.5, h-h/8);
    vertex(w/8*1.5*2, h-h/8);
    vertex(w/8*1.5*2, h/8);
    endShape(CLOSE);

    beginShape();
    vertex(w-w/8*1.5, h/8);
    vertex(w-w/8*1.5, h-h/8);
    vertex(w-w/8*1.5*2, h-h/8);
    vertex(w-w/8*1.5*2, h/8);
    endShape(CLOSE);
  }

  void drawPlay(float w, float h) {
    beginShape();
    vertex(w/5, h/8);
    vertex(w-w/5, h/2);
    vertex(w/5, h-h/8);
    endShape(CLOSE);
  }

  void drawGameOver(float w, float h) {
    beginShape();
    vertex(w/8-w/16, h/8+h/16);
    vertex(w/8, h/8);
    vertex(w/2, h/2-h/16);
    vertex(w-w/8, h/8);
    vertex(w-(w/8-w/16), h/8+h/16);
    vertex(w/2+w/16, h/2);
    vertex(w-(w/8-w/16), h-(h/8+h/16));
    vertex(w-w/8, h-h/8);
    vertex(w/2, h/2+h/16);
    vertex(w/8, h-h/8);
    vertex(w/8-w/16, h-(h/8+h/16));
    vertex(w/2-w/16, h/2);
    endShape(CLOSE);
  }

  void update() {
    if (!gameOver && !pause) {
      if (hud.lines > 10*hud.level)
        setGame(level+1); 

      time+= millis()-timeOff;
    }

    timeOff = millis();
  }

  void keyUpdate() {
    if (mouseX > restartPos.x && mouseX < restartPos.x+buttonSize && mouseY > restartPos.y && mouseY < restartPos.y+buttonSize)
      setGame(level);

    if (!gameOver && mouseX > pausePos.x && mouseX < pausePos.x+buttonSize && mouseY > pausePos.y && mouseY < pausePos.y+buttonSize) {  
      pause = !pause;

      for (int i = 0; i < pieces.size(); i++)
        pieces.get(i).frames = frameCount;
    }
  }

  void updateIndexes() {
    for (int i = 1; i < indexes.length; i++) {
      indexes[i-1] = indexes[i];
      rotations[i-1] = rotations[i];
    }

    indexes[indexes.length-1] = round(random(0, matrixes.length-1));
    rotations[rotations.length-1] = round(random(0, 4));
  }
}

void autoTextSize(String string, float _width, float _height) {
  float size = 1;
  textSize(size);
  while (textWidth(string) < _width && abs(textAscent() - textDescent()) < _height) {
    size+= 0.1;
    textSize(size);
  }
  textSize(size);
}
