//https://en.wikipedia.org/wiki/Spherical_coordinate_system

float radius = 200;
float radiusGoal = radius;
float previousRadius;

float zoom = -radius*2.75;

float detail = 60;

float arcDetail = 120;
float arcOffset = 0;
float arcRadius = radius;
float hueChange;

void setup() {
  size(900, 900, P3D);
  colorMode(HSB);
  resetMatrix();
}

void draw() {
  background(255);
  lights();

  fill(255);
  noStroke();

  translate(0, 0, zoom);

  sphere(radius);

  noFill();
  strokeWeight(3);
  for (int i = 0; i < arcDetail; i++) {
    float y = -arcRadius+arcRadius*2*(i/arcDetail);
    float r = sqrt(sq(arcRadius)-sq(y));

    stroke((i/arcDetail*255+hueChange)%255, 255, 255);
    beginShape();
    for (float a = 0; a <= constrain(((frameCount-arcOffset)/200.0-((i-1)/arcDetail))*TWO_PI, 0, PI); a+= PI/90.0)
      vertex(cos(a)*r, y, sin(a)*r);
    endShape();
  }

  hueChange+= 0.75;

  if (((frameCount-arcOffset)/200.0-((arcDetail-2)/arcDetail))*TWO_PI > PI) {
    radiusGoal*= 1.1;
    previousRadius = radius;
    arcOffset = frameCount;
    arcRadius = radiusGoal;
  }

  radius = lerp(radius, radiusGoal, 0.05);

  zoom = lerp(zoom, -radius*2.75, 0.025);
}
