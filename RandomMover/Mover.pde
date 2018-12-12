class Mover {
  PVector position;
  float angle;
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  ArrayList<Float> angles = new ArrayList<Float>();
  
  float size;
  String shape;
  
  PVector startingPosition;

  Mover(float x, float y, float _size, String _shape) {
    position = new PVector(x, y);
    startingPosition = new PVector(x, y);
    size = _size;
    shape = _shape;
  }

  void display() {
    noStroke();

    for (int i = 0; i < positions.size(); i++) {
      fill(map(constrain(abs(startingPosition.x - positions.get(i).x), 1, startingPosition.x) * constrain(abs(startingPosition.y - positions.get(i).y), 1, startingPosition.y), 0, startingPosition.x * startingPosition.y, 0, 255 * size/2) % 255, 255, 255, 10);

      switch(shape) {
      case "ellipse": 
        ellipse(positions.get(i).x, positions.get(i).y, size, size);
        break;
      case "rectangle":
        rectMode(CENTER);
        rect(positions.get(i).x, positions.get(i).y, size, size);
        break; 
      case "triangle":
        pushMatrix();
        translate(positions.get(i).x, positions.get(i).y);
        rotate(angles.get(i));
        triangle(-size/2, size/2, size/2, size/2, 0, -size/2);
        popMatrix();
        break;
      }
    }
  }

  void move() {
    float xIncrement = round(random(position.x <= size ? 0 : -1.5 + map(position.x - startingPosition.x, -startingPosition.x, startingPosition.x, 0, -0.5) * (positions.contains(position) && positions.get(positions.indexOf(position)).x <= startingPosition.x ? (round(random(0, 4)) == 0 ? -2 : 2.5) : 1), position.x >= width-size ? 0 : 1.5 + map(position.x - startingPosition.x, -startingPosition.x, startingPosition.x, 0.5, 0) * (positions.contains(position) && positions.get(positions.indexOf(position)).x >= startingPosition.x ? (round(random(0, 4)) == 0 ? -2 : 2.5) : 1))) * size;
    float yIncrement = round(random(position.y <= size ? 0 : -1.5 + map(position.y - startingPosition.y, -startingPosition.y, startingPosition.y, 0, -0.5) * (positions.contains(position) && positions.get(positions.indexOf(position)).y <= startingPosition.y ? (round(random(0, 4)) == 0 ? -2 : 2.5) : 1), position.y >= height-size ? 0 : 1.5 + map(position.y - startingPosition.y, -startingPosition.y, startingPosition.y, 0.5, 0) * (positions.contains(position) && positions.get(positions.indexOf(position)).y >= startingPosition.y ? (round(random(0, 4)) == 0 ? -2 : 2.5) : 1))) * size;

    position.x+= xIncrement;
    position.y+= yIncrement;
    positions.add(new PVector(position.x, position.y));

    if (shape == "triangle") {
      if (abs(xIncrement) == size) {
        angle = angle == PI ? 0 : PI;
      }
      angles.add(angle);
    }
  }
}
