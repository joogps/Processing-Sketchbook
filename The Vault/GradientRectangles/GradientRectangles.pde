void setup(){
  fullScreen();
}

void draw(){
  background(100);
  
  for(int i = 0; i < height; i++){
    stroke(map(i, constrain(mouseY, 0, height - 1), height, 0, 255));
    line(0, i, width, i);
  }
  for(int i = 50; i < height - 50; i++){
    stroke(map(i, constrain(mouseY, 50, height - 50 - 1), height - 50, 255, 0));
    line(150, i, width - 150, i);
  }
}
