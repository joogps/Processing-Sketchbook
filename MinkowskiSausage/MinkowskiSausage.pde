float levels;

void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  minkowski(width, height*0.75, levels);

  levels = lerp(levels, round(sin(frameCount/300.0)*4), 0.1);
  if (abs(levels%1) > 0.99 || abs(levels%1) < 0.01)
    levels = round(levels);
}

void minkowski(float w, float h, float level) {
  if (level != 0) {
    int levelPolarity = int(level/abs(level));
    float newLevel = abs(level) <= 1 ? 0 : level-levelPolarity;

    h*= constrain(abs(level), 0, 1)*levelPolarity;

    pushMatrix();
    translate(-w*3/8.0, 0);

    minkowski(w/4.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(-w*2/8.0, -h/4.0);
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(-w/8.0, -h/2.0);

    minkowski(w/4.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(0, -h/4.0);
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(0, h/4.0);
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w/8.0, h/2.0);

    minkowski(w/4.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w/4.0, h/4.0);
    rotate(HALF_PI);

    minkowski(h/2.0, h/4.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w*3/8.0, 0);

    minkowski(w/4.0, h/4.0, newLevel);
    popMatrix();
  } else
    line(-w/2.0, 0, w/2.0, 0);
}
