class Crate {
  PImage crate;

  PVector pos;
  ArrayList<PVector> forces;

  float radius = (width+height)/16;

  PVector[][] linePos;

  float maxX;
  float minX;
  float maxY;
  float minY;

  Crate(float x, float y, ArrayList<PVector> _forces) {
    crate = loadImage("crate.png");

    pos = new PVector(x, y);
    forces = _forces;

    linePos = new PVector[forces.size()][2];
    for (int i = 0; i < forces.size(); i++) {
      PVector pos0 = new PVector(forces.get(i).x != 0 ? radius*forces.get(i).x/abs(forces.get(i).x) : 0, forces.get(i).y != 0 ? radius*forces.get(i).y/abs(forces.get(i).y) : 0);
      PVector pos1 = new PVector(forces.get(i).x != 0 ? (radius*forces.get(i).x/abs(forces.get(i).x) + forces.get(i).x) * 2 : 0, forces.get(i).y != 0 ? (radius*forces.get(i).y/abs(forces.get(i).y) + forces.get(i).y) * 2 : 0);

      linePos[i][0] = pos0;
      linePos[i][1] = pos1;

      if (linePos[i][0].x < minX)
        minX = linePos[i][0].x;

      if (linePos[i][0].x > maxX)
        maxX = linePos[i][0].x;

      if (linePos[i][0].y < minY)
        minY = linePos[i][0].y;

      if (linePos[i][0].y > maxY)
        maxY = linePos[i][0].y;
    }
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);

    strokeWeight(2);
    stroke(0);
    fill(0);
    for (int i = 0; i < linePos.length; i++) {
      line(linePos[i][0].x, linePos[i][0].y, linePos[i][1].x, linePos[i][1].y);

      pushMatrix();
      translate(linePos[i][1].x, linePos[i][1].y);
      rotate(atan2(linePos[i][1].y, linePos[i][1].x));

      triangle(0, -10, 0, 10, 10, 0);
      popMatrix();
    }

    imageMode(CENTER);
    image(crate, 0, 0, radius*2, radius*2);
    popMatrix();
  }

  void update() {
    for (int i = 0; i < forces.size(); i++) {
      pos.add(forces.get(i));
    }

    if (pos.x-radius+minX-10 > width) {
      pos.x = -radius-maxX-10;
    }

    if (pos.x+radius+maxX+10 < 0) {
      pos.x = width+radius-minX+10;
    }

    if (pos.y-radius+minY-10 > height) {
      pos.y = -radius-maxY-10;
    }

    if (pos.y+radius+maxY+10 < 0) {
      pos.y = height+radius-minY+10;
    }
  }
}
