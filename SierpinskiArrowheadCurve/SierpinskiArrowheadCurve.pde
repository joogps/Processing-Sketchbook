float levels;

void settings() {
  size(360, round(sin(TWO_PI/6.0)*360*2));
}

void draw() {
  background(0);
  stroke(255);

  translate(width/2, height/2);

  arrowhead(width, height/2, levels);

  levels = lerp(levels, round(sin(frameCount/400.0)*7), 0.1);
  if (abs(levels%1) > 0.99 || abs(levels%1) < 0.01)
    levels = round(levels);
}

void arrowhead(float w, float h, float level) {
  if (level != 0) {
    int levelPolarity = int(level/abs(level));
    float newLevel = abs(level) <= 1 ? 0 : level-levelPolarity;

    h*= constrain(abs(level), 0, 1)*levelPolarity;

    pushMatrix();
    translate(-w*3/8.0, -h/4.0);
    rotate(atan2(h/2.0, -w/4.0));

    arrowhead(dist(-w/2.0, 0, -w/4.0, -h/2.0), h/2.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(0, -h/2.0);

    arrowhead(w/2.0, h/2.0, newLevel);
    popMatrix();

    pushMatrix();
    translate(w*3/8.0, -h/4);
    rotate(atan2(-h/2.0, -w/4.0));

    arrowhead(dist(w/2.0, 0, w/4.0, -h/2.0), h/2.0, newLevel);
    popMatrix();
  } else
    line(-w/2.0, 0, w/2.0, 0);
}
