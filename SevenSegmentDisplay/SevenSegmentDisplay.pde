Segment[] segments;
int[] hex = {0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47};

void setup() {
  size(220, 360);

  segments = new Segment[7];
  segments[0] = new Segment(width/2, height/5, width/10, height/4, HALF_PI);
  segments[1] = new Segment(width/2+height/7, height*7/20, width/10, height/4, 0);
  segments[2] = new Segment(width/2+height/7, height*13/20, width/10, height/4, 0);
  segments[3] = new Segment(width/2, height*4/5, width/10, height/4, HALF_PI);
  segments[4] = new Segment(width/2-height/7, height*13/20, width/10, height/4, 0);
  segments[5] = new Segment(width/2-height/7, height*7/20, width/10, height/4, 0);
  segments[6] = new Segment(width/2, height/2, width/10, height/4, HALF_PI);
}

void draw() {
  background(0);
  for (int i = 0; i < segments.length; i++)
    segments[i].display();

  if (frameCount%60 == 0)
    setSegments(hex[frameCount/60%hex.length]);
}

void setSegments(int num) {
  String binary = binary(num, 7);

  for (int i = 0; i < binary.length(); i++)
    segments[i].setState(binary.charAt(i) == '1');
}
