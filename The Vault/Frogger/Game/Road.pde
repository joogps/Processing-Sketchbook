class Road {
  PVector pos;

  float roadWidth;
  float roadHeight;

  int numCars = round(random(1, 2));
  float carSpeed = random(4, 6)*(random(1) < 0.5 ? -1 : 1);

  Car[] cars = new Car[numCars];

  Road(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    roadWidth = _width;
    roadHeight = _height;

    for (int i = 0; i < cars.length; i++) {
      cars[i] = new Car((i*width/numCars) + width/(numCars + 1), pos.y, width/(numCars + 1), roadHeight, carSpeed);
    }
  }

  void display() {
    rectMode(CORNER);

    fill(80);
    rect(pos.x, pos.y, roadWidth, roadHeight);

    for (int i = 0; i < cars.length; i++) {
      cars[i].display();
    }
  }

  void update() {
    for (int i = 0; i < cars.length; i++) {
      cars[i].update();
    }
  }
}
