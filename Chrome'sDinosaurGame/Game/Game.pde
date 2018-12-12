import ddf.minim.*;
Minim minim;

Dinosaur dinosaur;

PImage[] dinosaurRun;
PImage[] dinosaurCrouch;

PImage dinosaurStill;
PImage dinosaurDead;

AudioPlayer dinosaurJumpSound;
AudioPlayer dinosaurDieSound;

ArrayList<Cactus> cactuses;
PImage[] cactusSprites;

Bird bird;
PImage[] birdSprites;

Ground ground;
PImage groundSprite;

Sky sky;
PImage cloudSprite;
PImage[] starSprites;
PImage[] moonSprites;

HUD hud;
PImage restartSprite;
PFont hudFont;
AudioPlayer hudScoreSound;

void setup() {
  size(640, 320);
  smooth(0);

  minim = new Minim(this);

  dinosaurRun = new PImage[2];
  dinosaurRun[0] = loadImage("..\\Assets\\dinosaurleft.png");
  dinosaurRun[1] = loadImage("..\\Assets\\dinosaurright.png");

  dinosaurCrouch = new PImage[2];
  dinosaurCrouch[0] = loadImage("..\\Assets\\dinosaurcrouchleft.png");
  dinosaurCrouch[1] = loadImage("..\\Assets\\dinosaurcrouchright.png");

  dinosaurStill = loadImage("..\\Assets\\dinosaurstill.png");
  dinosaurDead = loadImage("..\\Assets\\dinosaurdead.png");

  dinosaurJumpSound = minim.loadFile("..\\Assets\\jumpsound.mp3");
  dinosaurDieSound = minim.loadFile("..\\Assets\\diesound.mp3");

  cactusSprites = new PImage[6];
  for (int i = 0; i < cactusSprites.length; i++)
    cactusSprites[i] = loadImage("..\\Assets\\cactus"+(i+1)+".png");

  birdSprites = new PImage[2];
  birdSprites[0] = loadImage("..\\Assets\\birddown.png");
  birdSprites[1] = loadImage("..\\Assets\\birdup.png");

  cloudSprite = loadImage("..\\Assets\\cloud.png");

  groundSprite = loadImage("..\\Assets\\ground.png");

  starSprites = new PImage[3];
  for (int i = 0; i < starSprites.length; i++)
    starSprites[i] = loadImage("..\\Assets\\star"+(i+1)+".png");

  moonSprites = new PImage[7];
  for (int i = 0; i < moonSprites.length; i++)
    moonSprites[i] = loadImage("..\\Assets\\moon"+(i+1)+".png");

  restartSprite = loadImage("..\\Assets\\restart.png");
  hudFont = createFont("..\\Assets\\font.ttf", 21);
  hudScoreSound = minim.loadFile("..\\Assets\\scoresound.mp3");

  hud = new HUD();
  setGame();

  surface.setTitle("Chrome's Dinosaur Game");
  surface.setIcon(dinosaurStill);
}

void draw() {
  background(255);
  sky.update();
  sky.display();

  ground.update();
  ground.display();

  dinosaur.update();
  dinosaur.display();

  for (int i = 0; i < cactuses.size(); i++) {
    cactuses.get(i).update();
    cactuses.get(i).display();

    dinosaur.collide(cactuses.get(i), null);
  }

  if (cactuses.get(cactuses.size()-1).pos.x < width/3-random(width*0.8) && bird == null)
    cactuses.add(new Cactus(width));

  if (cactuses.size() > 1 && cactuses.get(0).pos.x+cactuses.get(0).w < 0)
    cactuses.remove(0);

  if (bird != null) {
    bird.update();
    bird.display();
    dinosaur.collide(null, bird);

    if (bird.pos.x + bird.w < 0)
      bird = null;
  } else if (hud.score > 500 && cactuses.size() <= 2 && round(random(175)) == 0)
    bird = new Bird();

  hud.update();
  hud.display();

  sky.invert();
}

void keyReleased() {
  dinosaur.restart();
}

void setGame() {
  dinosaur = new Dinosaur();
  ground = new Ground();

  dinosaurDieSound.rewind();

  cactuses = new ArrayList<Cactus>();
  cactuses.add(new Cactus(width*1.8));

  bird = null;

  sky = new Sky();

  hud.score = 0;
}

void mouseReleased() {
  hud.restart();
}
