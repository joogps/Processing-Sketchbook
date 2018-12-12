void cylinder(float innerRadius, float outerRadius, float bottomDepth, float topDepth, float startAngle, float endAngle, float definition) {
  beginShape(QUAD_STRIP);
  for (float i = startAngle; i <= endAngle; i+= ((endAngle - startAngle)/definition)-0.0000001) {
    float px = cos(i) * outerRadius;
    float py = sin(i) * outerRadius;

    vertex(px, py, abs(topDepth));
    vertex(px, py, -abs(bottomDepth));
  }
  endShape();

  beginShape(QUAD_STRIP); 
  for (float i = startAngle; i <= endAngle; i+= ((endAngle - startAngle)/definition)-0.0000001) {
    float px = cos(i) * innerRadius;
    float py = sin(i) * innerRadius;

    vertex(px, py, abs(topDepth)); 
    vertex(px, py, -abs(bottomDepth));
  }
  endShape(); 

  for (int i = 0; i < 2; i++) {
    beginShape();
    vertex(cos(i == 0 ? startAngle : endAngle) * innerRadius, sin(i == 0 ? startAngle : endAngle) * innerRadius, abs(topDepth));
    vertex(cos(i == 0 ? startAngle : endAngle) * innerRadius, sin(i == 0 ? startAngle : endAngle) * innerRadius, -abs(bottomDepth));
    vertex(cos(i == 0 ? startAngle : endAngle) * outerRadius, sin(i == 0 ? startAngle : endAngle) * outerRadius, -abs(bottomDepth));
    vertex(cos(i == 0 ? startAngle : endAngle) * outerRadius, sin(i == 0 ? startAngle : endAngle) * outerRadius, abs(topDepth));
    endShape();
  }

  beginShape(QUAD_STRIP); 
  for (float i = startAngle; i <= endAngle; i+= ((endAngle - startAngle)/definition)-0.0000001) {
    float p1x = cos(i) * innerRadius;
    float p1y = sin(i) * innerRadius;

    float p2x = cos(i) * outerRadius;
    float p2y = sin(i) * outerRadius;

    vertex(p1x, p1y, abs(topDepth));
    vertex(p2x, p2y, abs(topDepth));
  }
  endShape(); 

  beginShape(QUAD_STRIP); 
  for (float i = startAngle; i <= endAngle; i+= ((endAngle - startAngle)/definition)-0.0000001) {
    float p1x = cos(i) * innerRadius;
    float p1y = sin(i) * innerRadius;

    float p2x = cos(i) * outerRadius;
    float p2y = sin(i) * outerRadius;

    vertex(p1x, p1y, -abs(bottomDepth));
    vertex(p2x, p2y, -abs(bottomDepth));
  }
  endShape();
}
