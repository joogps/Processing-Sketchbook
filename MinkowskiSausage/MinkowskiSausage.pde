void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  minkowski(width, height*0.75, sin(frameCount/120.0)*4);
}

void minkowski(float w, float h, float level) {
  if (level > 1 || level < -1) {
    pushMatrix();
    translate(-w*3/8.0, 0);

    minkowski(w/4.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w*2/8.0, -h/4.0*level/abs(level));
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w/8.0, -h/2.0*level/abs(level));

    minkowski(w/4.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(0, -h/4.0*level/abs(level));
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(0, h/4.0*level/abs(level));
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w/8.0, h/2.0*level/abs(level));

    minkowski(w/4.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w/4.0, h/4.0*level/abs(level));
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w*3/8.0, 0);

    minkowski(w/4.0, h/4.0, level-level/abs(level));
    popMatrix();
  } else {
    line(-w/2.0, 0, -w/4.0, 0);
    line(-w/4.0, 0, -w/4.0, -h/2.0*level);
    line(-w/4.0, -h/2.0*level, 0, -h/2.0*level);
    line(0, -h/2.0*level, 0, 0);
    line(0, 0, 0, h/2.0*level);
    line(0, h/2.0*level, w/4.0, h/2.0*level);
    line(w/4.0, h/2.0*level, w/4.0, 0);
    line(w/4.0, 0, w/2.0, 0);
  }
}
