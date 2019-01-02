void setup() {
  size(512, 512);
  background(40);

  fill(255);

  textFont(createFont("Product Sans Bold.ttf", 250));
  textAlign(CENTER, CENTER);
  textLeading(210);

  text("20\n19", width/2, height/2-textDescent()/2);

  save("favicon.png");
  exit();
}
