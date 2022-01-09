boolean left, right, up, down, space;

Player player;
ArrayList<Shot> shots;

ArrayList<Enemy> enemies;
ArrayList<Shot> enemyShots;

ArrayList<Particle> particles;

HUD hud;
PFont hudFont;

int timer;
int created;

void setup() {
  size(640, 360);

  hudFont = createFont("..\\Assets\\Nunito-Black.ttf", 1);

  particles = new ArrayList<Particle>();
  hud = new HUD();

  setGame();
}

void draw() {
  background(player.superShot*255);
  noStroke();

  for (int i = 0; i < enemies.size(); i++) {
    if (enemies.get(i) != null) {
      enemies.get(i).display();
      if (!hud.transition)
        enemies.get(i).update();
      enemies.get(i).target(player);

      enemies.get(i).die();

      if (enemies.get(i) != null)
        player.collideEnemy(enemies.get(i));
    }
  }

  if ((millis()-timer > (3000-hud.score*5) || random(500) < 1) && created < hud.levelGoals[hud.level-1]) {
    enemies.add(new Enemy(enemies.size()));

    timer = millis();
    created++;
  }

  for (int i = 0; i < shots.size(); i++) {
    if (shots.get(i) != null) {
      shots.get(i).display();
      if (!hud.transition)
        shots.get(i).update();

      shots.get(i).edges();

      for (int j = 0; j < enemies.size(); j++) {
        if (shots.get(i) == null)
          break;

        if (enemies.get(j) != null)
          shots.get(i).collideEnemy(enemies.get(j));
      }

      for (int j = 0; j < enemyShots.size(); j++) {
        if (shots.get(i) == null)
          break;

        if (enemyShots.get(j) != null)
          shots.get(i).collideEnemyShot(enemyShots.get(j));
      }
    }
  }

  for (int i = 0; i < enemyShots.size(); i++) {
    if (enemyShots.get(i) != null) {
      enemyShots.get(i).display();
      if (!hud.transition)
        enemyShots.get(i).update();

      enemyShots.get(i).edges();

      if (enemyShots.get(i) != null)
        enemyShots.get(i).collidePlayer();
    }
  }

  player.display();
  if (!hud.transition)
    player.update();
  player.edges();
  player.superShot();

  if (mousePressed)
    player.mouseRotatePlayer();

  for (int i = 0; i < particles.size(); i++) {
    if (particles.get(i) != null) {
      particles.get(i).display();
      if (!hud.transition)
        particles.get(i).update();
    }
  }

  hud.display();
  hud.levelChange();
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      left = true;
      break;
    case RIGHT:
      right = true;
      break;
    case UP:
      up = true;
      break;
    case DOWN:
      down = true;
      break;
    }
  } else {
    switch(key) {
    case 'a':
      left = true;
      break;
    case 'd':
      right = true;
      break;
    case 'w':
      up = true;
      break;
    case 's':
      down = true;
      break;
    case ' ':
      space = true;
      break;
    }
  }
}

void keyReleased() {
  player.shoot(false);
  player.movePlayer();
  player.keyRotatePlayer();

  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      left = false;
      break;
    case RIGHT:
      right = false;
      break;
    case UP:
      up = false;
      break;
    case DOWN:
      down = false;
      break;
    }
  } else {
    switch(key) {
    case 'a':
      left = false;
      break;
    case 'd':
      right = false;
      break;
    case 'w':
      up = false;
      break;
    case 's':
      down = false;
      break;
    case ' ':
      space = false;
      break;
    }
  }
}

void mouseMoved() {
  if (!hud.transition)
    player.mouseRotatePlayer();
}

void mouseReleased() {
  player.shoot(true);
}

void setGame() {
  player = new Player();
  shots = new ArrayList<Shot>();

  enemies = new ArrayList<Enemy>();
  enemyShots = new ArrayList<Shot>();

  hud.score = 0;

  created = 0;

  int loops = round(random(5, 15));
  for (int i = 0; i < loops; i++)
    particles.add(new Particle(player.pos.copy(), PVector.random2D().mult(random(5, 10)), random(player.size/2), particles.size()));
}
