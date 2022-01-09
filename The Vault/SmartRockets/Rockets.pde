class Rockets {
  Rocket[] rockets;

  Rockets() {
    recreate();
  }

  void display() {
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].display();
    }
  }

  void update() {
    boolean alive = false;

    for (int i = 0; i < rockets.length; i++) {
      rockets[i].update();
      rockets[i].collide();

      alive = !rockets[i].stop || alive;
    }

    if (!alive)
      recreate();
  }

  void recreate() {
    if (rockets == null) {
      rockets = new Rocket[10];
      for (int i = 0; i < rockets.length; i++)
        rockets[i] = new Rocket(new DNA(null));
    } else {
      ArrayList<Rocket> list = new ArrayList<Rocket>();
      for (int i = 0; i < rockets.length; i++) {
        for (int j = 0; j < rockets[i].score*100; j++)
          list.add(rockets[i]);
      }

      rockets = new Rocket[10];
      for (int i = 0; i < rockets.length; i++) {
        if (list.size() > 0) {
          Rocket r1 = list.get(round(random(0, list.size()-1)));
          Rocket r2 = list.get(round(random(0, list.size()-1)));

          rockets[i] = new Rocket(incorporate(r1.dna, r2.dna, 10));
        } else
          rockets[i] = new Rocket(null);
      }
    }
  }
}
