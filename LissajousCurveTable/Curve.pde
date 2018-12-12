class Curve {
  PVector pos;
  float size;

  ArrayList<PVector> vertices;
  boolean addVertices;

  PVector vertexPos;

  Curve(float x, float y, float s) {
    pos = new PVector(x, y);
    size = s;

    vertices = new ArrayList<PVector>();
    vertices.add(new PVector(1, 0));

    addVertices = true;

    vertexPos = new PVector(1, 0);
  }

  void display() {
    pushStyle();
    pushMatrix();
    translate(pos.x, pos.y);

    strokeWeight(1);

    if (vertices.size() > 0) {
      for (int i = 0; i < vertices.size()-1; i++) {
        stroke(map(dist(pos.x+vertices.get(i).x*size, pos.y+vertices.get(i).y*size, 150-size/2, 150-size/2), 0, dist(150-size/2, 150-size/2, width-(150-size/2), height-(150-size/2)), 0, 255), 255, 255);
        line(vertices.get(i).x*size, vertices.get(i).y*size, vertices.get(i+1).x*size, vertices.get(i+1).y*size);
      }

      ellipse(vertexPos.x*size, vertexPos.y*size, size/8, size/8);
    }
    popMatrix();
    popStyle();
  }

  void update(Angle c, Angle r) { 
    if (addVertices)
      vertices.add(new PVector(cos(c.angle), sin(r.angle)));

    if (c.angle > 0 && r.angle > 0 && abs(c.angle%TWO_PI-TWO_PI) < 0.05 && abs(r.angle%TWO_PI-TWO_PI) < 0.05)
      addVertices = false;

    vertexPos = new PVector(cos(c.angle), sin(r.angle));
  }
}
