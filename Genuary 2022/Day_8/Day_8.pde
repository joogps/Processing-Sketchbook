float animation = 0;

void setup() {
  size(540, 540);
  pixelDensity(displayDensity());
  background(0);
}

void draw() {
  fill(0, 150);
  noStroke();
  rect(0, 0, width, height);
  
  noFill();
  color[] set1  = {  
    color(36, 37, 27), color(195, 147, 66), color(91, 158, 59), color(214, 208, 88), color(138, 212, 237)
  };
  
  color[] set2  = {  
    color(24, 12, 90), color(46, 21, 136), color(79, 32, 185), color(146, 47, 183), color(227, 151, 178)
  };

  for(float i = 0; i <= 1; i+= 1/100.0) {
    float theta = (animation+i)*TWO_PI;
    color fill = lerpColors(i, set2);
    
    stroke(fill);
    fill(fill, i*25);
    //float radius = 25+abs(cos((animation+(i/5.0))*TWO_PI)*125);
    //float radius = 25+cos((animation+(i/5.0))*TWO_PI)*125;
    float radius = 100+cos((animation+(i/5.0))*TWO_PI)*100;
    //float radius = 50+cos((animation+i)*2*TWO_PI)*100;
    ellipse(width/2+cos(theta)*radius, height/2+sin(theta)*radius, 50*i, 50*i);
  }
  
  animation = frameCount/100.0;
  
  saveFrame("frames/####.png");
  if (frameCount >= 100) {
    stop();
  }
  
}

color lerpColors(float amt, color... colors) {
  if(colors.length==1){ return colors[0]; }
  float cunit = 1.0/(colors.length-1);
  return lerpColor(colors[floor(amt / cunit)], colors[ceil(amt / cunit)], amt%cunit/cunit);
}
