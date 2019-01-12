int petals;
float radius;
float amplitude;

color[] colors = {color(254, 99, 91), color(250, 170, 13), color(253, 203, 1), color(21, 191, 8), color(32, 150, 252), color(194, 109, 233)};

void setup() {
  size(640, 640);

  petals = 6;
  radius = width*0.4;
  amplitude = 0;

  if (colors.length != petals)
    colorMode(HSB);
}

void draw() {
  background(240);

  translate(width/2, height/2);
  rotate(frameCount/115.0*TWO_PI);
  for (int i = 0; i < petals; i++) {
    if (colors.length == petals)
      fill(colors[i]);
    else
      fill((1-i/float(petals))*255, 255, 255);
    noStroke();

    beginShape();
    for (float r = 0; r < radius; r++)
      vertex(cos(TWO_PI*i/float(petals)+abs(cos(r/radius*HALF_PI))*TWO_PI/float(petals)*amplitude)*r, sin(TWO_PI*i/float(petals)+abs(cos(r/radius*HALF_PI))*TWO_PI/float(petals)*amplitude)*r);

    for (float a = 0; a < TWO_PI/float(petals); a+= 0.001)
      vertex(cos(TWO_PI*i/float(petals)+a)*radius, sin(TWO_PI*i/float(petals)+a)*radius);

    for (float r = radius; r > 0; r--)
      vertex(cos(TWO_PI*(i+1)/float(petals)+abs(cos(r/radius*HALF_PI))*TWO_PI/float(petals)*amplitude)*r, sin(TWO_PI*(i+1)/float(petals)+abs(cos(r/radius*HALF_PI))*TWO_PI/float(petals)*amplitude)*r);
    endShape(CLOSE);
  }

  amplitude = frameCount/300.0;
}
