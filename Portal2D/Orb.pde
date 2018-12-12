class Orb {
  PVector pos;
  float size;

  float start;
  float end;

  color strokeColor;
  float strokeWeight;

  float alpha;
  float origAlpha;
  float alphaSpeed;

  float theta;
  float thetaSpeed;

  Orb() {
    pos = new PVector(width/2, height/2);
    size = random(1, (width+height)/4);

    start = random(TWO_PI);
    end = random(TWO_PI);

    strokeColor = color(random(50, 200), 0, random(200, 255));
    strokeWeight = random(3, 10);

    alpha = random(255);
    origAlpha = alpha;
    alphaSpeed = random(600, 3000);

    thetaSpeed = random(0.001, 0.045);
  }

  void display() {
    noFill();
    stroke(strokeColor, alpha);
    strokeWeight(strokeWeight);

    pushMatrix();
    rotate(theta);

    arc(0, 0, size, size, start, end);
    popMatrix();
  }

  void update() {
    alpha = abs(cos(frameCount/alphaSpeed*TWO_PI))*origAlpha;
    theta+= thetaSpeed;
  }
}
