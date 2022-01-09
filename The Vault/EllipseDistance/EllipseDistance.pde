float point1;
float point2;

float w;
float h;

void setup() {
  size(640, 360);

  point1 = width*0.2;
  point2 = width*0.8;

  h = height/2;
  w = dist(point1, height/2, width/2, height/2-h/2)+dist(point2, height/2, width/2, height/2-h/2);
}

void draw() {
  PVector pos = new PVector((point1+point2)/2+cos(frameCount/240.0*TWO_PI)*w/2, height/2+sin(frameCount/240.0*TWO_PI)*h/2);

  background(255);

  strokeCap(RECT);

  stroke(255, 172, 18);
  line(width/2-w/2, height/2+h/2, width/2-w/2+dist(point1, height/2, pos.x, pos.y), height/2+h/2);

  stroke(13, 134, 252);
  line(width/2+w/2-dist(point2, height/2, pos.x, pos.y), height/2+h/2, width/2+w/2, height/2+h/2);

  strokeCap(ROUND);

  stroke(0);
  point(width/2-w/2+dist(point1, height/2, pos.x, pos.y), height/2+h/2);

  strokeWeight(5);

  pushMatrix();
  translate(0, -h/4);

  stroke(0);
  ellipse((point1+point2)/2, height/2, w, h);

  stroke(255, 172, 18);
  line(pos.x, pos.y, point1, height/2);

  stroke(13, 134, 252);
  line(pos.x, pos.y, point2, height/2);

  stroke(0);
  point(point1, height/2);
  point(point2, height/2);

  stroke(255);
  point(pos.x, pos.y);
  popMatrix();
}
