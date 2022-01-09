class Ball {
  PVector pos;
  PVector vel;

  float radius;

  float leftSide;
  float rightSide;

  color ballColor;

  boolean insidePartition;

  boolean move;
  boolean dead;
  boolean finished;

  int initialFrame;

  float velTriangleLerp;

  int maxVelInARow;

  Ball(float x, float y, float z, color bodyColor) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, -1);

    radius = 15;

    leftSide = atan2(pos.x-radius, pos.y);
    rightSide = atan2(pos.x+radius, pos.y);

    ballColor = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));

    move = false;
    dead = false;

    initialFrame = frameCount;

    velTriangleLerp = 0;
  }

  void display() {
    fill(ballColor);

    pushMatrix();
    translate(pos.x, pos.y, pos.z);

    sphere(radius);

    if (move) {
      fill(red(ballColor), green(ballColor), blue(ballColor), maxVelInARow*1.5);
      beginShape();
      vertex(cos(leftSide+HALF_PI) * pos.y, -radius/2, 0);
      vertex(cos(rightSide+HALF_PI) * pos.y, -radius/2, 0);
      vertex(0, -radius/2, velTriangleLerp);
      endShape();
    }

    popMatrix();
  }

  void update() {
    if (!dead && !finished) {
      pos.add(vel);

      if (move) {
        vel.add(new PVector(0, 0, -0.25));
        vel.limit(8 + (maxVelInARow > 70 ? constrain(maxVelInARow/20, 0, 3.5) : 0));
        if (vel.z <= -8)
          maxVelInARow++;

        velTriangleLerp = lerp(velTriangleLerp, maxVelInARow, 0.025);
      } else
        vel.z = cos(TWO_PI * (frameCount - initialFrame) / 180) * 2;

      if ((keyPressed || mousePressed) && !move)
        move = true;
    }

    if (finished || dead) {
      body.focus = lerp(body.focus, 80, 0.06);
      velTriangleLerp = lerp(velTriangleLerp, 0, 0.1);
    }
  }

  void collide(Floor floor) {
    Partition[] mains = floor.mains;
    Partition[] kills = floor.kills;

    float l = atan2(cos(leftSide), sin(leftSide));
    float r = atan2(cos(rightSide), sin(rightSide));

    if (kills != null) {
      for (int i = 0; i < kills.length; i++) {
        Partition kill = kills[i];
        float kS = abs(atan2(sin(kill.sAngle + body.angle), cos(kill.sAngle + body.angle)));
        float kE = abs(atan2(sin(kill.eAngle + body.angle), cos(kill.eAngle + body.angle)));

        boolean bool = kill.eAngle - kill.sAngle < PI ? (kE > r && l > kS && kE > kS) : !(kE < r && l < kS && kS > kE);

        if (pos.z - radius < kill.pos.z + kill.tDepth && pos.z + radius > kill.pos.z - kill.bDepth && bool) {
          pos.z = pos.z > kill.pos.z ? kill.pos.z + kill.tDepth + radius : kill.pos.z - kill.bDepth - radius;

          if (maxVelInARow > 70) {    
            floor.kill = true;
            hud.score++;

            vel.z*= -1;

            scoreSound.rewind();
            scoreSound.play();
          } else {
            dead = true;

            deathSound.rewind();
            deathSound.play();
          }

          maxVelInARow = 0;
        }
      }
    }

    if (!floor.isFinal) {
      for (int i = 0; i < mains.length; i++) {
        Partition main = mains[i];

        float mS = abs(atan2(sin(main.sAngle + body.angle), cos(main.sAngle + body.angle)));
        float mE = abs(atan2(sin(main.eAngle + body.angle), cos(main.eAngle + body.angle)));

        boolean mBool = main.eAngle - main.sAngle < PI ? (mE > r && l > mS && mE > mS) : !(mE < r && l < mS && mS > mE);

        if (pos.z - radius < main.pos.z + main.tDepth && pos.z + radius > main.pos.z - main.bDepth) {
          if (mBool) {
            vel.z*= -1;

            if (pos.z - radius > main.pos.z) {
              pos.z = pos.z > main.pos.z ? main.pos.z + main.tDepth + radius : main.pos.z - main.bDepth - radius;

              body.pSystem.add(new Particle[round(random((main.eAngle - main.sAngle < PI ? (mE > HALF_PI && HALF_PI > mS && mE > mS) : !(mE < HALF_PI && HALF_PI < mS && mS > mE)) ? 2 : 1, (main.eAngle - main.sAngle < PI ? (mE > HALF_PI && HALF_PI > mS && mE > mS) : !(mE < HALF_PI && HALF_PI < mS && mS > mE)) ? 5 : 3))]);
              for (int j = 0; j < body.pSystem.get(body.pSystem.size()-1).length; j++) {
                body.pSystem.get(body.pSystem.size()-1)[j] = new Particle(0, pos.y, pos.z > main.pos.z ? pos.z-radius : pos.z+radius, body.angle);
              }

              if (main.eAngle - main.sAngle < PI ? (mE > HALF_PI && HALF_PI > mS && mE > mS) : !(mE < HALF_PI && HALF_PI < mS && mS > mE)) {
                body.drops.add(new Drop(0, pos.y, main.pos.z+main.tDepth+1, body.angle));
              }

              for (int j = 0; j < jumpSounds.length; j++)
                jumpSounds[j].rewind();

              jumpSounds[round(random(0, jumpSounds.length-1))].play();
            }

            pos.z = pos.z > main.pos.z ? main.pos.z + main.tDepth + radius : main.pos.z - main.bDepth - radius;

            if (maxVelInARow > 70) {
              floor.kill = true;
              floor.over = true;
            }

            maxVelInARow = 0;
          } else if (!floor.over && pos.z - radius < main.pos.z - main.bDepth) {
            hud.score++;
            floor.over = true;

            scoreSound.rewind();
            scoreSound.play();
          }
        }
      }
    } else if (pos.z - radius < mains[0].pos.z + mains[0].tDepth && pos.z + radius > mains[0].pos.z - mains[0].bDepth && !finished) {
      pos.z = pos.z > mains[0].pos.z ? mains[0].pos.z + mains[0].tDepth + radius : mains[0].pos.z - mains[0].bDepth - radius;

      body.pSystem.add(new Particle[round(random(8, 12))]);
      for (int j = 0; j < body.pSystem.get(body.pSystem.size()-1).length; j++) {
        body.pSystem.get(body.pSystem.size()-1)[j] = new Particle(0, pos.y, pos.z > mains[0].pos.z ? pos.z-radius : pos.z+radius, body.angle);
      }

      finished = true;

      endSound.rewind();
      endSound.play();
    }
  }
}
