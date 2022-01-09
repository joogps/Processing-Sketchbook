class Brick {
  PVector matrixPos;

  PVector pos;
  float size;

  color brickColor;

  Brick(float x, float y, float s, color c) {
    matrixPos = new PVector(x, y);

    pos = new PVector(matrixPos.x*size, matrixPos.y*size);
    size = s;

    brickColor = c;
  }

  void display() {
    pushStyle();
    fill(brickColor);
    stroke(0);

    rect(pos.x, pos.y, size, size);
    popStyle();
  }

  void update(int matrixX, int matrixY, float posX, float posY) {
    matrixPos.x = matrixX*size;
    matrixPos.y = matrixY*size;

    pos.x = matrixPos.x+posX;
    pos.y = matrixPos.y+posY;
  }

  boolean ground() {
    return pos.y+size*2 >= height;
  }

  boolean limit() {
    return pos.y <= hud.limit;
  }

  boolean leftSide() {
    return pos.x <= hud.spacing;
  }

  boolean rightSide() {
    return pos.x+size*2 >= width-hud.spacing;
  }

  boolean brickGround(Brick b) {
    return pos.x >= b.pos.x && pos.x+size <= b.pos.x+b.size && pos.y+size >= b.pos.y && pos.y+size <= b.pos.y+b.size;
  }

  boolean brickLeftSide(Brick b) {
    return pos.x <= b.pos.x+b.size && pos.x >= b.pos.x && pos.y+size > b.pos.y && pos.y < b.pos.y+b.size;
  }

  boolean brickRightSide(Brick b) {
    return pos.x+size >= b.pos.x && pos.x <= b.pos.x && pos.y+size > b.pos.y && pos.y < b.pos.y+b.size;
  }
}
