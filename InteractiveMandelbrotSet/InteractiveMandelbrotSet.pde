PVector pos;
float scale;

int iterations;

void setup() {
  size(500, 600);
  colorMode(HSB);

  pos = new PVector(0, 0);
  scale = 1;

  iterations = 100;
}

void draw() {
  background(0);

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {
      float a = map(x, 0, width, -2*scale, 1*scale)+pos.x;
      float b = map(y, 0, width, -1.325*scale, 1.325*scale)+pos.y;

      float complexA = a;
      float complexB = b;

      int i = 0;

      while (i < iterations) {
        float aSquared = sq(a)-sq(b);
        float bSquared = 2*a*b;

        a = aSquared+complexA;
        b = bSquared+complexB;

        if (sq(a)+sq(b) > 4)
          break;

        i++;
      }

      pixels[x+y*width] = color(sqrt(i/float(iterations))*255, 255, i == iterations || i == 0 ? 0 : 255);
    }
  }
  updatePixels();

  stroke(255);
  line(width*0.1, height-(height-width)/2.0, width*0.9, height-(height-width)/2.0);

  fill(0);
  ellipse(width*0.1+width*0.8*iterations/500.0, (width+height)/2.0, 20, 20);

  if (mousePressed && mouseX > width*0.1 && mouseX < width*0.9 && mouseY > (width+height)/2.0-10 && mouseY < (width+height)/2.0+10)
    iterations = round((mouseX-width*0.1)/(width*0.8)*500);

  println(pos.x, pos.y);
}

void mouseDragged() {
  if (mouseY < width) {
    if (abs(pos.x) <= 3)
      pos.x+= (pmouseX-mouseX)/100.0*scale;
    else
      pos.x = round(pos.x/3.0)*3;

    if (abs(pos.y) <= 2.7)
      pos.y+= (pmouseY-mouseY)/100.0*scale;
    else
      pos.y = round(pos.y/2.7)*2.7;
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() < 0)
    scale/= 2;
  else if (scale < 1)
    scale*= 2;
}
