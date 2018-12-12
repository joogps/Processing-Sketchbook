import peasy.*;
PeasyCam cam;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(50);
  lights();

  rotateX(QUARTER_PI * 1.4);

  noStroke();
  fill(255);

  cylinder(0, 50, 0, 50, height/2, height/2, 0, TWO_PI, 100);
}

void cylinder(float innerWidth, float outerWidth, float innerHeight, float outerHeight, float bottomDepth, float topDepth, float startAngle, float endAngle, float definition) {
  beginShape(QUAD_STRIP);
  for (float i = startAngle; i <= endAngle+0.01; i+= ((endAngle - startAngle)/definition)) {
    float px = cos(i) * outerWidth;
    float py = sin(i) * outerHeight;

    vertex(px, py, abs(topDepth));
    vertex(px, py, -abs(bottomDepth));
  }
  endShape(CLOSE);

  beginShape(QUAD_STRIP); 
  for (float i = startAngle; i <= endAngle+0.01; i+= ((endAngle - startAngle)/definition)) {
    float px = cos(i) * innerWidth;
    float py = sin(i) * innerHeight;

    vertex(px, py, abs(topDepth));
    vertex(px, py, -abs(bottomDepth));
  }
  endShape(CLOSE);

  if (endAngle != TWO_PI) {
    for (int i = 0; i < 2; i++) {
      beginShape();
      vertex(cos(i == 0 ? startAngle : endAngle+0.01) * innerWidth, sin(i == 0 ? startAngle : endAngle+0.01) * innerHeight, abs(topDepth));
      vertex(cos(i == 0 ? startAngle : endAngle+0.01) * innerWidth, sin(i == 0 ? startAngle : endAngle+0.01) * innerHeight, -abs(bottomDepth));
      vertex(cos(i == 0 ? startAngle : endAngle+0.01) * outerWidth, sin(i == 0 ? startAngle : endAngle+0.01) * outerHeight, -abs(bottomDepth));
      vertex(cos(i == 0 ? startAngle : endAngle+0.01) * outerWidth, sin(i == 0 ? startAngle : endAngle+0.01) * outerHeight, abs(topDepth));
      endShape(CLOSE);
    }
  }

  if (innerWidth == 0 && innerHeight == 0)
    beginShape();
  else
    beginShape(QUAD_STRIP);

  for (float i = startAngle; i <= endAngle+0.01; i+= ((endAngle - startAngle)/definition)) {
    float p1x = cos(i) * innerWidth;
    float p1y = sin(i) * innerHeight;

    float p2x = cos(i) * outerWidth;
    float p2y = sin(i) * outerHeight;

    if (innerWidth > 0 && innerHeight > 0)
      vertex(p1x, p1y, abs(topDepth));

    vertex(p2x, p2y, abs(topDepth));
  }
  endShape(CLOSE); 

  if (innerWidth == 0 && innerHeight == 0)
    beginShape();
  else
    beginShape(QUAD_STRIP);

  for (float i = startAngle; i <= endAngle+0.01; i+= ((endAngle - startAngle)/definition)) {
    float p1x = cos(i) * innerWidth;
    float p1y = sin(i) * innerHeight;

    float p2x = cos(i) * outerWidth;
    float p2y = sin(i) * outerHeight;

    if (innerWidth > 0 && innerHeight > 0) 
      vertex(p1x, p1y, -abs(bottomDepth));

    vertex(p2x, p2y, -abs(bottomDepth));
  }
  endShape(CLOSE);
}
