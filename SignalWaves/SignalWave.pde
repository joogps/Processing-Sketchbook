class SignalWave{
  float radius = 0;
  
  float hue;
  float alpha = 255;
  
  boolean reproduced = false;
  
  int sides = round(random(5, 10));
  
  SignalWave(float _hue){
    hue = _hue;
  }
  
  void display(){
    stroke(hue%255, 255, 255, alpha);
    strokeWeight(radius < 10 ? radius : 10);
    
    fill(hue%255, 255, 255, alpha/5);
    
    beginShape();
    for(float a = 0; a <= TWO_PI+0.05; a+= 0.05){
      float x = cos(a) * (radius + cos(a*sides) * radius/10);
      float y = sin(a) * (radius + cos(a*sides) * radius/10);
      vertex(x, y);
    }
    endShape();
  }
  
  void update(){
    radius = lerp(radius, width, 0.005);
    hue++;
    alpha = lerp(alpha, 0, 0.01);
  }
}
