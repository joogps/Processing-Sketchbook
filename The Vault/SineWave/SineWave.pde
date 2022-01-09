ArrayList<PVector> positions;

float theta;
float increase;

float period;
float amp;

void setup() {
  fullScreen();
  positions = new ArrayList<PVector>();

  theta = 0;
  increase = 0.01;

  period = 500;
  amp = height/2;
}

void draw() {
  increase = map(mouseX, 0, width, 0, QUARTER_PI);
  theta+= increase;
  
  positions.add(new PVector(width - height, sin(theta) * amp));

  background(130);
  amp = abs(mouseY - height/2);
  
  pushMatrix();
  translate(width-height/2, height/2);

  stroke(0);
  arc(0, 0, amp*2, amp*2, 0, theta % TWO_PI, PIE);
  line(cos(theta) * (amp) + 0/2, sin(theta) * (amp), positions.get(positions.size()-1).x - (width - height/2), positions.get(positions.size()-1).y);

  line(-height/2, -height/2, -height/2, height/2);

  stroke(255, 0, 0);
  line(0, 0, cos(theta) * amp, sin(theta) * amp);

  stroke(0, 255, 0);
  line(0, 0, 0, sin(theta) * amp);
  
  stroke(0, 0, 255);
  line(0, 0, cos(theta) * amp, 0);
  popMatrix();

  pushMatrix();
  translate(0, height/2);
  
  stroke(0);
  beginShape();
  for (int i = 0; i< positions.size(); i++) {
    vertex(positions.get(i).x, positions.get(i).y);
  }
  endShape(CLOSE);
  popMatrix();

  for (int i = 0; i< positions.size(); i++) {
    if (positions.get(i).x < 0) {
      positions.remove(i);
    } else {
      positions.set(i, new PVector(positions.get(i).x - ((TWO_PI / period) + 1), positions.get(i).y));
    }
  }
}
