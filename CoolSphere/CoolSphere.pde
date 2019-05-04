// https://stackoverflow.com/a/26127012

float rad;

PVector[] points;

void setup() {
  size(640, 360, P3D);
  pixelDensity(displayDensity());

  rad = 100;

  points = new PVector[1000];

  float offset = 2./points.length;
  float increment = PI*(3.-sqrt(5.));
  for (int i = 0; i < points.length; i++) {
    float y = ((i*offset)-1)+(offset/2.0);
    float r = sqrt(1 - pow(y, 2));

    float phi = ((i+1)%points.length)*increment;

    float x = cos(phi)*r;
    float z = sin(phi)*r;

    points[i] = new PVector(x, y, z);
  }

  sphereDetail(15);
}

void draw() {
  background(0);

  lights();

  translate(width/2.0, height/2.0);

  rotateX(cos(frameCount/2400.0*TWO_PI)*TWO_PI);
  rotateY(cos(frameCount/3600.0*TWO_PI)*TWO_PI);
  rotateZ(cos(frameCount/4800.0*TWO_PI)*TWO_PI);


  fill(255);
  noStroke();
  for (int i = 0; i < points.length; i++) {
    PVector p = points[i];

    float x = p.x*rad;
    float y = p.y*rad;
    float z = p.z*rad;

    pushMatrix();
    translate(x, y, z);

    fill(65+i/float(points.length)*abs(cos(frameCount/276.5*TWO_PI))*255, 
      75+i/float(points.length)*abs(cos((frameCount/358.4+60)*TWO_PI))*255, 
      70+(1-i/float(points.length))*abs(sin((frameCount/98.24+240)*TWO_PI))*255);

    float r = abs(cos(((frameCount+(p.x+p.y+p.z)*60)/600.0)*TWO_PI)*5);
    sphere(r);
    popMatrix();
  }
}
