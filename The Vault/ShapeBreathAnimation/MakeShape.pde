void makeShape(int x, int y, int _width, int _height, int sides) {
  pushMatrix();
  beginShape();
  translate(x, y);
  rotate(-HALF_PI);
  for(int i = 0; i <= sides; i++){
    PVector spot = new PVector(_width * cos((TWO_PI / sides) * i), _height * sin((TWO_PI / sides) * i));
    vertex(spot.x, spot.y);
  }
  endShape();
  popMatrix();
}
