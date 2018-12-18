void setup() {
  size(640, 320);
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  koch(width, height/2, sin(frameCount/600.0*TWO_PI)*5);
}

void koch(float w, float h, float level) {
  if (level > 1 || level < -1) {
    pushMatrix();
    translate(-w*2/6.0, 0);

    koch(w/3.0, h/3.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(-w/12.0, -h/2.0*level/abs(level));
    rotate(atan2(w/6.0, h*level/abs(level))-HALF_PI);

    koch(dist(-w/6.0, 0, 0, -h*level/abs(level)), h/3.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w/12.0, -h/2.0*level/abs(level));
    rotate(atan2(-w/6.0, h*level/abs(level))+HALF_PI);

    koch(dist(w/6.0, 0, 0, -h*level/abs(level)), h/3.0, level-level/abs(level));
    popMatrix();

    pushMatrix();
    translate(w*2/6.0, 0);

    koch(w/3.0, h/3.0, level-level/abs(level));
    popMatrix();
  } else {
    line(-w/2.0, 0, -w/6.0, 0);
    line(-w/6.0, 0, 0, -h*level);
    line(0, -h*level, w/6.0, 0);
    line(w/6.0, 0, w/2.0, 0);
  }
}
