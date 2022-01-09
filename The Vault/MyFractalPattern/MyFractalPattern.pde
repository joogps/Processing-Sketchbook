float levels;

void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  fractal(width, height, levels);

  levels = lerp(levels, round(sin(frameCount/300.0)*3), 0.1);
  if (abs(levels%1) > 0.99 || abs(levels%1) < 0.01)
    levels = round(levels);
}

void fractal(float w, float h, float level) {
  if (level != 0) {
    int levelPolarity = int(level/abs(level));
    float newLevel = abs(level) <= 1 ? 0 : level-levelPolarity;

    h*= constrain(abs(level), 0, 1)*levelPolarity;

    pushMatrix();
    translate(-w*2/5.0, 0);

    fractal(w/5.0, h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(-w/4.0, -h/4.0);
    rotate(atan2(-h/2.0, w/10));

    fractal(dist(-w*3/10.0, 0, -w/5.0, -h/2.0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(-w*3/20.0, -h/4.0);
    rotate(atan2(h/2.0, w/10));

    fractal(dist(-w/5.0, -h/2.0, -w/10.0, 0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(-w/20.0, h/4.0);
    rotate(atan2(h/2.0, w/10.0));

    fractal(dist(-w/10.0, 0, 0, h/2.0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w/20.0, h/4.0);
    rotate(atan2(-h/2.0, w/10.0));

    fractal(dist(w/10.0, 0, 0, h/2.0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w*3/20.0, -h/4.0);
    rotate(atan2(-h/2.0, w/10.0));

    fractal(dist(w/5.0, -h/2.0, w/10.0, 0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w/4.0, -h/4.0);
    rotate(atan2(h/2.0, w/10.0));

    fractal(dist(w*3/10.0, 0, w/5.0, h/2.0), h/8.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w*2/5.0, 0);

    fractal(w/5.0, h/5.0, newLevel);
    popMatrix();
  } else
    line(-w/2.0, 0, w/2.0, 0);
}
