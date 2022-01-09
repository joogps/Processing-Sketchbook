ArrayList<Float> wave;
int terms;

float size;

String[] modes = {"SQUARE", "SAWTOOTH"};
int mode = 0;

void setup() {
  size(900, 510);

  wave = new ArrayList<Float>();
  terms = 1;

  for (int i = 1; i <= terms; i++)
    size+= abs(1/formula(i));

  size = (height-150)*13/16.0*(1/size);
}

void draw() {
  background(255);
  pushMatrix();
  translate((height-150)/2, (height-150)/2);

  float totalSin = 0;

  noFill();
  for (int i = 1; i <= terms; i++) {
    float cos = cos(-frameCount/300.0*formula(i)*TWO_PI);
    float sin = sin(-frameCount/300.0*formula(i)*TWO_PI);

    ellipse(0, 0, size/formula(i), size/formula(i));
    line(0, 0, cos*size/2/formula(i), sin*size/2/formula(i));

    translate(cos*size/2/formula(i), sin*size/2/formula(i));

    totalSin+= sin/formula(i);
  }
  popMatrix();

  wave.add(totalSin);

  for (int i = 0; i < wave.size(); i++)
    line(width-i, (height-150)/2+wave.get(i)*size/2.0, width-i-(i < wave.size()-1 ? 1 : 0), (height-150)/2+wave.get(i < wave.size()-1 ? i+1 : i)*size/2.0);

  if (wave.size() >= width-(height-100))
    wave.remove(0);

  line(width*0.1, height-112.5, width*0.9, height-112.5);

  fill(255);
  ellipse(width*0.1+(terms-1)/50.0*width*0.8, height-112.5, 30, 30);

  if (mouseX > width*0.1 && mouseX < width*0.9 && mouseY > height-127.5 && mouseY < height-97.5 && mousePressed) {
    terms = int((mouseX-width*0.1)/(width*0.8)*50)+1;

    size = 0;

    for (int i = 1; i <= terms; i++)
      size+= abs(1/formula(i));

    size = (height-150)*13/16.0*(1/size);
  }

  float spacing = modes.length > 1 ? 50/(float(modes.length)-1) : 0;
  for (int i = 0; i < modes.length; i++) {
    fill(mode == i ? 0 : 255);
    rect(width*0.1+(width*0.8+spacing)/modes.length*i, height-75, (width*0.8-spacing)/modes.length, 50);

    fill(mode == i ? 255 : 0);
    textAlign(CENTER, CENTER);
    text(modes[i], width*0.1+(width*0.8+spacing)/modes.length*i+(width*0.8-spacing)/modes.length/2, height-50);

    if (mouseX > width*0.1+(width*0.8+spacing)/modes.length*i && mouseY > height-75 && mouseX < width*0.1+(width*0.8+spacing)/modes.length*i+(width*0.8-spacing)/modes.length && mouseY < height-25 && mousePressed)
      mode = i;
  }
}

float formula (int term) {
  if (mode == 0)
    return term*2-1;
  else if (mode == 1)
    return term%2 == 0? term : -term;

  return term;
}
