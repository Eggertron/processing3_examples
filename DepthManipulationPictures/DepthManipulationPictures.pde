/*
  Depth Manipulation using images.
  image loading is super slow....
*/

//Globals
PImage background, midground, foreground, tree;
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
  midground = loadImage("midground.png");
  foreground = loadImage("foreground.png");
  tree = loadImage("treebark.png");
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
  //background(124);
  image(background, 0, 0, width, height);
  image(midground, midgroundX + (position * 0.05), midgroundY, midgroundW, midgroundH);
  image(foreground, foregroundX + (position * 0.25), foregroundY, foregroundW, foregroundH);
  //don't stretch the images, seems to work better.
  //image(background, 0, 0);
  //image(midground, midgroundX + (position * 0.10), midgroundY);
  //image(foreground, foregroundX + (position * 0.25), foregroundY);
  //use different function instead of image, below. but ignores transparency.
  //set(0, 0, background);
  //set((int)(midgroundX + (position * 0.10)), (int)midgroundY, midground);
  //set((int)(foregroundX + (position * 0.25)), (int)foregroundY, foreground);
  image(tree, wid * 0.5, -300, wid, height * 1.25);
}