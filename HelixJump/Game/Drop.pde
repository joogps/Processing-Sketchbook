class Drop {
  PVector pos;

  float size;
  float detail = 1;

  float alpha = 255*1.5;

  float angle;

  float noiseOff;

  Drop(float x, float y, float z, float bodyAngle) {
    pos = new PVector(x, y, z);
    angle = bodyAngle;

    size = random(15, 25);
    noiseOff = random(0, 1000);
  }

  void display() {
    noStroke();
    fill(red(body.ball.ballColor), green(body.ball.ballColor), blue(body.ball.ballColor), alpha);

    pushMatrix();
    rotate(body.angle - angle);
    translate(pos.x, pos.y, pos.z);

    beginShape();
    for (float i = 0; i < TWO_PI; i+= TWO_PI/628) {
      float noise = map(noise(cos(i)*detail + noiseOff, sin(i)*detail + noiseOff), 0, 1, 0, size);
      vertex(cos(i) * noise, sin(i) * noise);
    }
    endShape();
    popMatrix();
  }

  void kill() {
    alpha = lerp(alpha, 0, 0.02);
  }
}
