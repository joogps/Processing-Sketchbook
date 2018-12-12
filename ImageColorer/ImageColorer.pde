PImage cubeImg;
PImage origImg;

void setup(){
  cubeImg = loadImage("cube.jpg");
  origImg = loadImage("cube.jpg");
  
  size(273, 297);
  colorMode(HSB, 255);
  
  cubeImg.loadPixels();
  for (int i = 0; i < cubeImg.width; i++) {
    for(int j = 0; j < cubeImg.height; j++){
      int index = i + j * cubeImg.width;
      cubeImg.pixels[index] = color(hue(cubeImg.pixels[index]), 0, brightness(cubeImg.pixels[index]));
    }
  }
  cubeImg.updatePixels();
}

void draw(){
  image(cubeImg, 0, 0);
  
  if(mousePressed){
    cubeImg.loadPixels();
    for (int i = 0; i < cubeImg.width; i++) {
      for(int j = 0; j < cubeImg.height; j++){
        int index = i + j * cubeImg.width;
        cubeImg.pixels[index] = color(hue(origImg.pixels[index]), constrain(saturation(cubeImg.pixels[index]) + constrain(map(dist(mouseX, mouseY, i, j), 0, 50, 15, 0), 0, 15) * (mouseButton == LEFT ? 1 : -1), 0, saturation(origImg.pixels[index])), brightness(origImg.pixels[index]));
      }
    }
    cubeImg.updatePixels();
  }
}
