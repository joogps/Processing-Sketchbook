float animation;

void setup(){
  size(640, 360);
  colorMode(HSB);
}
void draw(){
  for(int x = 0; x < width; x++){
    stroke(abs(map(x, 0, width, animation, 255 + animation) % 255), 255, 255);
    strokeWeight(40);
    point(x, height/2);
  }
  
  animation-= cos(TWO_PI * frameCount / 540) * 5;
}
