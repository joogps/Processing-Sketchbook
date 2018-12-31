PFont font;

void setup() {
  fullScreen();
  font = createFont("monospaced.ttf", 120);
}

void draw() {
  background(hour()/23.0*255, minute()/59.0*255, second()/59.0*255);

  fill(255);
  textFont(font);
  textAlign(CENTER, CENTER);
  text(hour()+":"+minute()+":"+second(), width/2, height/2);
}
