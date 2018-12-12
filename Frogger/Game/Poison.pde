class Poison {
  PVector pos;
  
  float poisonWidth;
  float poisonHeight;
  
  Poison(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    poisonWidth = _width;
    poisonHeight = _height;
  }

  void display() {
    rectMode(CENTER);

    pushMatrix();
    translate(pos.x, pos.y);

    fill(128, 66, 244);
    rect(0, 0, poisonWidth * 0.6, poisonHeight * 0.6);
    popMatrix();
  }

  void update(int layerIndex) {
    if(pos.x - poisonWidth/2 >= player.pos.x - player.playerWidth/2 && pos.x + poisonWidth/2 <= player.pos.x + player.playerWidth/2 && pos.y - poisonHeight/2 >= player.pos.y - player.playerHeight/2 && pos.y + poisonHeight/2 <= player.pos.y + player.playerHeight/2){
      player.poisoned = !player.poisoned;
      player.slowdown = 1;
      layers[layerIndex].poison = null;
    }
  }
}
