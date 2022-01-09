color pickerColor;

import java.awt.datatransfer.*;
import java.awt.Toolkit;

void setup() {
  size(640, 600);
  surface.setResizable(true);

  colorMode(HSB);
  pickerColor = color(0, 0, 255);
}

void draw() {
  stroke(0);
  for (int x = 0; x < width; x+= 20) {
    for (int y = 0; y < height-height/4; y+= 20) {
      if (mouseX > x && mouseX < x+20 && mouseY > y && mouseY < y+20 && mousePressed) {
        pickerColor = color(map(x + y, 0, width + (height - 200), 0, 255), 255, 255);
      }

      fill(map(x + y, 0, width + (height - 200), 0, 255), 255, 255);
      rect(x, y, 20, 20);
    }
  }

  fill(pickerColor);
  rect(0, height-height/4, width, height-(height-height/4));

  fill(255, 100);
  rect(20, height-height/4+height/28, 300, height/4-height/28*2, 60);

  String rgb = "rgb(" + round(red(pickerColor)) + ", " + round(green(pickerColor)) + ", " + round(blue(pickerColor)) + ")";
  String hsb = "hsb(" + round(hue(pickerColor)) + ", " + round(saturation(pickerColor)) + ", " + round(brightness(pickerColor)) + ")";
  String hex = "#" + hex(pickerColor);

  fill(0);
  textSize(13);
  text(rgb, 50, height-height/4+height/28*2.3);
  text(hsb, 50, height-height/4+height/28*2.3+height/18);
  text(hex, 50, height - height/4 + height/28*2.3 + height/9);

  float rgbW = textWidth(rgb);
  float hsbW = textWidth(hsb);
  float hexW = textWidth(hex);

  if (mouseX > 70+rgbW && mouseY > height-height/4+height/28*2.1-(textAscent() - textDescent()) && mouseX < 70+rgbW+320*0.9-(70+rgbW) && mouseY < height-height/4+height/28*2.1-(textAscent()-textDescent())+((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent())))) {
    fill(100, 75);

    if (mousePressed) {
      copyToClipboard(rgb);
      fill(50, 100);
    }
  } else
    fill(255, 50);

  rect(70+rgbW, height-height/4+height/28*2.1-(textAscent() - textDescent()), 320*0.9-(70+rgbW), ((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent()-textDescent()))), 30);

  if (mouseX > 70+hsbW && mouseY > height-height/4+height/28*2.1+height/18-(textAscent()-textDescent()) && mouseX < 70+hsbW+320*0.9-(70+hsbW) && mouseY < height-height/4+height/28*2.1+height/18-(textAscent() - textDescent())+((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent())))) {
    fill(100, 75);

    if (mousePressed) {
      copyToClipboard(hsb);
      fill(50, 100);
    }
  } else
    fill(255, 50);

  rect(70+hsbW, height-height/4+height/28*2.1+height/18-(textAscent()-textDescent()), 320*0.9-(70+hsbW), ((height-height/4+height/28*2.5+height/18)-(height-height/4+height/28*2.1+height/18-(textAscent()-textDescent()))), 30);

  if (mouseX > 70+hexW && mouseY > height-height/4+height/28*2.1+height/9-(textAscent()-textDescent()) && mouseX < 70+hexW+320*0.9-(70+hexW) && mouseY < height-height/4+height/28*2.1+height/9-(textAscent() - textDescent())+((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent())))) {
    fill(100, 75);

    if (mousePressed) {
      copyToClipboard(hex);
      fill(50, 100);
    }
  } else
    fill(255, 50);

  rect(70+hexW, height-height/4+height/28*2.1+height/9-(textAscent()-textDescent()), 320*0.9-(70+hexW), ((height-height/4+height/28*2.5+height/9)-(height-height/4+height/28*2.1+height/9-(textAscent()-textDescent()))), 30);

  fill(50);
  autoTextSize("COPY TO CLIPBOARD", (320*0.9-(70+rgbW))*0.9, ((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent()))));
  text("COPY TO CLIPBOARD", 73+rgbW, height-height/4+height/28*2.3);

  autoTextSize("COPY TO CLIPBOARD", (320*0.9-(70+hsbW))*0.9, ((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent()))));
  text("COPY TO CLIPBOARD", 73+hsbW, height-height/4+height/28*2.3+height/18);

  autoTextSize("COPY TO CLIPBOARD", (320*0.9-(70+hexW))*0.9, ((height-height/4+height/28*2.5)-(height-height/4+height/28*2.1-(textAscent() - textDescent()))));
  text("COPY TO CLIPBOARD", 73+hexW, height-height/4+height/28*2.3+height/9);
}

void autoTextSize(String string, float _width, float _height) {
  float size = 1;
  textSize(size);
  while (textWidth(string) < _width && abs(textAscent() - textDescent()) < _height) {
    size+= 0.1;
    textSize(size);
  }
  textSize(size);
}

void copyToClipboard(String str) {
  StringSelection stringSelection = new StringSelection(str);
  Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
  clipboard.setContents(stringSelection, null);
}
