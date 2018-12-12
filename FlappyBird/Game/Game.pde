Bird bird;
Score score;

ArrayList<Pipe> pipes;
float spacing = 150;
float start = 250;

DeathLine deathLine;

PFont scoreFont;

void setup() {
  size(640, 360);
  setGame();
  
  scoreFont = createFont("..\\Assets\\VisbyRound.otf", 12);
}

void draw() {
  background(255);

  noStroke();
  bird.display();
  bird.edges();
  bird.update();

  for (int i = 0; i < pipes.size(); i++) {
    pipes.get(i).display();
    pipes.get(i).update();
    bird.hit(pipes.get(i));
  }

  if (pipes.get(pipes.size()-1).x  <= width-spacing) {
    pipes.add(new Pipe(width,  bird));
  }

  if (pipes.get(0).x + pipes.get(0).pipeWidth < 0) {
    pipes.remove(0);
  }

  if (deathLine != null) {
    stroke(255, 0, 0);
    deathLine.display();
    deathLine.update();
  }
  
  score.display();
} 

void keyPressed() {
  bird.flap();
  if (bird.dead) {
    setGame();
  }
}

void setGame() {
  bird = new Bird(width/5, height/4, 15);
  score = new Score(0, 0, 35);
  
  pipes = new ArrayList<Pipe>();

  for (int i = 0; i < (width-start) / spacing; i++) {
    pipes.add(new Pipe(start + i * spacing, bird));
  }
  
  deathLine = null;
}
