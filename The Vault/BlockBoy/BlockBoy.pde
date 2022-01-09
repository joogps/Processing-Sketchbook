float y = 0;

float scaleX = 1;
float scaleY = 1;

float rectRadius = 0;
float rectY;

void setup() {
  size(640, 360);
  rectY = height/2-height/6;
}

void draw() {
  background(200);
  stroke(0);
  fill(255);

  pushMatrix();
  translate(width/2, y+height/2);
  scale(scaleX, scaleY);

  line(0, height/2-height/5, 0, 0);

  line(0, height/2-height/5, width/16, height/2);
  line(0, height/2-height/5, -width/16, height/2);

  line(0, +height/16, width/16, +height/6);
  line(0, +height/16, -width/16, +height/6);

  ellipse(0, -40, 80, 80);

  fill(0);
  ellipse(-15, -40, 10, 10);
  ellipse(15, -40, 10, 10);
  popMatrix();

  if (frameCount > 60)
    y = lerp(y, -60, 0.05);
    
  if (y < -55)
    scaleX = lerp(scaleX, 0, 0.1);

  if (scaleX < 0.01)
    scaleY = lerp(scaleY, 0, 0.1);

  if (scaleY < 0.01) {
    rectRadius = lerp(rectRadius, 50, 0.05);

    fill(255);
    rectMode(RADIUS);
    rect(width/2, rectY, rectRadius, rectRadius);

    if (rectRadius > 40){
      scaleX = 0;
      scaleY = 0;
      rectY = lerp(rectY, height-rectRadius-1, 0.1);
    }
  }
}
