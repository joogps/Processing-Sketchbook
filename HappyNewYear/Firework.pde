class Firework {
  PVector pos;
  PVector vel;

  float size;

  float hue;
  float alpha;

  int level;
  int index;

  Firework(PVector p, PVector v, float h, int l, int i) {
    pos = p;
    vel = v;

    size = random(3, 10);

    hue = h;
    alpha = 255;

    level = l;
    index = i;
  }

  void display() {
    strokeWeight(size);
    stroke(hue, 255, 255, alpha);

    point(pos.x, pos.y);
  }

  void update() {
    pos.add(vel);
    vel.mult(0.975);

    alpha = lerp(alpha, 0, 0.025);
    hue+= 0.1;

    if (level > 0 && alpha < 10)
      recreate();
  }

  void recreate() {
    int children = round(random(10, 50));
    float childrenHue = random(255);

    for (int i = 0; i < children; i++)
      fireworks.add(new Firework(pos.copy(), new PVector(cos(TWO_PI*i/float(children)), sin(TWO_PI*i/float(children))).mult(size*1.5), childrenHue, random(2) < 0.5 ? level-1 : 0, fireworks.size()));

    fireworks.set(index, null);
  }
}
