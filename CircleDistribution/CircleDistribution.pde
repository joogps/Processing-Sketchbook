Circle[] circles;

void setup() {
  size(640, 320);

  circles = new Circle[100];
  for (int i = 0; i < circles.length; i++) {
    PVector pos = new PVector(random(width), random(height));
    float radius = 0;

    boolean loop = true;
    while (loop) {
      radius++;

      if (pos.x-radius <= 0 || pos.x+radius >= width || pos.y-radius <= 0 || pos.y+radius >= height) {
        loop = false;
        radius--;
        break;
      }

      for (int j = 0; j < i; j++) {
        if (dist(pos.x, pos.y, circles[j].pos.x, circles[j].pos.y) <= circles[j].radius) {
          pos = new PVector(random(radius, width-radius), random(radius, height-radius));
          radius--;
          break;
        }

        if (dist(pos.x, pos.y, circles[j].pos.x, circles[j].pos.y) <= radius+circles[j].radius) {
          if (radius == 1)
            pos = new PVector(random(radius, width-radius), random(radius, height-radius));
          else {
            loop = false;
            radius--;
            break;
          }
        }
      }
    }

    circles[i] = new Circle(pos, radius);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < circles.length; i++)
    circles[i].display();
}
