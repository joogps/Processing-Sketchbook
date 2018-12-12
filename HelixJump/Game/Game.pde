import ddf.minim.*;
Minim minim;

Body body;
HUD hud;

AudioPlayer[] jumpSounds;
AudioPlayer scoreSound;
AudioPlayer deathSound;
AudioPlayer endSound;

void settings() {
  size(360, 640, P3D);
  PJOGL.setIcon("..//Assets//icon.png");
}

void setup() {
  minim = new Minim(this);

  hud = new HUD();
  SetGame(3);

  jumpSounds = new AudioPlayer[6];
  for (int i = 0; i < jumpSounds.length; i++)
    jumpSounds[i] = minim.loadFile("..\\Assets\\jumpsound" + (i+1) + ".mp3");

  scoreSound = minim.loadFile("..\\Assets\\scoresound.mp3");
  deathSound = minim.loadFile("..\\Assets\\deathsound.mp3");
  endSound = minim.loadFile("..\\Assets\\endsound.mp3");

  surface.setTitle("Helix Jump");
}

void draw() {
  surface.setSize(360, 640);

  background(255);
  lights();

  noStroke();
  body.display();
  body.update();

  hud.startHUD();
  hud.score();
  hud.transition();
  hud.endHUD();
}

void keyReleased() {
  if (body.ball.dead || body.ball.finished)
    hud.fadeIn = true;
}

void mouseDragged() {
  if (body.ball.dead || body.ball.finished)
    hud.fadeIn = true;
}

void SetGame(int level) {
  body = new Body(level);

  hud.score = 0;
  hud.scoreWidth = 0;
}
