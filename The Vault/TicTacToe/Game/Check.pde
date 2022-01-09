void checkHorizontal() {
  for (int y = 0; y < grid[0].length; y++) {
    boolean check = true;
    String player = null;

    for (int x = 0; x < grid.length; x++) {
      if (grid[x][y].player != null) {
        if (player == null)
          player = grid[x][y].player;

        if (grid[x][y].player != player) {
          check = false;
          break;
        }
      } else {
        check = false;
        break;
      }
    }

    if (check && player != null) {
      hud.gameOverLinePos1 = new PVector(grid[0][y].pos.x+grid[0][y].w/2.0, grid[0][y].pos.y+grid[0][y].h/2.0);
      hud.gameOverLinePos2 = new PVector(grid[grid.length-1][y].pos.x+grid[grid.length-1][y].w/2.0, grid[grid.length-1][y].pos.y+grid[grid.length-1][y].h/2.0);
      hud.gameOverLineStart = new PVector(grid[floor(grid.length/2.0)][y].pos.x+(grid.length%2 == 0 ? 0 : grid[floor(grid.length/2.0)][y].w/2.0), grid[floor(grid.length/2.0)][y].pos.y+grid[floor(grid.length/2.0)][y].h/2.0);

      hud.gameOver = true;
      hud.winner = player;

      break;
    }
  }
}

void checkVertical() {
  for (int x = 0; x < grid.length; x++) {
    boolean check = true;
    String player = null;

    for (int y = 0; y < grid[0].length; y++) {
      if (grid[x][y].player != null) {
        if (player == null)
          player = grid[x][y].player;

        if (grid[x][y].player != player) {
          check = false;
          break;
        }
      } else {
        check = false;
        break;
      }
    }

    if (check && player != null) {
      hud.gameOverLinePos1 = new PVector(grid[x][0].pos.x+grid[x][0].w/2.0, grid[x][0].pos.y+grid[x][0].h/2.0);
      hud.gameOverLinePos2 = new PVector(grid[x][grid[x].length-1].pos.x+grid[x][grid[x].length-1].w/2.0, grid[x][grid[x].length-1].pos.y+grid[x][grid[x].length-1].h/2.0);
      hud.gameOverLineStart = new PVector(grid[x][floor(grid[x].length/2.0)].pos.x+grid[x][floor(grid[x].length/2.0)].w/2.0, grid[x][floor(grid[x].length/2.0)].pos.y+(grid[x].length%2 == 0 ? 0 : grid[x][floor(grid[x].length/2.0)].h/2.0));

      hud.gameOver = true;
      hud.winner = player;

      break;
    }
  }
}

void checkDiagonalLeftToRight() {
  boolean check = true;
  String player = null;

  for (int i = 0; i < grid.length; i++) {
    if (grid[i][i].player != null) {
      if (player == null)
        player = grid[i][i].player;

      if (grid[i][i].player != player) {
        check = false;
        break;
      }
    } else {
      check = false;
      break;
    }
  }

  if (check && player != null) {
    hud.gameOverLinePos1 = new PVector(grid[0][0].pos.x+grid[0][0].w/2.0, grid[0][0].pos.y+grid[0][0].h/2.0);
    hud.gameOverLinePos2 = new PVector(grid[grid.length-1][grid[0].length-1].pos.x+grid[grid.length-1][grid[0].length-1].w/2.0, grid[grid.length-1][grid[0].length-1].pos.y+grid[grid.length-1][grid[0].length-1].h/2.0);
    hud.gameOverLineStart = new PVector(grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].pos.x+(grid.length%2 == 0 ? 0 : grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].w/2.0), grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].pos.y+(grid[floor(grid.length/2.0)].length%2 == 0 ? 0 : grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].h/2.0));

    hud.gameOver = true;
    hud.winner = player;
  }
}

void checkDiagonalRightToLeft() {
  boolean check = true;
  String player = null;

  for (int i = grid.length-1; i >= 0; i--) {
    if (grid[i][grid[i].length-i-1].player != null) {
      if (player == null) {
        player = grid[i][grid[i].length-i-1].player;
      }

      if (grid[i][grid[i].length-i-1].player != player) {
        check = false;
        break;
      }
    } else {
      check = false;
      break;
    }
  }

  if (check && player != null) {
    hud.gameOverLinePos1 = new PVector(grid[grid.length-1][0].pos.x+grid[grid.length-1][0].w/2.0, grid[grid.length-1][0].pos.y+grid[grid.length-1][0].h/2.0);
    hud.gameOverLinePos2 = new PVector(grid[0][grid[0].length-1].pos.x+grid[0][grid[0].length-1].w/2.0, grid[0][grid[0].length-1].pos.y+grid[0][grid[0].length-1].h/2.0);
    hud.gameOverLineStart = new PVector(grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].pos.x+(grid.length%2 == 0 ? 0 : grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].w/2.0), grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].pos.y+(grid[floor(grid.length/2.0)].length%2 == 0 ? 0 : grid[floor(grid.length/2.0)][floor(grid[0].length/2.0)].h/2.0));

    hud.gameOver = true;
    hud.winner = player;
  }
}

void checkTie() {
  boolean tie = true;
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      tie = grid[x][y].player != null && tie;
    }
  }

  if (tie)
    hud.gameOver = true;
}
