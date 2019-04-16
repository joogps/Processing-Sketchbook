import processing.video.*;

Capture cam;

void setup() {
  size(640, 360);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++)
      println(cameras[i]);

    cam = new Capture(this, cameras[3]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true)
    cam.read();

  PImage newCam = new PImage(cam.width, cam.height);
  cam.loadPixels();
  newCam.loadPixels();
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      color defaultPixel = cam.pixels[x+y*cam.width];
      
      float r = red(defaultPixel);
      float g = red(defaultPixel);
      float b = red(defaultPixel);

      int amount = 1;

      for (float a = 0; a < TWO_PI; a+= QUARTER_PI) {
        int pixelX = constrain(x+round(cos(a)), 0, cam.width-1);
        int pixelY = constrain(y+round(sin(a)), 0, cam.height-1);
        
        color pixel = cam.pixels[pixelX+pixelY*cam.width];

        r+= red(pixel);
        g+= green(pixel);
        b+= blue(pixel);

        amount++;
      }

      r/= amount;
      g/= amount;
      b/= amount;
      
      newCam.pixels[x+y*newCam.width] = color(r, g, b);
    }
  }
  newCam.updatePixels();

  translate(newCam.width, 0);
  scale(-1, 1);
  image(newCam, 0, 0);
}
