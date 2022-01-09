ArrayList<ShapeBreath> shapes;
Integer lastShape = null;
int validShapes;
int timeKill = 300;
int setLastCounter = 240;

void setup() {
  size(640, 640);
  shapes = new ArrayList<ShapeBreath>();

  shapes.add(new ShapeBreath(int(width / 2), int(height / 2), int(random(150, 350))));
  surface.setTitle("Breathe...");
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x + y * width] = color(map(dist(x, y, width / 2, 0), 0, (width + height) / 2, 110, 10));
    }
  }
  updatePixels();

  validShapes = 0;
  for (int i = 0; i < shapes.size(); i++) {
    if (shapes.get(i) != null) {
      shapes.get(i).breathe();
      if (!shapes.get(i).beingKilled) {
        shapes.get(i).increaseAlpha();
      }
      shapes.get(i).show();

      validShapes++;
    }
  }

  if (lastShape != null) {
    for (int i = lastShape; i >= 0; i--) {
      if (shapes.get(i) != null) {
        shapes.get(i).kill(i);
      }
    }

    if (timeKill > 0) {
      timeKill--;
    }

    if (timeKill <= 0 && lastShape < shapes.size()) {
      timeKill = 300;
      lastShape++;
    }
  }

  if (validShapes > 1 && lastShape == null) {
    setLastCounter--;
    if (setLastCounter <= 0) {
      lastShape = 0;
    }
  }
  
  if(lastShape != null && ((validShapes <= 1) || (random(0, 150) < 1 && lastShape < shapes.size() - 1))){
    shapes.add(new ShapeBreath(int(random(width)), int(random(height)), int(random(50, 300))));
  }
}

void mousePressed() {
  if (validShapes <= 6) {
    shapes.add(new ShapeBreath(mouseX, mouseY, int(random(75, 300))));
  } else if (lastShape < shapes.size()) {
    lastShape++;
  }
}
