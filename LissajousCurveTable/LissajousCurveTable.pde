Angle[] cols;
Angle[] rows;

Curve curves[][];

void setup() {
  size(820, 580);
  colorMode(HSB);

  cols = new Angle[6];
  for (int x = 0; x < cols.length; x++)
    cols[x] = new Angle(150+x*120, 60, 60, (x+1)*0.025);

  rows = new Angle[4];
  for (int y = 0; y < rows.length; y++)
    rows[y] = new Angle(60, 150+y*120, 60, (y+1)*0.025);

  curves = new Curve[cols.length][rows.length];
  for (int x = 0; x < curves.length; x++) {
    for (int y = 0; y < curves[x].length; y++) {
      curves[x][y] = new Curve(150+x*120, 150+y*120, 30);
    }
  }
}

void draw() {
  background(0);

  pushStyle();
  noFill();
  stroke(255);
  strokeWeight(1);

  ellipse(60, 60, 60, 60);
  popStyle();

  for (int x = 0; x < cols.length; x++) {
    cols[x].update();
    cols[x].display();
  }

  for (int y = 0; y < rows.length; y++) {
    rows[y].update();
    rows[y].display();
  }

  for (int x = 0; x < curves.length; x++) {
    for (int y = 0; y < curves[y].length; y++) {
      curves[x][y].update(cols[x], rows[y]);
      curves[x][y].display();
    }
  }
}
