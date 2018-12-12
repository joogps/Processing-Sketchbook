class Star{
  PVector position = new PVector(random(-width/2, width/2), random(-height/2, height/2));
  PVector speed = new PVector(map((position.x - width/2), -width/2, width/2, 0, 5), map((position.y - height/2), -height/2, height/2, 0, 5));
  float initialSpeedAverage = (abs(speed.x) + abs(speed.y)) / 2;
  float size = map((abs(speed.x) + abs(speed.y)) / 2, initialSpeedAverage, 5, 0, 20);
  
  void show(){
    size =  map((abs(speed.x) + abs(speed.y)) / 2, initialSpeedAverage, 5, 0, 20);
    
    fill(255, 255, 255);
    noStroke();
    ellipse(position.x, position.y, size, size);
  };
  
  void move(){
    speed = new PVector(map((position.x - width/2), -width/2, width/2, 0, 5) + ((size / (width / 10)) * (speed.x / abs(speed.x))), map((position.y - height/2), -height/2, height/2, 0, 5) + ((size / (height / 10))) * (speed.y / abs(speed.y)));
    
    position.x += speed.x;
    position.y += speed.y;
  };
  
  void restore(Star[] starObjectArray, int i){
    if(position.x > width / 2 || position.x < -width / 2 || position.y > height / 2 || position.y < -height / 2 || (speed.x == 0 && speed.y == 0)){
      starObjectArray[i] = new Star();
    }
  }
}
