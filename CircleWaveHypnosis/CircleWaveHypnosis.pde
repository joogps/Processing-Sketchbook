int radius = 100;
float angleOff = 0;

void setup() {
  size(640, 360);
}

void draw() {
  translate(width/2, height/2);
  background(180);
  
  stroke(0);
  strokeWeight(abs(angleOff/5));
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);

  fill(30, 100, 200);
  noStroke();
  beginShape();
  for (float i = 0; i < TWO_PI; i+= 0.001) {
    float r = cos(TWO_PI * ((i + angleOff) / QUARTER_PI)) * (angleOff * 10);

    float x = (radius + r) * cos(i);
    float y = (radius + r) * sin(i);
    vertex(x, y);
  }
  endShape();
  
  stroke(0);
  point(0, 0);
  
  angleOff+= 0.035 * cos(TWO_PI * frameCount / (frameRate * 90));
}
