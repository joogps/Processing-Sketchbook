class Sky {
  ArrayList<SkyObject> clouds;

  boolean night;
  int nightTimer;
  int nightTimerOffset;
  float nightify;

  SkyObject[] stars;
  SkyObject moon;

  Sky() {
    clouds = new ArrayList<SkyObject>();
    int limit = round(random(1, 3));
    for (int i = 0; i < limit; i++) {
      clouds.add(new SkyObject(width/limit*i+random(-width/12, width/6), random(height/4, height/2), 0.015, cloudSprite));
    }
  }

  void display() {
    for (int i = 0; i < clouds.size(); i++) {
      clouds.get(i).display();
    }

    if (round(random(150)) == 0 && clouds.size() <= 2 && (dinosaur.move && !dinosaur.dead))
      clouds.add(new SkyObject(width, random(height/4, height/2), 0.015, cloudSprite));

    if (night) {
      for (int i = 0; i < stars.length; i++) {
        stars[i].display();
      }

      moon.display();
    }
  }

  void invert() {
    loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        pixels[x+y*width] = color(abs(nightify-red(pixels[x+y*width])), abs(nightify-green(pixels[x+y*width])), abs(nightify-blue(pixels[x+y*width])));
      }
    }
    updatePixels();
  }

  void update() {
    for (int i = 0; i < clouds.size(); i++) {
      clouds.get(i).update();

      if (clouds.get(i).pos.x+clouds.get(i).w < 0)
        clouds.remove(i);
    }

    if (round(random(150)) == 0 && clouds.size() <= 2 && (dinosaur.move && !dinosaur.dead))
      clouds.add(new SkyObject(width, random(height/4, height/2), 0.015, cloudSprite));

    if (night) {
      for (int i = 0; i < stars.length; i++) {
        stars[i].update();
      }

      moon.update();
    }

    nightify = lerp(nightify, night ? 255 : 0, 0.05);

    if (!dinosaur.dead && !night && hud.score > 1000 && round(random(500)) == 0) {
      nightTimer = int(random(7.5, 30)*1000);
      nightTimerOffset = millis();

      setNight();
    }

    if (millis()-nightTimerOffset > nightTimer)
      night = false;
  }

  void setNight() {
    night = true;

    stars = new SkyObject[round(random(5))];
    for (int i = 0; i < stars.length; i++)
      stars[i] = new SkyObject(random(width/3*2), random(height), 0.015, starSprites[round(random(starSprites.length-1))]); 

    moon = new SkyObject(random(width), random(height/2), 0.005, moonSprites[round(random(moonSprites.length-1))]);
  }
}
