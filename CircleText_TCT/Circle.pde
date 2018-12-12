// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QHEQuoIKgNE

class Circle {
  float x;
  float y;
  float r;

  boolean growing = true;
  
  boolean colored = false;
  
  float colorX;
  float colorY;
  
  int colorRed;
  int colorGreen;
  int colorBlue;
  
  color fillColor;
  float alpha;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    r = 1;
  }

  void grow() {
    if (growing) {
      r = r + 0.5;
    }
  }
  
  void colorCheck(){
    if(dist(mouseX, mouseY, x, y) <= r && !colored){
      colored = true;
      
      colorX = map(mouseX, 0, width, 0, 255);
      colorY = map(mouseY, 0, width, 0, 255);
      
      switch (redTypeRandom){
        case 1: 
          colorRed = round(colorX);
          break;
        case 2:
          colorRed = round(colorY);
          break;
      }
      
      switch (greenTypeRandom){
        case 1: 
          colorGreen = round(colorX);
          break;
        case 2:
          colorGreen = round(colorY);
          break;
      }
      
      switch (blueTypeRandom){
        case 1: 
          colorBlue = round(colorX);
          break;
        case 2:
          colorBlue = round(colorY);
          break;
      }
      
      alpha = 0;
      fillColor = color(colorRed, colorGreen, colorBlue, alpha);
    }
    
    if(colored){
      alpha+= 20 - alpha / 100;
      fillColor = color(colorRed, colorGreen, colorBlue, alpha);
    }
  }
  
  boolean edges() {
    return (x + r > width || x -  r < 0 || y + r > height || y -r < 0);
  }

  void show() {
    stroke(255);
    strokeWeight(1 + r / 100);
    if(colored){
      fill(fillColor);
    }
    else{
      noFill();
    }
    ellipse(x, y, r*2, r*2);
  }
}
