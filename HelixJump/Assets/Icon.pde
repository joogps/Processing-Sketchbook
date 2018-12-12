color iconColor;


void setup() {
  size(640, 640, P3D);

  iconColor = color(random(0, 255), random(0, 255), random(0, 255));
  
  background(255);
  lights();
  noStroke();
  translate(width/2, height/2);
  
  rotateZ(-QUARTER_PI/4);
  translate(0, 0, 320);

  fill(iconColor);
  pushMatrix();
  rotateX(QUARTER_PI*1.5);

  cylinder(0, 50, 250, 250, 0, TWO_PI, 200);
  cylinder(50, 125, 15, 15, 0, TWO_PI, 200);
  popMatrix();

  fill(255-red(iconColor), 255-green(iconColor), 255-blue(iconColor));
  pushMatrix();
  translate(0, -30, 87.5);

  sphere(18);
  popMatrix();

  for (int i = 0; i < 25; i++) {
    pushMatrix();
    translate(random(-width/6, width/6), random(-height/6, height/6), random(-100, 100));

    sphere(random(1, 3));
    popMatrix();
  }

  float noiseOff = random(0, 1000);

  pushMatrix();
  rotateX(QUARTER_PI*1.5);
  translate(0, 87.5, 16);

  beginShape();
  for (float i = 0; i < TWO_PI; i+= TWO_PI/628) {
    float noise = map(noise(cos(i)*0.7 + noiseOff, sin(i)*0.7 + noiseOff), 0, 1, 0, 40);
    vertex(cos(i) * noise, sin(i) * noise);
  }
  endShape();
  popMatrix();
  
  save("icon.png");
}
