ArrayList<Circle> circles;

PGraphics canvas;

void setup() {
  fullScreen(P2D);
  noStroke();

  circles = new ArrayList<Circle>();

  canvas = createGraphics(320, 180, P2D);
  canvas.beginDraw();
  canvas.endDraw();

  noCursor();
}

void draw() {
  canvas.background(0);

  if (circles.size() > 0) {
    for (int i = 0; i < circles.size(); i++) {
      circles.get(i).update();
    }

    canvas.loadPixels();
    for (int x = 0; x < canvas.width; x++) {
      for (int y = 0; y < canvas.height; y++) {
        float r = 0;
        float g = 0;
        float b = 0;

        for (Circle circle : circles) {
          float distance = dist(x, y, circle.pos.x, circle.pos.y)+circle.size/4;
          r+= red(circle.col)/distance*circle.size;
          g+= green(circle.col)/distance*circle.size;
          b+= blue(circle.col)/distance*circle.size;
        }
        canvas.pixels[x+y*canvas.width] = color(r, g, b);
      }
    }
    canvas.updatePixels();
  }

  image(canvas, 0, 0, width, height);
}

void createCircle() {
  if (circles.size() < 12)
    circles.add(new Circle(random(canvas.width), random(canvas.height), random(10, 150), random(255)));
}

void keyPressed() {
  createCircle();
}

void mousePressed() {
  createCircle();
}
