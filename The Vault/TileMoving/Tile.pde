class Tile{
  float x;
  float y;
  float size[];
  
  Tile(float _x, float _y, float size0, float size1){
    x = _x;
    y = _y;
    size = new float[2];
    size[0] = size0;
    size[1] = size1;
  }
  
  void show(){
    fill(244, 209, 66);
    rect(x, y, size[0], size[1], 20);
  }
}
