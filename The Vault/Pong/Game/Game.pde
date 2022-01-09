boolean up = false;
boolean down = false;

Ball ball;
Pad pad1;
Pad padAI;

PImage icon;

void setup() {
  size(640, 360);

  ball = new Ball(width/2, height/2, new PVector(2, 2));
  pad1 = new Pad(15, height/2, 10, 120);
  padAI = new Pad(width - 15, height/2, 10, 170);
  
  icon = loadImage("..\\Icon\\icon.png");
  surface.setTitle("Pong");
  surface.setIcon(icon);
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x + y * width] = color(map(dist(x, y, width / 2, 0), 0, (width + height) / 2, 150, 70));
    }
  }
  updatePixels();

  ball.display();
  ball.move();
  ball.wallKick();
  ball.padKick(pad1);
  ball.padKick(padAI);
  ball.addPoint();

  pad1.display();
  pad1.playerMove();

  padAI.display();
  padAI.AIMove();

  textAlign(CENTER, TOP);
  textSize(40);
  text(pad1.points + " | " + padAI.points, width / 2, 0);
  
  strokeCap(SQUARE);
  stroke(255);
  strokeWeight(5);
  line(width / 2, height / 2 - height / 3, width / 2, height / 2 + height / 2);
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    up = true;
    break;

  case DOWN:
    down = true;
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP:
    up = false;
    break;

  case DOWN:
    down = false;
    break;
  }
}
