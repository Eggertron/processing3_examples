/*
  Depth Manipulation using images.
  image loading is super slow....
*/

//Globals
PImage background;
PShape midground, foreground;
float midgroundX, midgroundY,
      midgroundW, midgroundH,
      foregroundX, foregroundY,
      foregroundW, foregroundH;
int wid;
int position;
boolean mouseMode;
int rand;

void setup() {
  fullScreen();
  background = loadImage("background.jpg");
  midground = loadShape("midground.svg");
  foreground = loadShape("foreground (1).svg");
  midgroundX = -width * 0.25;
  midgroundY = height * 0.20;
  midgroundW = width * 1.25;
  midgroundH = height;
  foregroundX = -width * 0.25;
  foregroundY = height * 0.5;
  foregroundW = width * 1.25;
  foregroundH = height;
  wid = (int)(width * 0.5);
  mouseMode = false;
}

void draw() {
  background(124);
  drawBackgrounds();
}

void mouseClicked() {
  mouseMode = mouseMode ? false : true;
}

void drawBackgrounds() {
  if (mouseMode) {
    position = mouseX;
  }
  else {
    rand = (int)random(3) - 1;
    position += rand * 10;
    if (position < 0) position = 0;
    if (position > width) position = width;
  }
  image(background, 0, 0);
  shape(midground, midgroundX + (position * 0.10), midgroundY, midgroundW, midgroundH);
  shape(foreground, foregroundX + (position * 0.25), foregroundY, foregroundW, foregroundH);
}