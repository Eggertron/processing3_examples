float r, g, b, diam, bColor, x;
PGraphics pg;

void setup() {
  size(1000, 1000);
  bColor = 0;
  background(bColor);  // set the background color only once.
  r = 15;
  g = 15;
  b = 15;
  diam = 30;
  x = 0;
  strokeWeight(10);
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(bColor);
  pg.endDraw();
}

void draw() {
  pg.beginDraw();
  updateRGB();
  updateDiam();
  updateCircle();
  if(mouseX != pmouseX) updateHud();
  pg.endDraw();
  
}

void mouseClicked() {
  background(bColor);
}

void mouseDragged() {
  //background(bColor);
  tint(255, 5);
  image(pg, (width - mouseX) - (width * 0.5), (height - mouseY) - (height * 0.5));
}

void updateCircle() {
  stroke(r, g, b);
  noFill();
  ellipse(mouseX, mouseY, diam, diam);
  pg.ellipse(mouseX, mouseY, diam, diam);
}

void updateRGB() {
  int rateR = 2;
  int rateG = 10;
  int rateB = 7;
  r += rateR;
  g += rateG;
  b += rateB;
  if (r > 230) {r = 0;}
  if ( g > 230) g = 0;
  if (b > 230) b = 0;
}

void updateDiam() {
  int rate = 5;
  diam += rate;
  if (diam > 80) diam = 0;
}

void updateHud() {
  println("Red: " + r);
  println("Green: " + g);
  println("Blue: " + b);
}