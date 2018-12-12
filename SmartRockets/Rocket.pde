class Rocket {
  PVector pos;
  PVector vel;

  DNA dna;

  int index;

  float score;
  boolean stop;

  Rocket(DNA d) {
    pos = new PVector(width/2, height-50*1.5);
    vel = new PVector(0, -1);

    dna = d;
  }


  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-atan2(vel.x, vel.y));

    fill(map(score, 0, 1, 0, 255));
    noStroke();

    rectMode(CENTER);
    rect(0, 0, 10, 50);
    popMatrix();
  }

  void update() {
    if (!stop) {
      pos.add(vel);

      if (index < dna.genes.length) {
        vel.add(dna.genes[index]);
        index++;
      } else
        rockets.recreate();

      float[] distances = {dist(0, 0, target.pos.x, target.pos.y), dist(width, 0, target.pos.x, target.pos.y), dist(width, height, target.pos.x, target.pos.y), dist(width, height, target.pos.x, target.pos.y)};
      float maximumDistance = max(distances);


      score = map(dist(pos.x, pos.y, target.pos.x, target.pos.y), 0, maximumDistance, 1, 0);
    }
  }

  void collide() {
    if (!stop) {
      if (dist(pos.x, pos.y, target.pos.x, target.pos.y) < target.size/2) {
        stop = true;
        score*= (3+index/10);

        targetReached++;
      }

      if (pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height) {
        stop = true;
        score/= 1.5;
      }

      for (int i = 0; i < barriers.length; i++) {
        if (pos.x > barriers[i].pos.x-barriers[i].w/2 && pos.x < barriers[i].pos.x+barriers[i].w/2 && pos.y > barriers[i].pos.y-barriers[i].h/2 && pos.y < barriers[i].pos.y+barriers[i].h/2) {
          stop = true;
          score = map(dist(pos.x, pos.y, barriers[i].pos.x, barriers[i].pos.y), 0, dist(barriers[i].pos.x, barriers[i].pos.y, barriers[i].pos.x-barriers[i].w/2, barriers[i].pos.y-barriers[i].h/2), 0, 0.25);
        }
      }
    }
  }
}
