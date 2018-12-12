class Layer {
  PVector pos;

  float layerWidth;
  float layerHeight;

  int layerIndex;

  float randomElement = round(random(8));

  Road road;
  River river;

  Poison poison;
  Slowdown slowdown;

  Layer(float x, float y, float _width, float _height, int i) {
    pos = new PVector(x, y);
    layerWidth = _width;
    layerHeight = _height;

    layerIndex = i;

    if (layerIndex != 0 && layerIndex != layers.length - 1) {
      if (randomElement < 3) {
        road = new Road(pos.x, pos.y, layerWidth, layerHeight);
      } else if (randomElement < 5 && layers[i-1].river == null) {
        river = new River(pos.x, pos.y, layerWidth, layerHeight);
      } else if (random(3) < 0.5) {
        if (random(1) < 0.5) {
          poison = new Poison(calcRandomPos(width/2, player.playerWidth), pos.y + player.playerHeight/2, player.playerWidth, player.playerHeight);
        } else {
          slowdown = new Slowdown(calcRandomPos(width/2, player.playerWidth), pos.y + player.playerHeight/2, player.playerWidth, player.playerHeight);
        }
      }
    }
  }

  void display() {
    if (road != null) {
      road.display();
    } else if (river != null) {
      river.display();
    } else {
      rectMode(CORNER);

      fill(130);
      rect(pos.x-1, pos.y, layerWidth+1, layerHeight);
      
      if(layerIndex == 0){
        stroke(130);
        line(pos.x, pos.y, pos.x + layerWidth, pos.y);
        
        stroke(0);
      }

      if (poison != null) {
        poison.display();
      } else if (slowdown != null) {
        slowdown.display();
      }
    }
  }

  void update() {
    if (road != null) {
      road.update();
    } else if (river != null) {
      river.update();
    } else if (poison != null) {
      poison.update(layerIndex);
    } else if (slowdown != null) {
      slowdown.update(layerIndex);
    }
  }
}
