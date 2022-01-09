void setup() {
  size(640, 640);
  background(0);
}

void draw() {
  float size = round(random(2, 25));

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      noFill();
      noStroke();
      rect(width*i/size, height*j/size, width/size, height/size);
    }
  }

  int x = round(random(size));
  int y = round(random(size));
  fill(10, 100, 255, 5);
  rect(width*x/size, height*y/size, width/size, height/size);

  float neighborAngle = random(TWO_PI);
  int neighborX = x+round(cos(neighborAngle));
  int neighborY = y+round(sin(neighborAngle));

  fill(10, 255, 255, 5);
  rect(width*neighborX/size, height*neighborY/size, width/size, height/size);
}
