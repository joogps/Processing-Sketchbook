PImage cubeImg;

void setup(){
  cubeImg = loadImage("cube.jpg");
  
  size(273, 297);
  colorMode(HSB, 255);
  
  cubeImg.loadPixels();
  for (int i = 0; i < cubeImg.width; i++) {
    for(int j = 0; j < cubeImg.height; j++){
      int index = i + j * cubeImg.width;
      cubeImg.pixels[index] = color(hue(cubeImg.pixels[index]), saturation(cubeImg.pixels[index]) - map((i + j) / 2, 0, (cubeImg.width + cubeImg.height) / 2, 0, 255), brightness(cubeImg.pixels[index]));
    }
  }
  cubeImg.updatePixels();
  
  image(cubeImg, 0, 0);
}
