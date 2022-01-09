class Floor {
  Partition[] mains;
  Partition[] kills;

  boolean over;
  float floorAlpha;
  boolean isFinal;
  boolean kill;

  Floor(float x, float y, float z, color bodyColor, float limit, boolean _isFinal) {
    isFinal = _isFinal;

    if (!isFinal) {
      mains = new Partition[round(random(1, 5))];
      for (int i = 0; i < mains.length; i++) {
        float mainSAngle = random(0, TWO_PI);
        float mainEAngle = mainSAngle + random(limit, constrain(TWO_PI / mains.length, 0, TWO_PI - mainSAngle - limit * random(1.1, 1.5) * mains.length));

        int outside = 0;
        while (outside < i) {
          outside = 0;

          mainSAngle = random(0, TWO_PI);
          mainEAngle = mainSAngle + random(limit, constrain(TWO_PI / mains.length, 0, TWO_PI - mainSAngle - limit * random(1.1, 1.5) * mains.length));

          for (int j = 0; j < i; j++) {
            outside+= mainSAngle < mains[j].eAngle && mainEAngle > mains[j].sAngle ? 0 : 1;
          }
        }

        mains[i] = new Partition(x, y, z, 50, 100, 10, 10, mainSAngle, mainEAngle, bodyColor, this);
      }

      kills = new Partition[round(random(mains.length/4, mains.length))];
      for (int i = 0; i < kills.length; i++) {
        float size = random(limit, PI/kills.length);
        float killSAngle = random(0, TWO_PI);
        float killEAngle = killSAngle + size;

        int outside = 0;
        while (outside < i) {
          outside = 0;

          size = random(limit, TWO_PI * (1/kills.length/(mains.length/2)));
          killSAngle = random(0, TWO_PI);
          killEAngle = killSAngle + size;

          for (int j = 0; j < i; j++) {
            outside+= killSAngle < kills[j].eAngle && killEAngle > kills[j].sAngle ? 0 : 1;
          }
        }

        kills[i] = new Partition(x, y, z, 50, 102, 0, 12, killSAngle, killEAngle, color(255 - brightness(bodyColor)), this);
      }
    } else {
      mains = new Partition[1];
      mains[0] = new Partition(x, y, z, 50, 100, height, 10, 0, TWO_PI, color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor)), this);
    }

    over = false;

    floorAlpha = 255;
  }

  void display() {
    for (int i = 0; i < mains.length; i++) {
      mains[i].display();
    }
    for (int i = 0; kills != null && i < kills.length; i++) {
      kills[i].display();
    }
  }

  void die() {
    floorAlpha = lerp(floorAlpha, 0, 0.15);
  }
}
