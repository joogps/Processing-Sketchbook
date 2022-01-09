float y;
float t;

float w;
float h;

void setup() {
  size(201, 800);
  w = 200;
  h = 250;
  
  y = height/2-h/2;
  t = y;
  
  colorMode(HSB);
}

void draw() {
  background(255);
  y = constrain(lerp(y, t, 0.15), 1, height-(h+1));
  
  fill(map(y, 1, height-(h+1), 0, 255), 255, 255);
  noStroke();
  rect(width/2-w/2, y, w, h);
}

void mouseWheel(MouseEvent event) {
  t = y + event.getCount()*20;
}
