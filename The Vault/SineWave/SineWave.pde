ArrayList<PVector> positions;

float theta;
float increase;

float amp;

void setup() {
  size(720, 360);
  positions = new ArrayList<PVector>();
  pixelDensity(displayDensity());

  theta = 0;
  increase = 0.01;

  amp = height/2;
  
  frameRate(60);
  smooth(20);
}

void draw() {
  increase = QUARTER_PI*0.03;
  theta+= increase;
  
  positions.add(new PVector(width - height, sin(theta) * amp));

  background(255);
  amp = abs(height/4);
  
  pushMatrix();
  translate(height/2, height/2);

  strokeWeight(10);
  noFill();
  stroke(200);
  
  line(cos(theta) * amp, sin(theta) * amp, positions.get(positions.size()-1).x-height/2, positions.get(positions.size()-1).y);
  
  stroke(0);
  
  arc(0, 0, amp*2, amp*2, 0, theta % TWO_PI, ARC);
  popMatrix();

  pushMatrix();
  translate(0, height/2);
  
  stroke(0);
  beginShape();
  for (int i = 0; i< positions.size(); i++) {
    vertex(positions.get(i).x, positions.get(i).y);
  }
  endShape();
  popMatrix();

  for (int i = 0; i< positions.size(); i++) {
    if (positions.get(i).x < 0) {
      positions.remove(i);
    } else {
      positions.set(i, new PVector(positions.get(i).x + 1, positions.get(i).y));
    }
  }
  
  saveFrame("frames/####.png");
}
