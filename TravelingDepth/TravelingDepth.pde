/*
  Author: Edgar H. Han
  Version: 20161002
  
  Creating a field of depth with finite particle system. Gives the illusion
  of moving forward through a system of stars.
*/

Dots[] _dots;
int count = 20;
int rowcol = 4;
int distance = 200;

void setup() {
  size(900, 900, P3D);
  init();
}

void draw() {
  background(0); // 
  for(int i = 0; i < _dots.length; i++) {_dots[i].draw(); }
}

void init() {
  _dots = new Dots[20];
  for (int i = 0; i < _dots.length; i++) {
    _dots[i] = new Dots(rowcol, i * distance);
  }
}