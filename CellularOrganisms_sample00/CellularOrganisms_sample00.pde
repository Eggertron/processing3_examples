/*
  author: Edgar H. Han
  version: 20161104
  
  Simple growth simulation from single organism
*/

private Cells cells;

void setup() {
  size(1500, 1500);
  initCell();
}

void draw() {
  background(124);
  cells.draw();
}

void initCell() {
  cells = new Cells((int)(width * 0.5), (int)(height * 0.5));
}