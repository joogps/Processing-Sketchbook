class Piece {
  PVector pos;

  float size;

  int index;

  boolean left;
  boolean right;
  boolean fall;

  boolean ground;

  color pieceColor;

  int matrixIndex;
  int[][] matrix;

  int timesRotated;

  PVector projectPos; 
  boolean hardDrop;

  float frames;
  float currFrame;

  Brick[][] bricks;

  Piece(int mIdx, int rotations, int idx) {
    matrixIndex = mIdx;
    index = idx;

    matrix = matrixes[mIdx];
    pieceColor = colors[mIdx];

    size = (width/24.05+height/32.05)/2;

    int[][] posMatrix = matrix;
    for (int i = 0; i < rotations; i++) {
      int[][] rotatedPosMatrix = new int[posMatrix[0].length][posMatrix.length];

      for (int y = 0; y < posMatrix.length; y++) {
        for (int x = 0; x < posMatrix[y].length; x++) {
          rotatedPosMatrix[x][(posMatrix.length-1)-y] = posMatrix[y][x];
        }
      }

      posMatrix = rotatedPosMatrix;
    }

    int minY = posMatrix.length;

    for (int y = 0; y < posMatrix.length; y++) {
      for (int x = 0; x < posMatrix[y].length; x++) {
        if (posMatrix[y][x] == 1 && y < minY)
          minY = y;
      }
    }

    pos = new PVector(hud.spacing+round((width-hud.spacing*2)/2/size-posMatrix[0].length/2)*size, -minY*size);

    left = true;
    right = true;

    fall = true;

    frames = frameCount;
    currFrame = frames;

    projectPos = pos.copy();

    bricks = new Brick[matrix.length][matrix[0].length];

    for (int _y = 0; _y < matrix.length; _y++) {
      for (int _x = 0; _x < matrix[_y].length; _x++) {
        if (matrix[_y][_x] == 1)
          bricks[_y][_x] = new Brick(_x, _y, size, pieceColor);
      }
    }

    for (int i = 0; i < rotations; i++)
      rotate("right");
  }

  void display() {
    if (fall) {
      pushMatrix();
      translate(projectPos.x, projectPos.y);

      for (int y = 0; y < matrix.length; y++) {
        for (int x = 0; x < matrix[y].length; x++) {
          if (matrix[y][x] == 1) {
            pushStyle();
            fill(pieceColor, 45);
            stroke(pieceColor);

            rect(x*size, y*size, size, size);
            popStyle();
          }
        }
      }
      popMatrix();
    }

    for (int y = 0; y < bricks.length; y++) {
      for (int x = 0; x < bricks[y].length; x++) {
        if (bricks[y][x] != null)
          bricks[y][x].display();
      }
    }
  }

  void update() {
    if (!hud.gameOver && !hud.pause) {
      collidePiece();
      project();

      if (!hud.gameOver && !hud.pause) {
        if (fall) {
          for (int y = 0; y < bricks.length; y++) {
            for (int x = 0; x < bricks[0].length; x++) {
              if (bricks[y][x] != null)
                bricks[y][x].update(x, y, pos.x, pos.y);
            }
          }

          if (frameCount-frames > 0 && currFrame != frameCount) {
            if (keyPressed && key == 's' || key == 'S') {
              if (frameCount%(hud.level < 5 ? (5/hud.level) : 1) == 0) {
                if (!ground) {
                  pos.y+= size;
                  hud.score+= hud.level;
                } else
                  recreate();
              }
            } else {
              if (frameCount%(hud.level < 30 ? (30/hud.level) : 1) == 0) {
                if (!ground)
                  pos.y+= size;
                else
                  recreate();
              }
            }

            currFrame = frameCount;
          }
        }
      }
      if (hardDrop)
        recreate();
    }
  }

  void project() {
    if (fall && !hud.gameOver) {
      PVector pPos = pos.copy();

      if (fall) {
        boolean stop = false;
        while (!stop) {
          pPos.y+= size;

          for (int y = 0; y < matrix.length; y++) {
            for (int x = 0; x < matrix[y].length; x++) {
              for (int i = 0; i < pieces.size(); i++) {
                if (pieces.get(i) != this) {
                  for (int bY = 0; bY < pieces.get(i).bricks.length; bY++) {
                    for (int bX = 0; bX < pieces.get(i).bricks[0].length; bX++) {
                      Brick b = pieces.get(i).bricks[bY][bX];
                      if (b != null && matrix[y][x] == 1 && pPos.x+x*size >= b.pos.x && pPos.x+x*size+size <= b.pos.x+b.size && pPos.y+y*size >= b.pos.y && pPos.y+y*size+size <= b.pos.y+size) {
                        stop = true;
                        break;
                      }
                    }
                  }
                }

                if (matrix[y][x] == 1 && pPos.y+y*size+size >= height) {
                  stop = true;
                  break;
                }
              }
            }
          }
        }
      }

      pPos.y-= size;
      projectPos = pPos;
    }
  }

  void collidePiece() {
    boolean groundColliding = false;
    boolean leftColliding = false;
    boolean rightColliding = false;

    for (int y = 0; y < bricks.length; y++) {
      for (int x = 0; x < bricks[y].length; x++) {
        if (bricks[y][x] != null) {
          if (fall) {
            bricks[y][x].update(x, y, pos.x, pos.y);

            groundColliding = bricks[y][x].ground() || groundColliding;
            leftColliding = bricks[y][x].leftSide() || leftColliding;
            rightColliding = bricks[y][x].rightSide() || rightColliding;

            for (int i = 0; i < pieces.size(); i++) {
              groundColliding = collideBrick(pieces.get(i), "ground") || groundColliding;
              leftColliding = collideBrick(pieces.get(i), "left") || leftColliding;
              rightColliding = collideBrick(pieces.get(i), "right") || rightColliding;
            }
          }

          if (ground && bricks[y][x].limit())
            hud.gameOver = true;
        }
      }
    }

    ground = groundColliding;
    left = !leftColliding;
    right = !rightColliding;
  }

  boolean collideBrick(Piece p, String type) {
    if (p != this) {
      for (int y = 0; y < bricks.length; y++) {
        for (int x = 0; x < bricks[y].length; x++) {
          for (int pY = 0; pY < p.bricks.length; pY++) {
            for (int pX = 0; pX < p.bricks[pY].length; pX++) {
              if (fall) {
                if (type == "ground" && bricks[y][x] != null && p.bricks[pY][pX] != null && bricks[y][x].brickGround(p.bricks[pY][pX]))
                  return true;

                if (type == "left" && bricks[y][x] != null && p.bricks[pY][pX] != null && bricks[y][x].brickLeftSide(p.bricks[pY][pX]))
                  return true;

                if (type == "right" && bricks[y][x] != null && p.bricks[pY][pX] != null && bricks[y][x].brickRightSide(p.bricks[pY][pX]))
                  return true;
              }
            }
          }
        }
      }
    }

    return false;
  }

  void keyUpdate() {
    if (fall && !hud.gameOver && !hud.pause) {
      if (key != CODED)
        move();
      else {
        if (keyCode == RIGHT)
          rotate("right");
        else if (keyCode == LEFT)
          rotate("left");
        else {
          hold();
          hardDrop();
        }
      }
    }
  }

  void move() {
    if (left && (key == 'a' || key == 'A'))
      pos.x-= size;

    if (right && (key == 'd' || key == 'D'))
      pos.x+= size;
  }

  void rotate(String direction) {
    if (fall && direction != null && !hardDrop) {
      int[][] rotatedMatrix = new int[matrix[0].length][matrix.length];
      Brick[][] rotatedBricks = new Brick[bricks[0].length][bricks.length];

      for (int y = 0; y < matrix.length; y++) {
        for (int x = 0; x < matrix[y].length; x++) {
          if (direction == "right") {
            rotatedMatrix[x][(matrix.length-1)-y] = matrix[y][x];
            rotatedBricks[x][(bricks.length-1)-y] = bricks[y][x];
          } else if (direction == "left") {
            rotatedMatrix[(matrix[y].length-1)-x][y] = matrix[y][x];
            rotatedBricks[(bricks[y].length-1)-x][y] = bricks[y][x];
          }
        }
      }

      if (pos.x+size*rotatedMatrix[0].length > width-hud.spacing) {
        while (pos.x+size*rotatedMatrix[0].length > width-hud.spacing)
          pos.x-= size;
      }

      if (pos.x < hud.spacing) {
        while (pos.x < hud.spacing)
          pos.x+= size;
      }

      if (pos.y+size*rotatedMatrix.length > height) {
        while (pos.y+size*rotatedMatrix.length > height)
          pos.y-= size;
      }

      matrix = rotatedMatrix;
      bricks = rotatedBricks;

      if (direction == "right")
        timesRotated++;
      else if (direction == "left")
        timesRotated--;

      timesRotated = timesRotated > 0 ? abs(timesRotated)%4 : 4-abs(timesRotated)%4;
    }
  }

  void hold() {
    if (keyCode == CONTROL && hud.updateHold) {
      pieces.remove(index);
      pieces.add(new Piece(hud.holdIndex == null ? hud.indexes[0] : hud.holdIndex, hud.holdRotations == null ? hud.rotations[0] : hud.holdRotations, pieces.size()));

      if (hud.holdIndex == null && hud.holdRotations != null)
        hud.updateIndexes();

      hud.holdIndex = matrixIndex;
      hud.holdRotations = timesRotated;

      hud.updateHold = false;
    }
  }

  void hardDrop() {
    if (keyCode == DOWN) {
      project();

      hud.score+= round(abs(projectPos.y-pos.y)/size)*2*hud.level;
      pos = projectPos;
      hardDrop = true;
    }
  }

  void recreate() {
    if (fall) {
      fall = false;
      pieces.add(new Piece(hud.indexes[0], hud.rotations[0], pieces.size()));

      hud.updateIndexes();
      hud.updateHold = true;
    }
  }
}

