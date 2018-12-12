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
  size(360, 360);
  background(255);

  int index = round(random(matrixes.length-1));
  float w = width/matrixes[index][0].length;
  float h = height/matrixes[index].length;

  fill(colors[index]);
  for (int y = 0; y < matrixes[index].length; y++) {
    for (int x = 0; x < matrixes[index][y].length; x++) {
      if (matrixes[index][y][x] == 1)
        rect(x*w, y*h, w, h);
    }
  }
  
  save("icon.png");
  exit();
}
