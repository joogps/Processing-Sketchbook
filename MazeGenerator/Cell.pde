class Cell {
  int x;
  int y;

  float w;
  float h;

  boolean[] walls = {true, true, true, true};
  boolean visited;

  Cell(int _x, int _y, float _w, float _h) {
    x = _x;
    y = _y;

    w = _w;
    h = _h;
  }

  void display() {
    noStroke();
    if (visited)
      fill(50, 100, 255);
    else
      fill(175);

    rect(x*w, y*h, w, h);

    stroke(0);
    if (walls[0])
      line(x*w+w, y*w, x*w+w, y*w+w);
    if (walls[1])
      line(x*w, y*w+w, x*w+w, y*w+w);
    if (walls[2])
      line(x*w, y*w, x*w, y*w+w);
    if (walls[3])
      line(x*w, y*w, x*w+w, y*w);
  }

  void update() {
    if (!complete) {
      ArrayList<Cell> neighbors = new ArrayList<Cell>();

      if (x-1 >= 0 && !grid[x-1][y].visited)
        neighbors.add(grid[x-1][y]);

      if (x+1 < grid.length && !grid[x+1][y].visited)
        neighbors.add(grid[x+1][y]);

      if (y-1 >= 0 && !grid[x][y-1].visited)
        neighbors.add(grid[x][y-1]);

      if (y+1 < grid[x].length && !grid[x][y+1].visited)
        neighbors.add(grid[x][y+1]);

      if (neighbors.size() > 0) {
        Cell next = neighbors.get(round(random(neighbors.size()-1)));

        stack.add(next);
        current.removeWalls(next);
        current = next;

        current.visited = true;
      } else if (stack.size() > 1) {
        current = stack.get(stack.size()-2);
        stack.remove(current);
      } else {
        complete = true;
      }
    }
  }

  void removeWalls(Cell next) {
    if (next.x > x) {
      walls[0] = false;
      next.walls[2] = false;
    }

    if (next.x < x) {
      walls[2] = false;
      next.walls[0] = false;
    }

    if (next.y > y) {
      walls[1] = false;
      next.walls[3] = false;
    }

    if (next.y < y) {
      walls[3] = false;
      next.walls[1] = false;
    }
  }
}
