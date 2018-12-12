float w;

void setup() {
  size(640, 640);
}

void draw() {
  background(0);

  w = (abs(cos(frameCount/600.0*TWO_PI))+0.01)*width*2/3;

  for (float x = width/6; x < width*5/6; x+= w) {
    if (width*5/6-x >w)
      rect(x, height/6, w, height*4/6);
    else
      rect(x, height/6, width*5/6-x, height*4/6);
  }
}
