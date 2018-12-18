void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  fractal(width, height, sin(frameCount/600.0*TWO_PI)*4);
}

void fractal(float w, float h, float level) {
  if (level > 1 || level < -1) {
    pushMatrix();
    translate(-w*2/5.0, 0);

    fractal(w/5.0, h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w/4.0, -h/4.0*level/abs(level));
    rotate(-HALF_PI-atan2(w/10.0, -h/2.0*level/abs(level)));

    fractal(dist(-w*3/10.0, 0, -w/5.0, -h/2.0*level/abs(level)), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w*3/20.0, -h/4.0*level/abs(level));
    rotate(HALF_PI-atan2(-w/10.0, -h/2.0*level/abs(level)));

    fractal(dist(-w/5.0, -h/2.0*level/abs(level), -w/10.0, 0), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w/20.0, h/4.0*level/abs(level));
    rotate(HALF_PI-atan2(w/10.0, h/2.0*level/abs(level)));

    fractal(dist(-w/10.0, 0, 0, h/2.0*level/abs(level)), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w/20.0, h/4.0*level/abs(level));
    rotate(-HALF_PI-atan2(-w/10.0, h/2.0*level/abs(level)));

    fractal(dist(w/10.0, 0, 0, h/2.0*level/abs(level)), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w*3/20.0, -h/4.0*level/abs(level));
    rotate(-HALF_PI-atan2(w/10.0, -h/2.0*level/abs(level)));

    fractal(dist(w/5.0, -h/2.0*level/abs(level), w/10.0, 0), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w/4.0, -h/4.0*level/abs(level));
    rotate(-HALF_PI-atan2(w/10.0, h/2.0*level/abs(level)));

    fractal(dist(w*3/10.0, 0, w/5.0, h/2.0*level/abs(level)), h/8.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w*2/5.0, 0);

    fractal(w/5.0, h/5.0, level-level/abs(level));
    popMatrix();
  } else {
    line(-w/2.0, 0, -w*3/10.0, 0);
    line(-w*3/10.0, 0, -w/5.0, -h/2.0*level);
    line(-w/5.0, -h/2.0*level, -w/10.0, 0);
    line(-w/10.0, 0, 0, h/2.0*level);
    line(0, h/2.0*level, w/10.0, 0);
    line(w/10.0, 0, w/5.0, -h/2.0*level);
    line(w/5.0, -h/2.0*level, w*3/10.0, 0);
    line(w*3/10.0, 0, w/2.0, 0);
  }
}
