class Partition {
  PVector pos;

  float iRadius;
  float oRadius;

  float bDepth;
  float tDepth;

  float sAngle;
  float eAngle;

  color partitionColor;

  Floor floor;

  Partition(float x, float y, float z, float iR, float oR, float bD, float tD, float sA, float eA, color pColor, Floor parentFloor) {
    pos = new PVector(x, y, z);

    iRadius = iR;
    oRadius = oR;

    bDepth = bD;
    tDepth = tD;

    sAngle = sA;
    eAngle = eA;

    partitionColor = pColor;

    floor = parentFloor;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(body.angle);

    fill(color(red(partitionColor), green(partitionColor), blue(partitionColor), floor.floorAlpha));
    cylinder(iRadius, oRadius, iRadius, oRadius, bDepth, tDepth, sAngle, eAngle, 100);
    popMatrix();
  }
}
