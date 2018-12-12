Player player; //<>//
Goal goal;

Layer[] layers;

UI ui;

int level = 4;

PImage icon;

void setup() {
  size(640, 640);
  
  icon = loadImage("..\\Assets\\frog.png");
  
  surface.setIcon(icon);
  surface.setTitle("Frogger");
  
  setGame();

  ui = new UI();
}

void draw() {
  background(130);
  stroke(0);

  if (!ui.display) {
    for (int i = 0; i < layers.length; i++) {
      if (layers[i] != null) {
        layers[i].display();
        layers[i].update();
      }
    }

    goal.display();
    goal.update();

    player.display();
  } else {
    ui.display();
  }
}

void keyReleased() {
  if (!ui.display) {
    player.update();
  }
  
  ui.update();
}

void setGame() {
  float _width = height/float(level);
  float _height = height/float(level);

  player = new Player(calcRandomPos(width/2, _width), height-_height/2, _width, _height);
  goal = new Goal(calcRandomPos(width/2, _width), _height/2, player.playerWidth, player.playerHeight);

  layers = new Layer[level];
  boolean isEmpty = true;

  while (isEmpty) {
    for (int i = 0; i < layers.length; i++) {
      layers[i] = new Layer(0, i*_height, width, _height, i);
      if (layers[i].road != null || layers[i].road != null) {
        isEmpty = false;
      }
    }
  }
}

float calcRandomPos(float x, float size) {
  Float result = null;
  while (result == null || result + size/2 > width || result - size/2 < 0) {
    result = x + round(random(-x - size/2, x) / size)*size;
  }

  return result;
}
