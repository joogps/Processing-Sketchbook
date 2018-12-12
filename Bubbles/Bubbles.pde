ArrayList<Bubble> buubles;
Bubble bubble;

void setup() {
  fullScreen();
  buubles = new ArrayList<Bubble>();

  for (int i = 0; i < (width + height)/2/25; i++) {
    float radius = random(10, (width + height)/2/25);
    buubles.add(new Bubble(random(0, 1) < 0.5 ? radius : width-radius, random(0, 1) < 0.5 ? radius : height-radius, radius));
  }

  colorMode(HSB);
  background(255);
}

void draw() {
  for (int i = 0; i < buubles.size(); i++) {
    buubles.get(i).display();
    buubles.get(i).update();
  }

  if (mousePressed) {
    bubble.alpha+= 3;
    boolean growRadius;

    if (bubble.pos.x + bubble.radius >= width || bubble.pos.x - bubble.radius <= 0) {
      bubble.pos.x = bubble.pos.x + bubble.radius >= width ? width-bubble.radius : bubble.radius;
    }

    if (bubble.pos.y + bubble.radius >= height || bubble.pos.y - bubble.radius <= 0) {
      bubble.pos.y = bubble.pos.y + bubble.radius >= height ? height-bubble.radius : bubble.radius;
    }

    growRadius = !(bubble.pos.x + bubble.radius >= width && bubble.pos.x - bubble.radius <= 0) && !(bubble.pos.y + bubble.radius >= height && bubble.pos.y - bubble.radius <= 0);

    bubble.radius+= growRadius ? 3 : 0;

    bubble.display();
  }
}

void mousePressed() {
  bubble = new Bubble(mouseX, mouseY, 0);
  bubble.alpha = 0;
}

void mouseReleased() {
  buubles.add(bubble);
  bubble = null;
}
