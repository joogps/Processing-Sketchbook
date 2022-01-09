class Portal {
  PVector pos;
  float size;

  color fillColor;

  boolean invertShearTheta;
  float origShearTheta;
  float shearTheta;

  Orb[] orbs;
  Star[] stars;

  Portal() {
    pos = new PVector(width/2, height/2);
    size = (width+height)/4;

    invertShearTheta = random(1) < 0.5;
    origShearTheta = QUARTER_PI;
    shearTheta = abs((invertShearTheta ? 255 : 0)-origShearTheta);

    fillColor = lerpColor(color(155, 0, 200), color(100, 0, 255), random(1));

    orbs = new Orb[75];
    for (int i = 0; i < orbs.length; i++)
      orbs[i] = new Orb();

    stars = new Star[50];
    for (int i = 0; i < stars.length; i++)
      stars[i] = new Star();
  }

  void display() {
    for (int i = 0; i < stars.length; i++) {
      if (stars[i].size < 5)
        stars[i].display();
    }

    pushMatrix();
    translate(pos.x, pos.y);
    shearX(shearTheta);

    noFill();
    for (float s = 0; s < size; s+= 10) {
      stroke(fillColor, (size-s)/size*255);
      strokeWeight(abs(cos((frameCount+(size-s)/size*10)/600.0))*10);

      ellipse(0, 0, s, s);
    }

    for (int i = 0; i < orbs.length; i++)
      orbs[i].display();
    popMatrix();

    for (int i = 0; i < stars.length; i++) {
      if (stars[i].size >= 5)
        stars[i].display();
    }
  }

  void update() {
    shearTheta = abs((invertShearTheta ? 255 : 0)-abs(cos(frameCount/60000.0*TWO_PI))*origShearTheta);

    for (int i = 0; i < orbs.length; i++)
      orbs[i].update();

    for (int i = 0; i < stars.length; i++) {
      stars[i].update();
    }
  }
}
