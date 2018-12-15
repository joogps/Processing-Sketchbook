class Toothpick {
  PVector pos;
  float size;

  String orientation;
  boolean newToothpick = true;

  int generation;

  Toothpick(float x, float y, float s, String o, int g) {
    pos = new PVector(x, y);
    size = s;
    orientation = o;
    generation = g;
  }

  void display() {
    if (newToothpick)
      stroke(generation*10%255, 255, 255);
    else {
      stroke(255);
    }

    if (orientation == "horizontal")
      line(pos.x-size/2.0, pos.y, pos.x+size/2.0, pos.y);
    else if (orientation == "vertical")
      line(pos.x, pos.y-size/2.0, pos.x, pos.y+size/2.0);
  }

  void recreate() {
    Toothpick toothpick1 = this;
    Toothpick toothpick2 = this;

    if (orientation == "horizontal") {
      toothpick1 = new Toothpick(pos.x-size/2.0, pos.y, size, "vertical", generation+1);
      toothpick2 = new Toothpick(pos.x+size/2.0, pos.y, size, "vertical", generation+1);
    } else if (orientation == "vertical") {
      toothpick1 = new Toothpick(pos.x, pos.y-size/2.0, size, "horizontal", generation+1);
      toothpick2 = new Toothpick(pos.x, pos.y+size/2.0, size, "horizontal", generation+1);
    }

    boolean add1 = true;   
    for (int i = 0; i < toothpicks.size(); i++) {
      if (toothpicks.get(i) != this && toothpicks.get(i).newToothpick && toothpick1.colliding(toothpicks.get(i))) {
        add1 = false;
        break;
      }
    }

    if (add1)
      toothpicks.add(toothpick1);

    boolean add2 = true;
    for (int i = 0; i < toothpicks.size(); i++) {
      if (toothpicks.get(i) != this && toothpicks.get(i).newToothpick && toothpick2.colliding(toothpicks.get(i))) {
        add2 = false;
        break;
      }
    }

    if (add2)
      toothpicks.add(toothpick2);
  }

  boolean colliding(Toothpick t) {
    if (orientation == "horizontal" && t.orientation == "v")
      return pos.y <= t.pos.y+t.size/2.0 && pos.y >= t.pos.y-t.size/2.0 && t.pos.x >= pos.x-size/2.0 && t.pos.x <= pos.x+size/2.0;
    else if (orientation == "vertical" && t.orientation == "horizontal")
      return t.pos.y <= pos.y+size/2.0 && t.pos.y >= pos.y-size/2.0 && pos.x >= t.pos.x-t.size/2.0 && pos.x <= t.pos.x+t.size/2.0;


    return false;
  }
}
