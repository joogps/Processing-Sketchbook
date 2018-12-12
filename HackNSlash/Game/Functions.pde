PVector rotateVector(PVector origin, PVector center, float angle) {
  float x = center.x+(origin.x-center.x)*cos(angle)-(origin.y-center.y)*sin(angle);
  float y = center.y+(origin.x-center.x)*sin(angle)+(origin.y-center.y)*cos(angle);

  return new PVector(x, y);
}

PVector[] extremeVectors(PVector[] corners, PVector center, float theta) {
  for (int i = 0; i < corners.length; i++) {
    corners[i] = rotateVector(corners[i], center, theta);
  }

  PVector left = center;
  PVector right = center;

  PVector up = center;
  PVector down = center;

  for (int i = 0; i < corners.length; i++) {
    if (corners[i].x < left.x)
      left = corners[i];

    if (corners[i].x > right.x)
      right = corners[i];

    if (corners[i].y < up.y)
      up = corners[i];

    if (corners[i].y > down.y)
      down = corners[i];
  }

  PVector[] extremeVectors = {left, right, up, down};

  return extremeVectors;
}

PVector collideRectEdge(PVector rectPos, float rectWidth, float rectHeight, float theta) {
  PVector[] corners = {new PVector(rectPos.x-rectWidth/2, rectPos.y-rectHeight/2), new PVector(rectPos.x+rectWidth/2, rectPos.y-rectHeight/2), new PVector(rectPos.x-rectWidth/2, rectPos.y+rectHeight/2), new PVector(rectPos.x+rectWidth/2, rectPos.y+rectHeight/2)};

  PVector[] extremeVectors = extremeVectors(corners, new PVector(rectPos.x, rectPos.y), theta);

  if (extremeVectors[0].x > width)
    return extremeVectors[0];

  if (extremeVectors[1].x < 0)
    return extremeVectors[1];

  if (extremeVectors[2].y > height)
    return extremeVectors[2];

  if (extremeVectors[3].y < 0)
    return extremeVectors[3];  

  return null;
}

float[] angleConstraints(PVector edgePos) {
  float minAngle = 0;
  float maxAngle = 0;

  if (edgePos.x < 0 && edgePos.y < 0) {
    minAngle = 0;
    maxAngle = HALF_PI;
  } else if (edgePos.x > width && edgePos.y < 0) {
    minAngle = HALF_PI;
    maxAngle = PI;
  } else if (edgePos.x < 0 && edgePos.y > height) {
    minAngle = PI*1.5;
    maxAngle = TWO_PI;
  } else if (edgePos.x > width && edgePos.y > height) {
    minAngle = PI;
    maxAngle = HALF_PI*1.5;
  } else if (edgePos.x < 0) {
    minAngle = PI*1.5;
    maxAngle = TWO_PI+HALF_PI;
  } else if (edgePos.x > width) {
    minAngle = HALF_PI;
    maxAngle = PI*1.5;
  } else if (edgePos.y < 0) {
    minAngle = 0;
    maxAngle = PI;
  } else if (edgePos.y > height) {
    minAngle = PI;
    maxAngle = TWO_PI;
  }

  float[] constraints = {minAngle, maxAngle};
  return constraints;
}

boolean collideRectCircle(PVector rectPos, float rectWidth, float rectHeight, float rectTheta, PVector circlePos, float circleSize) {
  PVector[] corners = {rotateVector(new PVector(rectPos.x-rectWidth/2, rectPos.y-rectHeight/2), new PVector(rectPos.x, rectPos.y), rectTheta), rotateVector(new PVector(rectPos.x+rectWidth/2, rectPos.y-rectHeight/2), new PVector(rectPos.x, rectPos.y), rectTheta), rotateVector(new PVector(rectPos.x+rectWidth/2, rectPos.y+rectHeight/2), new PVector(rectPos.x, rectPos.y), rectTheta), rotateVector(new PVector(rectPos.x-rectWidth/2, rectPos.y+rectHeight/2), new PVector(rectPos.x, rectPos.y), rectTheta)};

  for (int i = 0; i < corners.length; i++) {
    PVector start = corners[i];
    PVector end = corners[(i+1)%corners.length];

    float theta = atan2(end.y-start.y, end.x-start.x);

    for (int d = 0; d < dist(start.x, start.y, end.x, end.y); d++) {
      float distance = dist(circlePos.x, circlePos.y, start.x+cos(theta)*d, start.y+sin(theta)*d);
      if (distance < circleSize/2)
        return true;
    }
  }

  return false;
}

boolean collideRectRect(PVector r1Pos, float r1Width, float r1Height, float r1Theta, PVector r2Pos, float r2Width, float r2Height, float r2Theta) {
  PVector[] r1Corners = {rotateVector(new PVector(r1Pos.x-r1Width/2, r1Pos.y-r1Height/2), new PVector(r1Pos.x, r1Pos.y), r1Theta), rotateVector(new PVector(r1Pos.x+r1Width/2, r1Pos.y-r1Height/2), new PVector(r1Pos.x, r1Pos.y), r1Theta), rotateVector(new PVector(r1Pos.x+r1Width/2, r1Pos.y+r1Height/2), new PVector(r1Pos.x, r1Pos.y), r1Theta), rotateVector(new PVector(r1Pos.x-r1Width/2, r1Pos.y+r1Height/2), new PVector(r1Pos.x, r1Pos.y), r1Theta)};
  PVector[] r2Corners = {rotateVector(new PVector(r2Pos.x-r2Width/2, r2Pos.y-r2Height/2), new PVector(r2Pos.x, r2Pos.y), r2Theta), rotateVector(new PVector(r2Pos.x+r2Width/2, r2Pos.y-r2Height/2), new PVector(r2Pos.x, r2Pos.y), r2Theta), rotateVector(new PVector(r2Pos.x+r2Width/2, r2Pos.y+r2Height/2), new PVector(r2Pos.x, r2Pos.y), r2Theta), rotateVector(new PVector(r2Pos.x-r2Width/2, r2Pos.y+r2Height/2), new PVector(r2Pos.x, r2Pos.y), r2Theta)};

  for (int i = 0; i < r1Corners.length; i++) {
    PVector r1Start = r1Corners[i];
    PVector r1End = r1Corners[(i+1)%r1Corners.length];
    for (int j = 0; j < r2Corners.length; j++) {
      PVector r2Start = r2Corners[j];
      PVector r2End = r2Corners[(j+1)%r2Corners.length];

      //from http://jeffreythompson.org/collision-detection/line-line.php
      float a = ((r2End.x-r2Start.x)*(r1Start.y-r2Start.y)-(r2End.y-r2Start.y)*(r1Start.x-r2Start.x))/((r2End.y-r2Start.y)*(r1End.x-r1Start.x)-(r2End.x-r2Start.x)*(r1End.y-r1Start.y));
      float b = ((r1End.x-r1Start.x)*(r1Start.y-r2Start.y)-(r1End.y-r1Start.y)*(r1Start.x-r2Start.x))/((r2End.y-r2Start.y)*(r1End.x-r1Start.x)-(r2End.x-r2Start.x)*(r1End.y-r1Start.y));

      if (a >= 0 && a <= 1 && b >= 0 && b <= 1)
        return true;
    }
  }

  return false;
}
