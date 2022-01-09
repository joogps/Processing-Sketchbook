void drawTile(float x, float y, float w, float h) {
  fill(153);
  stroke(0);
  rect(x, y, w, h);

  noStroke();

  fill(117);
  beginShape();
  vertex(x+w/6.0, y+h*5/6.0);
  vertex(x+1, y+h);
  vertex(x+w, y+h);
  vertex(x+w, y+1);
  vertex(x+w*5/6.0, y+h/6.0);
  vertex(x+w*5/6.0, y+h*5/6.0);
  endShape();

  fill(232);
  beginShape();
  vertex(x+w, y+1);
  vertex(x+w*5/6.0, y+h/6.0);
  vertex(x+w/6.0, y+h/6.0);
  vertex(x+w/6.0, y+h*5/6);
  vertex(x+1, y+h);
  vertex(x+1, y+1);
  endShape();
}
