class Score {
  PVector pos;
  float size;
  
  int score;
  
  Score(float x, float y, float _size){
    pos = new PVector(x, y);
    size = _size;
    
    score = 0;
  }
  
  void display(){
    pushStyle();
    noStroke();
    
    textAlign(LEFT, TOP);
    textFont(scoreFont);
    textSize(size);
    
    fill(255);
    rect(pos.x, pos.y, textWidth(str(score)) + 15, abs(textAscent() - textDescent()) + 10, 0, 0, 10, 0);
    
    fill(0);
    text(score, pos.x + 5, pos.y + 5);
    popStyle();
  }
  
  void increaseScore(int i){
    score+= i;
  }
}
