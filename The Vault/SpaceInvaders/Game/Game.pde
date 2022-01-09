import ddf.minim.*;
Minim minim;

Ship ship;
ArrayList<Shot> shots;
ArrayList<Barrier> barriers;

ArrayList<Target> targets;
ArrayList<Integer> indexesShooterTargets;
ArrayList<TargetShot> targetShots;

AudioPlayer shotSound;
AudioPlayer targetShotSound;

AudioPlayer hitSound;
AudioPlayer barrierHitSound;

AudioPlayer startSound;
AudioPlayer deathSound;

AudioPlayer targetSound;

HUD hud;

float keyDelay;

PImage monster;

void setup() {
  size(800, 800);
  minim = new Minim(this);

  shotSound = minim.loadFile("..\\Assets\\shotsound.mp3");
  targetShotSound = minim.loadFile("..\\Assets\\targetshotsound.mp3");

  hitSound = minim.loadFile("..\\Assets\\hitsound.mp3");
  barrierHitSound = minim.loadFile("..\\Assets\\barrierhitsound.mp3");

  startSound = minim.loadFile("..\\Assets\\startsound.mp3");
  deathSound = minim.loadFile("..\\Assets\\deathsound.mp3");

  targetSound = minim.loadFile("..\\Assets\\targetsound.mp3");

  setGame();

  monster = loadImage("..\\Assets\\monster.png");
  surface.setTitle("Space Invaders");
  surface.setIcon(monster);

  monster.loadPixels();
  for (int x = 0; x < monster.width; x++) {
    for (int y = 0; y < monster.height; y++) {
      int index = x+y*monster.width;
      monster.pixels[index] = color(255 - brightness(monster.pixels[index]), alpha(monster.pixels[index]));
    }
  }
  monster.updatePixels();
}

void draw() {
  background(0);

  for (int i = 0; i < targets.size(); i++) {
    if (targets.get(i) != null) {
      targets.get(i).display();
      targets.get(i).move();
    }
  }

  if (hud.start) {
    if (frameCount%120 == 0) {
      int randomIndex = indexesShooterTargets.get(round(random(indexesShooterTargets.size() - 1)));

      if (targets.get(randomIndex) != null)
        targetShots.add(new TargetShot(targets.get(randomIndex)));
    }
  }

  for (int i = 0; i < shots.size(); i++) {
    if (shots.get(i) != null) {
      shots.get(i).display();
      shots.get(i).move();

      if (shots.get(i) != null)
        shots.get(i).kill(i);

      if (shots.get(i) != null)
        shots.get(i).hit(i);
    }
  }

  for (int i = 0; i < targetShots.size(); i++) {
    if (targetShots.get(i) != null) {
      targetShots.get(i).display();
      targetShots.get(i).move();

      if (targetShots.get(i) != null)
        targetShots.get(i).kill(i);

      if (targetShots.get(i) != null)
        targetShots.get(i).hit(i, null);


      for (int j = 0; j < barriers.size(); j++) {
        if (targetShots.get(i) != null && barriers.get(j) != null)
          targetShots.get(i).hit(i, barriers.get(j));
      }
    }
  }

  for (int i = 0; i < barriers.size(); i++) {
    if (barriers.get(i) != null)
      barriers.get(i).display();
  }

  if (ship != null) {
    ship.display();
    ship.move();
  }


  hud.display();
  hud.update();

  if (keyDelay > 0)
    keyDelay--;
}

void keyPressed() {
  if (ship!= null) {
    if (keyDelay <= 0)
      ship.shoot();

    if (ship.speed <= 25)
      keyDelay = 25 - (ship.speed);
  }

  hud.restart();
}

void setGame() {
  hud = new HUD();

  ship = new Ship();
  shots = new ArrayList<Shot>();

  barriers = new ArrayList<Barrier>();

  int numBarriers = round(random(1, 10));
  float size = (width-hud.size)/float(numBarriers+1);

  for (float x = hud.size+size/2; x < width-size; x+= size+size/(numBarriers-1))
    barriers.add(new Barrier(x, height-ship.size[1]*3, size, barriers.size()));

  float targetWidth = 30;
  float targetHeight = 40;

  int xTargets = 10;
  int yTargets = 5;

  float spacingWidth = targetWidth+(width-130-xTargets*targetWidth)/float(xTargets-1);
  float spacingHeight = targetHeight+(height/2-yTargets*targetHeight)/float(yTargets-1);

  targets = new ArrayList<Target>();
  indexesShooterTargets = new ArrayList<Integer>();
  for (int x = 0; x < xTargets; x++) {
    for (int y = 0; y < yTargets; y++) {
      targets.add(new Target(hud.size+targetWidth+x*spacingWidth, targetHeight+y*spacingHeight, targetWidth, targetHeight));

      if (y == yTargets-1)
        indexesShooterTargets.add(targets.size()-1);
    }
  }

  targetShots = new ArrayList<TargetShot>();

  keyDelay = 0;
}

void setNull() {
  ship = null;

  for (int i = 0; i < targets.size(); i++) {
    targets.set(i, null);
  }

  for (int i = 0; i < targetShots.size(); i++) {
    targetShots.set(i, null);
  }

  for (int i = 0; i < shots.size(); i++) {
    shots.set(i, null);
  }

  for (int i = 0; i < barriers.size(); i++) {
    barriers.set(i, null);
  }
}
