CircleWave[] circleWaves;
color[] colors;

void setup() {
  size(640, 360);
  
  circleWaves = new CircleWave[5];
  circleWaves[0] = new CircleWave(50, height - 30, 200, 25, 335);
  circleWaves[1] = new CircleWave(width/2 + 40, height, 250, 30, 400);
  circleWaves[2] = new CircleWave(width/2 - 30, 10, 275, 35, 265);
  circleWaves[3] = new CircleWave(width - 40, height/2, 250, 40, 370);
  circleWaves[4] = new CircleWave(30, 30, 225, 30, 425);
  
  colors = new color[5];
  colors[0] = color(255, 80, 60);
  colors[1] = color(150, 0, 255);
  colors[2] = color(200, 255, 0);
  colors[3] = color(0, 255, 100);
  colors[4] = color(30, 100, 200);
}

void draw() {
  background(180);
  noStroke();
  
  for(int i = 0; i < circleWaves.length; i++){ 
    fill(colors[i]);
    circleWaves[i].display();
    circleWaves[i].update();
  }
}
