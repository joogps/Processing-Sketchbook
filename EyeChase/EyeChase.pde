void setup() {
  size(640, 640);
}

void draw() {
  PVector mouse = new PVector(mouseX, mouseY);
  mouse.sub(new PVector(width/2, height/2));

  background(100);
  rectMode(CENTER);

  fill(255);
  rect(width/2 + cos(atan2(mouse.y, mouse.x)) * 5, height/2 + sin(atan2(mouse.y, mouse.x)) * 5, width/1.5, height/3);

  ellipse(width/2 - width/6 + cos(atan2(mouse.y, mouse.x - width/6)) * 3, height/2 + sin(atan2(mouse.y, mouse.x - width/6)) * 3, 100, 100);
  ellipse(width/2 + width/6 + cos(atan2(mouse.y, mouse.x + width/6)) * 3, height/2 + sin(atan2(mouse.y, mouse.x + width/6)) * 3, 100, 100);

  fill(0);
  ellipse(width/2 - width/6 + cos(atan2(mouse.y, mouse.x + width/6)) * 25, height/2 + sin(atan2(mouse.y, mouse.x + width/6)) * 25, 50, 50);
  ellipse(width/2 + width/6 + cos(atan2(mouse.y, mouse.x - width/6)) * 25, height/2 + sin(atan2(mouse.y, mouse.x - width/6)) * 25, 50, 50);
  
  fill(255, 0, 0);
  ellipse(width/2 + cos(atan2(mouse.y - height/15, mouse.x)) * 25, height/2 + height/15 + sin(atan2(mouse.y - height/15, mouse.x)) * 25, 50, 50);
}
