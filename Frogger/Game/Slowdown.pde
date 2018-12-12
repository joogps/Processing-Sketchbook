class Slowdown {
  PVector pos;
  
  float slowdownWidth;
  float slowdownHeight;
  
  Slowdown(float x, float y, float _width, float _height) {
    pos = new PVector(x, y);
    slowdownWidth = _width;
    slowdownHeight = _height;
  }

  void display() {
    rectMode(CENTER);

    pushMatrix();
    translate(pos.x, pos.y);

    fill(255, 239, 22);
    rect(0, 0, slowdownWidth * 0.6, slowdownHeight * 0.6);
    popMatrix();
  }

  void update(int layerIndex) {
    if(pos.x - slowdownWidth/2 >= player.pos.x - player.playerWidth/2 && pos.x + slowdownWidth/2 <= player.pos.x + player.playerWidth/2 && pos.y - slowdownHeight/2 >= player.pos.y - player.playerHeight/2 && pos.y + slowdownHeight/2 <= player.pos.y + player.playerHeight/2){
      player.slowdown = player.slowdown/5;
      player.poisoned = false;
      layers[layerIndex].slowdown = null;
    }
  }
}
