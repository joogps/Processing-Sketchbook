int columns = 25;
int rows = 25;

float hue;
PVector speed;

void setup() {
  size(640, 940);
  colorMode(HSB);

  hue = 0;
  speed = new PVector(0, 0);
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

  stroke(hue, 255, 255);

  for (int i = 0; i < 3; i++) {
    line(width/10.0, width+(height-width)/4.0*(i+0.5), width*9/10.0, width+(height-width)/4.0*(i+0.5));

    float fraction = i == 0 ? columns/50.0 : i == 1 ? rows/50.0 : hue/255.0;
    fill(255);
    ellipse(width/10.0+width*4/5.0*fraction, width+(height-width)/4.0*(i+0.5), 30, 30);

    if (mousePressed && mouseX > width/10.0 && mouseX < width*9/10.0 && mouseY > width+(height-width)/4.0*(i+0.5)-15 && mouseY < width+(height-width)/4.0*(i+0.5)+15) {
      fraction = (mouseX-width/10.0)/(width*8/10.0);

      if (i == 0)
        columns = constrain(round(fraction*50), 1, 50);
      else if (i == 1)
        rows = constrain(round(fraction*50), 1, 50);
      else
        hue = fraction*255;
    }
  }

  for (int i = 0; i < 2; i++) {
    line(width/10.0+width*8/20.0*i*1.1, width+(height-width)/4.0*3.5, width/10.0+width*8/20.0*i*1.1+width*8/20*0.9, width+(height-width)/4.0*3.5);

    float fraction = i == 0 ? speed.x+0.5 : speed.y+0.5;
    fill(255);
    ellipse(width/10.0+width*8/20.0*i*1.1+width*8/20.0*0.9*fraction, width+(height-width)/4.0*3.5, 30, 30);

    if (mousePressed && mouseX > width/10.0+width*8/20.0*i*1.1 && mouseX < width/10.0+width*8/20.0*i*1.1+width*8/20.0*0.9 && mouseY > width+(height-width)/4.0*3.5-15 && mouseY < width+(height-width)/4.0*3.5+15) {
      fraction = (mouseX-(width/10.0+width*8/20.0*i*1.1))/(width*8/20.0*0.9);

      if (i == 0)
        speed.x = fraction-0.5;
      else
        speed.y = fraction-0.5;
    }
  }
}
