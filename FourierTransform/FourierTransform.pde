ArrayList<Float> wave;

void setup() {
  size(860, 360);
  wave = new ArrayList<Float>();
}

void draw() {
  float sine = 0;
  background(255);

  pushMatrix();
  translate((width-500)/2, height/2);
  ellipse(0, 0, (width-500)/2, height/2);

  for (int i = 1; i < 10; i++) {
    translate(cos(frameCount/(i*60.0)*TWO_PI)*((width-500)/(i*4)), sin(frameCount/(i*60.0)*TWO_PI)*(height/(i*4)));
    ellipse(0, 0, (width-500)/(i*4), height/(i*4));

    sine+= sin(frameCount/(i*60.0)*TWO_PI);
  }
  popMatrix();

  wave.add(sine/9.0);

  noFill();

  beginShape();
  for (int i = 0; i < wave.size(); i++)
    vertex(width-i+(wave.size() > width-height ? wave.size()-(width-height) : 0), height/2+wave.get(i)*width/4);
  endShape();
}
