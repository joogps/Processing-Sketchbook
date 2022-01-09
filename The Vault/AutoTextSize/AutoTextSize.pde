String str;

void setup() {
  size(640, 360);

  str = "Hello world!";
  autoTextSize(str, width * 0.8, height/2);

  textAlign(CENTER, CENTER);
}

void draw() {
  background(150);

  fill(0);
  text(str, width/2, height/2);
}

void autoTextSize(String string, float _width, float _height) {
  float size = 1;
  textSize(size);
  while (textWidth(string) < _width && textAscent()-textDescent() < _height) {
    size+= 0.1;
    textSize(size);
  }
  textSize(size);
}
