float w;
float h;

float scale;
float erase;

void setup() {
  size(640, 360);

  w = width;
  h = height;

  colorMode(HSB);
  rectMode(CENTER);
}

void draw() {
  background(255);

  translate(width/2, height/2);
  scale(scale);

  noStroke();

  int iterations = floor(log(scale)/log(w > h ? w/h : h/w));
  for (int i = (iterations > 10 ? iterations-10 : 0); i < iterations+15; i++) {
    fill(i/10.0*255%255, 255, 255, 50);
    pushMatrix();
    rotate(TWO_PI*i/30.0);
    rect(0, 0, dimensions(i), dimensions(i+1));
    popMatrix();
  }

  if (scale < 1)
    scale+= 0.1;
  else
    scale*= 1.1;

  if (Float.isInfinite(scale))
    scale = 1;
}

float dimensions (int times) {
  if (w > h)
    return times > 0 ? dimensions(times-1)/w*h : h*2;
  else
    return times > 0 ? dimensions(times-1)/h*w : w*2;
}