int[][] cleanMatrix (int[][] matrix) {
  ArrayList<int[]> newMatrix =  new ArrayList<int[]>();
  for (int y = 0; y < matrix.length; y++) {
    boolean keep = false;
    for (int x = 0; x < matrix[0].length; x++) {
      keep = matrix[y][x] == 1 || keep;
    }

    if (keep)
      newMatrix.add(matrix[y]);
  }

  int[][] returnMatrix = new int[newMatrix.size()][matrix[0].length];
  for (int y = 0; y < newMatrix.size(); y++) {
    returnMatrix[y] = newMatrix.get(y);
  }

  return returnMatrix;
}

void lineup() {
  if (pieces.size() > 0) {
    int[] lineup = new int[int(height/pieces.get(0).size)];
    for (int i = 0; i < pieces.size(); i++) {
      if (!pieces.get(i).fall) {
        for (int y = 0; y < pieces.get(i).bricks.length; y++) {
          for (int x = 0; x < pieces.get(i).bricks[y].length; x++) {
            if (pieces.get(i).bricks[y][x] != null)
              lineup[int(pieces.get(i).bricks[y][x].pos.y/pieces.get(i).bricks[y][x].size)]++;
          }
        }
      }
    }

    ArrayList<Float> yPos = new ArrayList<Float>();
    for (int i = 0; i < lineup.length; i++) {
      if (lineup[i] >= round((width-hud.spacing*2)/pieces.get(0).size))
        yPos.add(float(i*20));
    }

    if (yPos.size() >= 4)
      hud.score+= 1200*hud.level;
    else if (yPos.size() >= 3)
      hud.score+= 300*hud.level;
    else if (yPos.size() >= 2)
      hud.score+= 100*hud.level;
    else if (yPos.size() >= 1)
      hud.score+= 40*hud.level;

    hud.lines+= yPos.size();

    for (int i = 0; i < pieces.size(); i++) {
      for (int y = 0; y < pieces.get(i).bricks.length; y++) {
        for (int x = 0; x < pieces.get(i).bricks[y].length; x++) {
          for (int l = 0; l < yPos.size(); l++) {
            if (pieces.get(i).bricks[y][x] != null) {
              if (pieces.get(i).bricks[y][x].pos.y == yPos.get(l))
                pieces.get(i).bricks[y][x] = null;
              else if (pieces.get(i).bricks[y][x].pos.y < yPos.get(l))
                pieces.get(i).bricks[y][x].pos.y+= pieces.get(i).bricks[y][x].size;
            } else
              break;
          }
        }
      }
    }
  }
}
