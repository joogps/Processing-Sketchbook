ArrayList<Piece> pieces;

int[][][] matrixes = {
  {
    {0, 0, 0, 0}, 
    {1, 1, 1, 1}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  {
    {1, 0, 0}, 
    {1, 1, 1}, 
    {0, 0, 0}
  }, 
  {
    {0, 0, 1}, 
    {1, 1, 1}, 
    {0, 0, 0}
  }, 
  {
    {1, 1}, 
    {1, 1}
  }, 
  {
    {0, 0, 0}, 
    {0, 1, 1}, 
    {1, 1, 0} 
  }, 
  {
    {0, 0, 0}, 
    {0, 1, 0}, 
    {1, 1, 1}
  }, 
  {
    {0, 0, 0}, 
    {1, 1, 0}, 
    {0, 1, 1}
  }
};

HUD hud;

color[] colors = {
  color(0, 255, 255), 
  color(0, 0, 255), 
  color(255, 165, 0), 
  color(255, 255, 0), 
  color(0, 255, 0), 
  color(128, 0, 128), 
  color(255, 0, 0)
};

void setup() {
  size(481, 641);
  setGame(1);
}

void draw() {
  background(200);
  hud.display();
  hud.update();

  for (int i = 0; i < pieces.size(); i++) {
    pieces.get(i).update();
    pieces.get(i).display();
  }

  lineup();

  hud.alert();
}

void keyReleased() {
  for (int i = 0; i < pieces.size(); i++) {
    pieces.get(i).keyUpdate();
  }
}

void mouseReleased() {
  hud.keyUpdate();
}

void setGame(int lvl) {
  hud = new HUD(lvl);

  pieces = new ArrayList<Piece>();
  pieces.add(new Piece(hud.indexes[0], hud.rotations[0], pieces.size()));
}
