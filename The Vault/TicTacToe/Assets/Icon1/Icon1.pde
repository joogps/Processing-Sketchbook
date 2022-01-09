void setup() {
  size(640, 640);

  background(255);
  drawO(-width/4, -height/4, width*1.5, height*1.5);
  drawX(width/5, height/5, width*0.6, height*0.6);

  save("icon.png");
  exit();
}

void drawX(float x, float y, float w, float h) {
  stroke(255, 0, 0);
  strokeWeight(50);
  strokeCap(ROUND);

  line(x+w/4, y+h/4, x+w*3/4, y+h*3/4);
  line(x+w*3/4, y+h/4, x+w/4, y+h*3/4);
}

void drawO(float x, float y, float w, float h) {
  noFill();

  stroke(0, 0, 255);
  strokeWeight(50);
  strokeCap(ROUND);

  ellipse(x+w/2, y+h/2, w/2, h/2);
}
