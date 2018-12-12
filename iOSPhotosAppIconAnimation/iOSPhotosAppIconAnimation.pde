void setup() {
  size(960, 960);

  colorMode(HSB);
  rectMode(CENTER);
}

void draw() {
  translate(width/2.0, height/2.0);
  background(255);

  for (float a = 0; a < TWO_PI-QUARTER_PI; a+= QUARTER_PI) {
    fill(((a+QUARTER_PI)/TWO_PI+(cos(frameCount/6000.0*TWO_PI)+1))*255%255, 255, 200, 150);
    noStroke();

    pushMatrix();
    translate(cos(a-HALF_PI)*(width+height)/8.5, sin(a-HALF_PI)*(width+height)/8.5);
    rotate(a+sin(frameCount/3000.0*TWO_PI)*TWO_PI);

    petal(0, 0, width/3.0, height/3.0);
    popMatrix();
  }
}

void petal(float x, float y, float w, float h) {
  beginShape();
  for (float a = 0; a < PI; a+= 0.01)
    vertex(x+cos(a)*w/3, y+h/3+sin(a)*w/3);
  for (float a = PI; a < TWO_PI; a+= 0.01)
    vertex(x+cos(a)*w/3, y-h/3+sin(a)*w/3);
  endShape(CLOSE);
}
