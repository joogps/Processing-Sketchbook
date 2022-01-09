PImage[] images;
int index = 0;

void setup() {
  size(320, 568);

  images = new PImage[3];
  images[0] = loadImage("normal.jpg");
  images[1] = loadImage("tall.jpg");
  images[2] = loadImage("wide.jpg");
}

void draw() {
  background(averageColor(images[index]));

  imageMode(CENTER);
  image(scaleSize(images[index]), width/2, height/2);
}

void keyPressed() {
  if (keyCode == RIGHT)
    index++;
  if (keyCode == LEFT)
    index--;

  index%= images.length;

  if (keyCode == ENTER)
    surface.setSize(height, width);
}

PImage scaleSize(PImage img) {
  PImage newImg = img.copy();

  float w = img.width;
  float h = img.height;

  if (img.width/img.height > width/height) {
    w = width;
    h = width/img.width*img.height;
  } else {
    h = height;
    w = height/img.height*img.width;
  }

  newImg.resize(int(w), int(h));
  return newImg;
}

color averageColor(PImage img) {
  color avgColor = color(255);

  img.loadPixels();
  for (int i = 0; i < img.width*img.height; i++)
    avgColor = lerpColor(avgColor, img.pixels[i], 0.5);

  return avgColor;
}
