int columns = 25;
int rows = 25;

float hue;
PVector speed;

void setup() {
  size(640, 1040);
  colorMode(HSB);

  hue = 0;
  speed = new PVector(0.1, 0.1);
}

void draw() {
  background(255);

  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      color c = color(hue, 255, noise(x/float(columns)+frameCount*speed.x, y/float(rows)+frameCount*speed.y)*255);

      fill(c);
      stroke(c);

      triangle(x*width/float(columns), y*width/float(rows), (x+1)*width/float(columns), y*width/float(rows), x*width/float(columns), (y+1)*width/float(rows));

      c = color(hue, 255, noise((x+0.5)/float(columns)+frameCount*speed.x, (y+0.5)/float(rows)+frameCount*speed.y)*255);

      fill(c);
      stroke(c);

      triangle(x*width/float(columns), (y+1)*width/float(rows), (x+1)*width/float(columns), y*width/float(rows), (x+1)*width/float(columns), (y+1)*width/float(rows));
    }
  }

  for (int i = 0; i < 5; i++) {
    stroke(hue, 255, 255);

    line(width/10.0, width+(height-width)/5.0*(i+0.5), width*9/10.0, width+(height-width)/5.0*(i+0.5));

    float fraction = i == 0 ? columns/50.0 : i == 1 ? rows/50.0 : i == 2 ? hue/255.0 : i == 3 ? speed.x : speed.y;
    fill(255);
    ellipse(width/10.0+width*4/5.0*fraction, width+(height-width)/5.0*(i+0.5), 30, 30);

    if (mousePressed && mouseX > width/10.0 && mouseX < width*9/10.0 && mouseY > width+(height-width)/5.0*(i+0.5)-15 && mouseY < width+(height-width)/5.0*(i+0.5)+15) {
      fraction = (mouseX-width/10.0)/(width*8/10.0);

      if (i == 0)
        columns = constrain(round(fraction*50), 1, 50);
      else if (i == 1)
        rows = constrain(round(fraction*50), 1, 50);
      else if (i == 2)
        hue = fraction*255;
      else if (i == 3)
        speed.x = fraction;
      else
        speed.y = fraction;
    }
  }
}
