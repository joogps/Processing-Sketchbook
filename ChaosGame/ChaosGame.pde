PVector[] points;
ArrayList<PVector> random;

void setup() {
  size(460, 620);

  points = new PVector[3];
  for (int i = 0; i < points.length; i++)
    points[i] = new PVector(cos(i*TWO_PI/float(points.length)-HALF_PI)*width/3.0, sin(i*TWO_PI/float(points.length)-HALF_PI)*width/3.0);

  random = new ArrayList<PVector>();
  random.add(points[round(random(points.length-1))]);
}

void draw() {
  background(0);

  stroke(255);
  translate(width/2, width/2);

  for (int i = 0; i < random.size(); i++)
    point(random.get(i).x, random.get(i).y);

  for (int i = 0; i < 100 && random.size() < 10000; i++) {
    PVector point = points[round(random(points.length-1))];
    PVector current = random.get(random.size()-1);

    random.add(new PVector((point.x+current.x)/2.0, (point.y+current.y)/2.0));
  }

  resetMatrix();
  line(width*0.1, (width+height)/2, width*0.9, (width+height)/2);

  fill(0);
  ellipse(width*0.1+(points.length-3)/10.0*width*0.8, (height+width)/2, 20, 20); 

  if (mousePressed && points.length != 3+round((mouseX-width*0.1)/(width*0.8)*10) && mouseX > width*0.1 && mouseX < width*0.9 && mouseY > (width+height)/2.0-10 && mouseY < (width+height)/2.0+10) {
    points = new PVector[3+round((mouseX-width*0.1)/(width*0.8)*10)];
    for (int i = 0; i < points.length; i++)
      points[i] = new PVector(cos(i*TWO_PI/float(points.length)-HALF_PI)*width/3.0, sin(i*TWO_PI/float(points.length)-HALF_PI)*width/3.0);

    random = new ArrayList<PVector>();
    random.add(points[round(random(points.length-1))]);
  }
}
