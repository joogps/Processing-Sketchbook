class CircleWave {
  PVector pos;
  float r;
  float f;
  float s;
  float h;

  CircleWave() {
    pos = new PVector(random(width), random(height));
    r = random(50, (width+height)/4);
    f = TWO_PI/round(random(6, 10));
    s = random(120, 300);
    h = random(255);
  }

  void display() {   
    pushMatrix();
    translate(pos.x, pos.y);

    fill((h+frameCount/(s*5)*255)%255, 255, 255);

    beginShape();
    for (float t = 0; t < TWO_PI; t+= 0.001) {
      float wave = sin(t/f*TWO_PI+sin(frameCount/s*TWO_PI)*TWO_PI)*sin(frameCount/(s*5)*TWO_PI)*r/5.0;

      float x = (r+wave)*cos(t);
      float y = (r+wave)*sin(t);
      vertex(x, y);
    }
    endShape();
    popMatrix();
  }
}
