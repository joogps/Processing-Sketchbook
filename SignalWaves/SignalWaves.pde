ArrayList<SignalWave> signals;

void setup() {
  size(640, 640);
  colorMode(HSB);
  
  signals = new ArrayList<SignalWave>();
  signals.add(new SignalWave(0));
}

void draw() {
  background(255);

  translate(width/2, height/2);
  rotate(map(cos(TWO_PI * frameCount/2400), -1, 1, 0, TWO_PI));
  
  for (int i = 0; i < signals.size(); i++) {
    signals.get(i).display();
    signals.get(i).update();
    
    if(signals.get(i).radius > width/5 && !signals.get(i).reproduced){
      signals.add(new SignalWave(signals.get(i).hue));
      signals.get(i).reproduced = true;
    }
    
    if(signals.get(i).alpha < 1){
      signals.remove(i);
    }
  }
}
