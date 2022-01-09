/**
 * This was probably the first sketch I ever made in Processing
 * Before that, I had only made a few projects on Khan Academy's website, where I learned to code
 
 * Also, it was entirely written on a Raspberry Pi
**/

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup(){
  size(500, 500);
  
  balls.add(new Ball(width / 2, 80, 30));
  balls.add(new Ball(width / 5 * 1, 200, 20));
  balls.add(new Ball(width / 5 * 4, 200, 10));
};

void draw(){
  background(255);
  for(int i = balls.size() - 1; i >= 0; i--){
    Ball ball = balls.get(i);
    ball.display();
    ball.fall();
  }
};

class Ball {
  float ballSpeed;
  float ballX;
  float ballY;
  float ballSize;
  boolean ballFall;
  boolean ballDead;
  
  Ball(float x, float y, float size){
    ballSpeed = 1;
    
    ballX = x;
    ballY = y;
    ballSize = size;
    
    ballFall = true;
    ballDead = false;
  }
  
  void display(){
    fill(0);
    noStroke();
    ellipse(ballX, ballY, ballSize, ballSize);
  }
  
  void fall(){
    if(!ballDead){
      ballY += ballSpeed;
      
      if(ballFall){
       ballSpeed+= 0.3 + ballSize / 50;
      }
      else if(!ballFall){
       ballSpeed+= 1 + ballSize / 100;
      }
        
      if(ballY + ballSize / 2 >= height){
        if(ballSpeed > 0 && ballFall == false){
          ballDead = true;
          ballY = height - ballSize / 2;
        }
        
        ballFall = false;
        ballSpeed = -(ballSpeed - (ballSize / ballSize));
      }
      else if(ballSpeed > 0 && !ballFall){
        ballFall = true;
      }
    }
  }
}
