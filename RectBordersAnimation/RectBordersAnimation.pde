float animation = 0;
boolean increase = true;

void setup(){
  size(640, 360);
}

void draw(){
  if(increase){
    animation+= (10 - abs(animation / 100));
  }
  else{
    animation-= (10 - abs(animation / 100));
  }
  
  if(animation >= 360){
    increase = false;
    animation = 360;
  }
  
  if(animation <= -360){
    increase = true;
    animation = -360;
  }
  
  println(animation);
  
  background(200);
  fill(255);
  rectMode(CENTER);
  rect(width / 2, height / 2, ((width + height) / 3) / 2, ((width + height) / 3) / 2, constrain(abs(animation), 0, 360), constrain(360 - abs(animation), 0, 360), constrain(abs(animation), 0, 360), constrain(360 - abs(animation), 0, 360));
}
