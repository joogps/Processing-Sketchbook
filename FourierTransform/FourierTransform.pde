ArrayList<Float> wave;

float frequency;
float terms;

void setup() {
  size(860, 520);
  wave = new ArrayList<Float>();

  frequency = 0.1;
  terms = 0.9;
}

void draw() {
  float sine = 0;
  background(255);

  pushMatrix();
  translate((width-500)/2, (height-160)/2);
  ellipse(0, 0, (width-500)/2, (height-160)/2);

  for (int i = 0; i < terms*250.0; i++) {
    float cos = cos(frameCount/6.0*frequency*TWO_PI*(i*2+1))/(i*2+1)*(width-500)/4.0;
    float sin = sin(frameCount/6.0*frequency*TWO_PI*(i*2+1))/(i*2+1)*(height-160)/4.0;

    translate(cos, sin);
    ellipse(0, 0, (width-500)/2/(i*2+3), (height-160)/2/(i*2+3));

    sine+= sin;
  }

  popMatrix();

  wave.add(sine);

  noFill();
  beginShape();
  for (int i = 0; i < wave.size(); i++)
    vertex(width-i, (height-160)/2+wave.get(i));
  endShape();

  if (wave.size() > width-(height-160))
    wave.remove(0);

  for (int i = 0; i < 2; i++) {
    line(width/10.0, height*4/6.0+height/6.0*i, width*9/10.0, height*4/6.0+height/6.0*i);

    float fraction = i == 0 ? frequency : terms;
    fill(255);
    ellipse(width/10.0+width*4/5.0*fraction, height*4/6.0+height/6.0*i, 30, 30);

    if (mousePressed && mouseX > width/10.0 && mouseX < width*9/10.0 && mouseY > height*4/6.0+height/6.0*i-15 && mouseY < height*4/6.0+height/6.0*i+15) {
      fraction = (mouseX-width/10.0)/(width*8/10.0);

      if (i == 0)
        frequency = fraction;
      else
        terms = fraction;
    }
  }
}
