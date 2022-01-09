PFont font;

float delay;
float cover;
float grow;
float complete;
float appear;
float shrink;
float slide;

void setup() {
  size(720, 504);
  font = createFont("Nunito-Bold.ttf", 12);
}

void draw() {
  background(255);

  autoTextSize("BRASIL", width*0.9, height/2);
  float spacing = (textAscent()+textDescent())/2.0;
  autoTextSize("GOVERNO FEDERAL", width*0.9, height/2);
  spacing+= (textAscent()+textDescent())/2.0;

  if (slide > 0) {
    pushMatrix();
    translate(width/2, height/2+(height+spacing)/6.0*slide);
    scale(1-shrink*0.5);

    fill(0);
    textAlign(CENTER, CENTER);
    textFont(font);

    autoTextSize("BRASIL", width*0.9, height/2);
    text("BRASIL", 0, 0);
    spacing = (textAscent()+textDescent())/2.0;
    autoTextSize("GOVERNO FEDERAL", width*0.9, height/2);
    text("GOVERNO FEDERAL", 0, spacing);
    spacing+= (textAscent()+textDescent())/2.0;
    popMatrix();
  }

  pushMatrix();
  translate(width/2, height/2-(height+spacing)/10.0*slide);
  scale(1-shrink*0.5);

  noStroke();
  fill(0, 156, 59);
  rectMode(CENTER);
  rect(0, 0, width, height*cover);

  fill(255, 223, 0);
  scale(grow);
  beginShape();
  vertex(0, -height*0.34);
  vertex(width*0.4, 0);
  vertex(0, height*0.34);
  vertex(-width*0.4, 0);
  endShape(CLOSE);

  float radius = min(width*0.31, height*0.45);

  fill(0, 39, 118);
  arc(0, 0, radius, radius, -HALF_PI, -HALF_PI+complete*TWO_PI, PIE);

  if (appear > 0) {
    float angle1 = PI/64.0;
    float angle2 = PI/12.0;

    fill(255);
    beginShape();
    for (float a = angle1+PI; a < angle2+PI; a+= 0.01)
      vertex(cos(a)*radius/2.0, sin(a)*radius/2.0);

    for (float a = angle1; a < angle2; a+= 0.005)
      vertex(lerp(cos(a+PI)*radius/2.0, cos(a)*radius/2.0, appear), lerp(sin(a+PI)*radius/2.0, sin(a)*radius/2.0, appear));
    endShape(CLOSE);
  }
  popMatrix();

  delay = lerp(delay, 1, 0.1);

  if (delay > 0.99)
    cover = lerp(cover, 1, 0.1);

  if (cover > 0.9)
    grow = lerp(grow, 1, 0.1);

  if (grow > 0.9)
    complete = lerp(complete, 1, 0.075);

  if (complete > 0.99)
    appear = lerp(appear, 1, 0.05);

  if (appear > 0.99)
    shrink = lerp(shrink, 1, 0.15);

  if (shrink > 0.99999)
    slide = lerp(slide, 1, 0.2);

  if (slide < 0.99999)
    saveFrame("frames/####.png");
  else
    exit();
}

float autoTextSize(String str, float w, float h) {
  textSize(1);
  float minW = w/textWidth(str);
  float minH = h;
  textSize(min(minW, minH));
  return min(minW, minH);
}
