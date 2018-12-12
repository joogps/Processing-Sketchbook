Platform[][] platforms;
Player player;

Enemy[] enemies;

Block[] blocks;
PowerUp[] powerUps;

Coin[] coins;

void setup() {
  size(640, 360);
  setGame();
}

void draw() {
  background(200);

  fill(255);
  stroke(0);

  for (int i = 0; i < platforms.length; i++) {
    beginShape();
    for (int j = 0; j < platforms[i].length; j++) {
      platforms[i][j].update();
      platforms[i][j].display();

      for (int k = 0; k < enemies.length; k++) {
        if (enemies[k] != null)
          enemies[k].platform(platforms[i][j]);
      }

      for (int k = 0; k < powerUps.length; k++) {
        if (powerUps[k] != null)
          powerUps[k].platform(platforms[i][j]);
      }
    }
    endShape();
  }

  for (int i = 0; i < enemies.length; i++) {
    if (enemies[i] != null) {
      enemies[i].update();
      enemies[i].display();
      enemies[i].player(player);
    }
  }

  for (int i = 0; i < powerUps.length; i++) {
    if (powerUps[i] != null) {
      powerUps[i].update();
      powerUps[i].display();
      powerUps[i].player(player);
    }
  }

  for (int i = 0; i < blocks.length; i++) {
    blocks[i].update();
    blocks[i].display();

    for (int j = 0; j < enemies.length; j++) {
      if (enemies[j] != null)
        enemies[j].block(blocks[i]);
    }

    for (int j = 0; j < powerUps.length; j++) {
      if (powerUps[j] != null)
        powerUps[j].block(blocks[i]);
    }
  }

  for (int i = 0; i < coins.length; i++) {
    if (coins[i] != null) {
      coins[i].update();
      coins[i].display();

      coins[i].player(player);
    }
  }

  player.update();
  player.display();

  for (int i = 0; i < platforms.length; i++) {
    for (int j = 0; j < platforms[i].length; j++) {
      player.platform(platforms[i][j]);
    }
  }

  for (int i = 0; i < blocks.length; i++) {
    player.block(blocks[i]);
  }

  player.canJump(platforms, blocks);

  textSize(30);
  textAlign(LEFT, TOP);

  fill(0);
  for (int xy = -1; xy < 2; xy++) {
    text(player.coins, 5+xy, 0);
    text(player.coins, 5, 0+xy);
  }

  fill(255);
  text(player.coins, 5, 0);
}


void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case RIGHT:
      player.right = true;
      break;
    case LEFT:
      player.left = true;
    }
  } else {
    player.jump();
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    case RIGHT:
      player.right = false;
      break;
    case LEFT:
      player.left = false;
    }
  }
}

void setGame() {
  platforms = new Platform[2][];

  platforms[0] = new Platform[5];

  platforms[0][0] = new Platform(-1, height, -1, height/4+1);
  platforms[0][1] = new Platform(-1, height/4, width/4, height/1.5);
  platforms[0][2] = new Platform(width/4, height/1.5, width/4*3, height/1.5);
  platforms[0][3] = new Platform(width/4*3, height/1.5, width, height/4);
  platforms[0][4] = new Platform(width, height/4+1, width, height);

  platforms[1] = new Platform[9];

  platforms[1][0] = new Platform(-1+width*1.2, height, -1+width*1.2, height/4+1);
  platforms[1][1] = new Platform(-1+width*1.2, height/4, width/4+width*1.2, height/4);
  platforms[1][2] = new Platform(width/4+width*1.2, height/4+1, width/4+width*1.2, height/1.5);
  platforms[1][3] = new Platform(width/4+width*1.2, height/1.5, width/1.8+width*1.2, height/1.5);
  platforms[1][4] = new Platform(width/1.8+width*1.2, height/1.5, width/1.8+width*1.2, height/4 + abs(height/1.5-height/4)/2+1);
  platforms[1][5] = new Platform(width/1.8+width*1.2, height/4 + abs(height/1.5-height/4)/2, width/1.3+width*1.2, height/4 + abs(height/1.5-height/4)/2);
  platforms[1][6] = new Platform(width/1.3+width*1.2, height/4 + abs(height/1.5-height/4)/2, width/1.3+width*1.2, height/4+1);
  platforms[1][7] = new Platform(width/1.3+width*1.2, height/4, width+width*1.2, height/4);
  platforms[1][8] = new Platform(width+width*1.2, height/4, width+width*1.2, height);

  player = new Player(width/2, height/8, 0, width+width*1.2);

  enemies = new Enemy[1];
  enemies[0] = new Enemy(width/2+width*1.2, height/1.5-15/2, 0);

  blocks = new Block[3];
  blocks[0] = new Block(width/3, height/2, 0, "powerupgood");
  blocks[1] = new Block(width/3*2, height/2, 1, "coin");

  blocks[2] = new Block(width/8*3+width*1.2, height/2, 2, "powerupbad");

  powerUps = new PowerUp[blocks.length];

  coins = new Coin[15];
  for (int i = 0; i < coins.length; i++) {
    coins[i] = new Coin(30/2+(width/2-(coins.length/2)*30)+i*30, height/3, i);
  }
}
