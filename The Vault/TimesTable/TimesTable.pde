PVector[] positions;
float radius = 150;
float times = 1;

void setup() {
  size(640, 360);
  colorMode(HSB);

  positions = new PVector[200];
  for (int i = 0; i < positions.length; i++)
    positions[i] = new PVector(cos(float(i)/positions.length*TWO_PI)*radius, sin(float(i)/positions.length*TWO_PI)*radius);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotate(float(frameCount%600)/600*TWO_PI);
  
  stroke((times-1)*10%255, 255, 255);
  for (int i = 0; i < positions.length; i++)
    line(positions[i].x, positions[i].y, positions[round(i*times)%positions.length].x, positions[round(i*times)%positions.length].y);

  times+= 0.001*times;
}
