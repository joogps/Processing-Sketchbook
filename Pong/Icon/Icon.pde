void setup() {
  size(360, 360);
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x + y * width] = color(map(dist(x, y, 640 / 2, 0), 0, (640 + 360) / 2, 150, 70));
    }
  }
  updatePixels();
  
  fill(255);
  noStroke();
   
  rect(30, height/2-180/1.2, 50, 180);
  ellipse(width-50*1.5, 270, 100, 100);
  
  save("icon.png");
}
