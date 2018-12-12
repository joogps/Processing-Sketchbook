void drawTile(float x, float y, float size0, float size1) {
  fill(153);
  stroke(0);
  rect(x, y, size0, size1);

  noStroke();

  fill(117);
  beginShape();
  vertex(x + size0 / 6, y + size1 / 6 * 5);
  vertex(x + 1, y + size1);
  vertex(x + size0, y + size1);
  vertex(x + size0, y + 1);
  vertex(x + size0 / 6 * 5, y + size1 / 6);
  vertex(x + size0 / 6 * 5, y + size1 / 6 * 5);
  endShape();

  fill(232);
  beginShape();
  vertex(x + size0, y + 1);
  vertex(x + size0 / 6 * 5, y + size1 / 6);
  vertex(x + size0 / 6, y + size1 / 6);
  vertex(x + size0 / 6, y + size1 / 6 * 5);
  vertex(x + 1, y + size1);
  vertex(x + 1, y + 1);
  endShape();
}
