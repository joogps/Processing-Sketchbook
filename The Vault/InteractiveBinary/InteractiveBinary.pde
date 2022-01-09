Bit[] bitArray;

void setup() {
  size(640, 300);

  bitArray = new Bit[8];
  for (int i = 0; i < bitArray.length; i++)
    bitArray[i] = new Bit(width*0.1+i*width*0.9/bitArray.length, 30+width*0.9/bitArray.length/2, width*0.9/bitArray.length);
}

void draw() {
  background(150);
  for (int i = 0; i < bitArray.length; i++)
    bitArray[i].display();

  fill(unbinary(bitArrayToString(bitArray)) != 0 ? 255 : 0);  

  autoTextSize(str(unbinary(bitArrayToString(bitArray))), width*0.9, (height-60-width*0.9/bitArray.length)*0.75);
  textAlign(CENTER, BOTTOM);
  text(unbinary(bitArrayToString(bitArray)), width/2, height-30+textDescent());
}

void mouseClicked() {
  for (int i = 0; i < bitArray.length; i++)
    bitArray[i].click();
}

String bitArrayToString(Bit[] bitA) {
  String bitS = "";
  for (int i = 0; i < bitA.length; i++)
    bitS+= bitA[i].on ? "1" : "0";

  return bitS;
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
