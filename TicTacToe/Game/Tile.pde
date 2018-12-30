class Tile {
  PVector pos;

  float w;
  float h;

  String player;

  float animation;

  Tile(float x, float y, float _w, float _h) {
    pos = new PVector(x*_w, spacing+y*_h);

    w = _w;
    h = _h;
  }

  void display() {
    if (player != null) {
      if (player == "x") {
        drawX(pos.x, pos.y, w, h, animation);
      } else if (player == "o") {
        drawO(pos.x, pos.y, w, h, animation);
      }
    }
  }

  void update() {
    if (player != null)
      animation = lerp(animation, 1, 0.1);
  }

  boolean setPlayer(String p) {
    if (player == null && mouseX > pos.x && mouseX < pos.x+w && mouseY > pos.y && mouseY < pos.y+h) {
      player = p;
      return true;
    }

    return false;
  }
}

void drawX(float x, float y, float w, float h, float animation) {
  stroke(255, 0, 0);
  strokeWeight((w+h)/30);
  strokeCap(ROUND);

  float a1 = atan2((w*3/4)-(w/4), (h*3/4)-(h/4));
  float a2 = atan2((w*3/4)-(w/4), (h/4)-(h*3/4));

  line(x+w/4, y+h/4, x+w/4+cos(a1)*animation*dist(x+w/4, y+h/4, x+w*3/4, y+h*3/4), y+h/4+sin(a1)*animation*dist(x+w/4, y+h/4, x+w*3/4, y+h*3/4));
  line(x+w*3/4, y+h/4, x+w*3/4+cos(a2)*animation*dist(x+w*3/4, y+h/4, x+w/4, y+h*3/4), y+h/4+sin(a2)*animation*dist(x+w*3/4, y+h/4, x+w/4, y+h*3/4));
}

void drawO(float x, float y, float w, float h, float animation) {
  noFill();

  stroke(0, 0, 255);
  strokeWeight((w+h)/25);
  strokeCap(ROUND);

  arc(x+w/2, y+h/2, w/2, h/2, -HALF_PI-animation*PI, -HALF_PI+animation*PI);
}
