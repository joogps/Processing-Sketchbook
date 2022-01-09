float radius;
Arc[] arcs;

float[] fill;
int currentFill = 0;

void setup() {
  size(640, 360);
  pixelDensity(displayDensity());

  radius = min(width, height)/2.0*0.55;
  arcs = new Arc[5];

  for (int i = 0; i < arcs.length; i++)
    arcs[i] = new Arc(radius*i/float(arcs.length-1));

  fill = new float[arcs.length];
}

void draw() {
  background(255);

  translate(width/2.0, height/2.0+radius);

  noFill();
  strokeWeight(10);
  for (int i = 0; i < arcs.length; i++) {
    arcs[i].update(fill[i]);
    arcs[i].display();
  }

  if (abs(fill[currentFill]) > 0.95 && currentFill < fill.length-1)
    currentFill++;

  for (int i = currentFill; i >= 0; i--)
    fill[i] = lerp(fill[i], i%2 == 0 ? 1 : -1, 0.1);
}

void mouseClicked() {
  fill = new float[arcs.length];
  currentFill = 0;
}
