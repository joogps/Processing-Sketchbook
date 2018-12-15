ArrayList<Toothpick> toothpicks;
float size = 10;

void setup() {
  size(640, 640);
  colorMode(HSB);

  toothpicks = new ArrayList<Toothpick>();
  toothpicks.add(new Toothpick(0, 0, size, random(1) < 0.5 ? "horizontal" : "vertical", 1));
}

void draw() {
  frameRate(15);

  translate(width/2, height/2);
  scale(2-(frameCount/(width/size*2)), 2-(frameCount/(height/size*2)));

  background(0);
  for (int i = 0; i < toothpicks.size(); i++)
    toothpicks.get(i).display();

  recreate();
}

void mouseClicked() {
  noLoop();
}

void recreate() {
  float size = toothpicks.size();
  for (int i = 0; i < size; i++)
    if (toothpicks.get(i).newToothpick)
      toothpicks.get(i).recreate();

  for (int i = 0; i < size; i++)
    toothpicks.get(i).newToothpick = false;
}
