float w;
float h;

void setup() {
  size(0, 0);
}

void draw() {
  w = lerp(w, 500, 0.1);
  h = lerp(h, 500, 0.1);

  surface.setLocation(int(displayWidth/2-w/2), int(displayHeight/2-h/2));
  surface.setSize(int(w), int(h));

  background(0);
}
