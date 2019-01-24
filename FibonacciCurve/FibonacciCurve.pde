float phi = (1+sqrt(5))/2.0;

void setup() {
  size(680, 420);
}

void draw() {
  background(255);
  fibonacci(width, height, abs(round(sin(frameCount/600.0*TWO_PI)*10)));
}

void fibonacci(float w, float h, int level) {
  fill(255);
  rect(0, 0, w, h);

  noFill();
  arc(w*(phi-1), h, w*(phi-1)*2, h*2, PI, PI*1.5);

  if (level > 0) {
    translate(w, 0);
    rotate(HALF_PI);
    fibonacci(h, w*(-phi+2), level-1);
  }
}
