ArrayList<Float> wave;
int terms;

void setup() {
  size(900, 460);

  wave = new ArrayList<Float>();
  terms = 1;
}

void draw() {
  background(255);
  pushMatrix();
  translate((height-100)/2, (height-100)/2);

  float totalSin = 0;

  noFill();
  for (int i = 1; i <= terms; i++) {
    float cos = cos(-frameCount/300.0*(i*2-1)*TWO_PI);
    float sin = sin(-frameCount/300.0*(i*2-1)*TWO_PI);

    ellipse(0, 0, (height-100)/2/(i*2-1), (height-100)/2/(i*2-1));
    line(0, 0, cos*(height-100)/(i*2-1)/4, sin*(height-100)/(i*2-1)/4);

    translate(cos*(height-100)/(i*2-1)/4, sin*(height-100)/(i*2-1)/4);

    totalSin+= sin/(i*2-1);
  }
  popMatrix();

  wave.add(totalSin);

  for (int i = 0; i < wave.size(); i++)
    line(width-i, (height-100)/2+wave.get(i)*(height-100)/4, width-i-(i < wave.size()-1 ? 1 : 0), (height-100)/2+wave.get(i < wave.size()-1 ? i+1 : i)*(height-100)/4);

  if (wave.size() >= width-(height-100))
    wave.remove(0);

  line(width*0.1, height-50, width*0.9, height-50);

  fill(255);
  ellipse(width*0.1+(terms-1)/50.0*width*0.8, height-50, 30, 30);

  if (mouseX > width*0.1 && mouseX < width*0.9 && mouseY > height-65 && mouseY < height-35 && mousePressed)
    terms = int((mouseX-width*0.1)/(width*0.8)*50)+1;
}
