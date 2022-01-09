class Platform {
  PVector pos1;
  PVector pos2;

  PVector origPos1;
  PVector origPos2;

  boolean colliding;

  Platform(float x1, float y1, float x2, float y2) {
    pos1 = new PVector(x1, y1);
    pos2 = new PVector(x2, y2);

    origPos1 = pos1.copy();
    origPos2 = pos2.copy();
  }

  void display() {
    vertex(pos1.x, pos1.y);
    vertex(pos2.x, pos2.y);
    
    pushStyle();
    strokeWeight(3);
    
    stroke(colliding ? color(255, 0, 0) : 0);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    popStyle();
  }

  void update() {
    pos1.x = origPos1.x + player.scroll;
    pos2.x = origPos2.x + player.scroll;
  }
}
