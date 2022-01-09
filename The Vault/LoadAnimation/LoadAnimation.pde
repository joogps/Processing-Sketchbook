float[] on;
PFont font;

void setup() {
  size(640, 360);

  on = new float[16];
  font = createFont("Nunito-Bold.ttf", 50);
}

void draw() {
  for (int y = 0; y < height; y++) {
    stroke(lerp(20, 100, float(y)/height));
    line(0, y, width, y);
  }

  fill(255, 150);

  textAlign(CENTER);
  textFont(font);

  text("Loading", width/2, height/2);

  for (int i = 0; i < on.length; i++) {
    if (on[i] == 1) {
      for (float r = 0; r < 10; r++) {
        noFill();
        stroke(255, (15-r)/15.0*50);
        ellipse(width/4+(width/2)/on.length*i, height*3/5, 10+r, 10+r);
      }
    }

    noStroke();
    fill(100+on[i]*155);

    ellipse(width/4+(width/2)/on.length*i, height*3/5, 10, 10);
  }

  for (int i = 0; i < on.length; i++)
    on[i]*= 0.85;

  on[round(frameCount/45.0*(on.length-1))%on.length] = 1;
}
