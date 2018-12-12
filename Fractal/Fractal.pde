void setup() {
  size(640, 360);
  colorMode(HSB);
}

void draw() {
  background(0);
  stroke(frameCount/240.0%1*255, 255, 255);

  translate(width/2, height/2);
  scale(1, sin(frameCount/240.0*TWO_PI));

  fractal(width, height*0.6, 4);
}

void fractal(float w, float h, int level) {
  if (level > 0) {
    pushMatrix();
    translate(-w*2/5, 0);

    fractal(w/5, h/5, level-1);
    popMatrix();

    pushMatrix();
    translate(-w/4, -h/4);
    rotate(PI*1.5-atan2(w/10, -h/2));

    fractal(dist(-w*3/10, 0, -w/5, -h/2), dist(-w*3/10, 0, -w/5, -h/2)/w*h/2, level-1);
    popMatrix();

    pushMatrix();
    translate(-w/10, 0);
    rotate(-PI*1.5-atan2(w/5, h));

    fractal(dist(-w/5, 0, 0, h), dist(-w/5, 0, 0, h)/w*h/2, level-1);
    popMatrix();

    pushMatrix();
    translate(w/10, 0);
    rotate(PI*1.5-atan2(-w/5, h));

    fractal(dist(w/5, 0, 0, h), dist(w/5, 0, 0, h)/w*h/2, level-1);
    popMatrix();

    pushMatrix();
    translate(w/4, -h/4);
    rotate(PI*1.5-atan2(w/10, h/2));

    fractal(dist(w*3/10, 0, w/5, h/2), dist(w*3/10, 0, w/5, h/2)/w*h/2, level-1);
    popMatrix();

    pushMatrix();
    translate(w*2/5, 0);

    fractal(w/5, h/5, level-1);
    popMatrix();
  } else {
    line(-w/2, 0, w/2, 0);
  }
}
