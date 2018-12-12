float outerFraction;
float innerFraction;
float penFraction;
float turns;

float outerR;
float innerR;

void setup() {
  size(640, 880);
  colorMode(HSB);

  outerFraction = 1/2.0;
  innerFraction = 1/2.0;
  penFraction = 1;
  turns = 1;
}

void draw() {
  outerR = width/2*outerFraction;
  innerR = outerR*innerFraction;

  background(0);

  pushMatrix();
  translate(width/2, (height-240)/2);

  stroke(255);
  noFill();

  beginShape();
  for (float t = 0; t < TWO_PI*turns*constrain((innerR/gcd(innerR, outerR)), 0, 100); t+= 0.025)
    vertex(cos(t)*(outerR-innerR)+cos(t*(outerR/innerR))*innerR*penFraction, sin(t)*(outerR-innerR)+sin(t*(outerR/innerR))*innerR*penFraction);
  endShape();
  popMatrix();

  for (float i = 0; i < 4; i++) {
    noFill();
    rect(width*0.15+width*0.7/3.0*i-width/20, height-240*0.9, width/10, 240*0.8);

    float fraction = (i == 0 ? outerFraction : i == 1 ? innerFraction : i == 2 ? penFraction : turns);
    fill(255);
    rect(width*0.15+width*0.7/3.0*i-width/20, height-240*0.1-240*0.8*fraction, width/10, -240*0.1-(-240*0.1-240*0.8*fraction));

    if (mouseX > width*0.15+width*0.7/3.0*i-width/20 && mouseX < width*0.15+width*0.7/3.0*i+width/20 && mouseY > height-240*0.9 && mouseY < height-240*0.1 && mousePressed) {
      fraction = 1-((mouseY-(height-240*0.9))/(240*0.8));

      if (i == 0)
        outerFraction = fraction;
      if (i == 1)
        innerFraction = fraction;
      if (i == 2)
        penFraction = fraction;
      if (i == 3)
        turns = fraction;
    }
  }
}

float gcd(float a, float b) {
  return b == 0 ? a : gcd(b, a%b);
}
