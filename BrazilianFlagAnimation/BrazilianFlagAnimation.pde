PFont font;

float cover;
float grow;
float complete;
float appear;
float shrink;

void setup() {
  size(1440, 1008);
  font = createFont("Nunito-Bold.ttf", 12);
}

void draw() {
  background(255);

  fill(0);
  textAlign(CENTER, CENTER);
  textFont(font);

  autoTextSize("BRASIL", width*(1-shrink*0.5), height);
  float spacing = (textDescent()/20.0+textAscent())/2.0;
  autoTextSize("GOVERNO FEDERAL", width*(1-shrink*0.5), height);
  spacing+= (textDescent()/16.0+textAscent())/2.0;

  autoTextSize("BRASIL", width*(1-shrink*0.5), height);
  text("BRASIL", width/2, height/2-spacing*shrink+height*(0.5-shrink*0.25)+(textDescent()/20.0+textAscent())/2.0);

  float spacing2 = (textDescent()/10.0+textAscent());

  autoTextSize("GOVERNO FEDERAL", width*(1-shrink*0.5), height);
  text("GOVERNO FEDERAL", width/2, height/2-spacing*shrink+height*(0.5-shrink*0.25)+spacing2+(textDescent()/16.0+textAscent())/2.0);

  pushMatrix();
  translate(width/2, height/2-spacing*shrink);
  scale(1-shrink*0.5);

  noStroke();
  fill(0, 156, 59);
  rect(-width/2, -height/2, width, height*cover);

  fill(255, 223, 0);
  pushMatrix();
  scale(grow);
  beginShape();
  vertex(0, -height*0.34);
  vertex(width*0.4, 0);
  vertex(0, height*0.34);
  vertex(-width*0.4, 0);
  endShape(CLOSE);
  popMatrix();

  float ratio = min(width*0.31, height*0.45);

  fill(0, 39, 118);
  arc(0, 0, ratio, ratio, -HALF_PI, -HALF_PI+complete*TWO_PI, PIE);

  if (appear > 0) {
    float angle1 = PI/64.0;
    float angle2 = PI/12.0;

    fill(255);
    beginShape();
    for (float a = angle1+PI; a < angle2+PI; a+= 0.01)
      vertex(cos(a)*ratio/2.0, sin(a)*ratio/2.0);

    for (float a = angle1; a < angle2; a+= 0.005)
      vertex(lerp(cos(a+PI)*ratio/2.0, cos(a)*ratio/2.0, appear), lerp(sin(a+PI)*ratio/2.0, sin(a)*ratio/2.0, appear));
    endShape(CLOSE);
  }
  popMatrix();

  cover = lerp(cover, 1, 0.05);

  if (cover > 0.9)
    grow = lerp(grow, 1, 0.05);

  if (grow > 0.9)
    complete = lerp(complete, 1, 0.1);

  if (complete > 0.99)
    appear = lerp(appear, 1, 0.05);

  if (appear > 0.985)
    shrink = lerp(shrink, 1, 0.15);
}

float autoTextSize(String str, float w, float h) {
  textSize(1);
  float minW = w/textWidth(str);
  float minH = h;
  textSize(min(minW, minH));
  return min(minW, minH);
}
