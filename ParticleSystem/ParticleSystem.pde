ArrayList<Particle[]> pSystem;

void setup() {
  size(640, 360, P3D);

  pSystem = new ArrayList<Particle[]>();
  recreate();
}

void draw() {
  background(255);
  lights();

  translate(width/2, height/2);
  rotateX(-HALF_PI);

  for (int i = 0; i < pSystem.size(); i++) {
    for (int j = 0; j < pSystem.get(i).length; j++) {
      pSystem.get(i)[j].display();
      pSystem.get(i)[j].update();
      pSystem.get(i)[j].kill();
      
      if(pSystem.get(i)[j].alpha < 1){
        pSystem.remove(i);
      }
    }
  }

  if (frameCount % 30 == 0) {
    recreate();
  }
}

void recreate() {
  PVector pos = new PVector(random(-width/2, width/2), random(-height/2, height/2), 0);
  pSystem.add(new Particle[round(random(3, 5))]);
  for (int i = 0; i < pSystem.get(pSystem.size()-1).length; i++) {
    pSystem.get(pSystem.size()-1)[i] = new Particle(pos.x, pos.y, pos.z);
  }
}
