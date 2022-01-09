Star[] stars = new Star[500];

void setup(){
  size(500, 500);
  surface.setResizable(true);
  
  for(int i = 0; i < stars.length; i++){
    stars[i] = new Star();
  }
  
  fill(0, 0, 0, 0);
  rect(0, 0, width, height);
};

void draw(){
  fill(0, 0, 0, 25);
  rect(0, 0, width, height);
  
  pushMatrix();
  translate(width / 2, height / 2);
  
  for(int i = 0; i < stars.length; i++){
    stars[i].move();
    stars[i].show();
    
    if(i < stars.length - map(mouseX, 0, width, 500, 0)){
      stars[i].restore(stars, i);
    }
  }
  popMatrix();
};
