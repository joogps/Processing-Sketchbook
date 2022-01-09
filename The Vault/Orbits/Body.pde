class Body {
  PVector origin;
  float theta;
  float length;
  float speed;
  float size;

  Body[] orbits;

  Body(float t, float l, float s, int o) {
    theta = t;
    length = l;
    speed = TWO_PI/random(240, 600);
    size = s;

    orbits = new Body[o];
    for (int i = 0; i < orbits.length; i++)
      orbits[i] = new Body(0, random(s, s*2), size/2.5, o-1);
  };

  void display() {
    pushMatrix();
    translate(cos(theta)*length, sin(theta)*length);

    if (orbits.length == 0) {
      noStroke();
      fill(theta/TWO_PI%1*255, 255, 255);
      ellipse(0, 0, size, size);
    }

    for (int i = 0; i < orbits.length; i++) {
      orbits[i].display();

      stroke(255, 5);
      line(0, 0, cos(orbits[i].theta)*orbits[i].length, sin(orbits[i].theta)*orbits[i].length);
    }
    popMatrix();
  }

  void update() {
    theta+= speed;

    for (int i = 0; i < orbits.length; i++)
      orbits[i].update();
  }
}
