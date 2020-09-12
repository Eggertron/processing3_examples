/*
  author: edgar han
  version: 20161005
  various fractals.
*/

final float STOP_DIAMETER = 5; // stop recursion size.
final float MULTIPLIER = 0.5; // new iteration size.

void setup() {
  //size(900, 900);
  fullScreen();
  noFill();
  //fCircles(width * 0.5, height * 0.5, width * 0.8);
  //fTriangle(width * 0.5, height * 0.5, width * 0.25);
  //fSquares(width * 0.5, height * 0.5, width * 0.25);
  tree(width * 0.5, height, (float)radians(90), height * 0.5);
}

void fCircles(float x, float y, float diameter) {
  ellipse(x, y, diameter, diameter);
  float radius = diameter * 0.5;
  float diam = diameter * MULTIPLIER; // new diameter sizes.
  if (diameter > STOP_DIAMETER) {  // stop recursion size.
    fCircles(x - radius, y, diam);
    fCircles(x + radius, y, diam);
    fCircles(x, y - radius, diam);
    fCircles(x, y + radius, diam);
  }
}
/*
  x at center of triangle
  y at center of triangle
  length is from center to corner.
*/
void fTriangle(float x, float y, float length) {
  // top point
  float x1 = x;
  float y1 = y - length;
  // right point
  float x2 = x + length;
  float y2 = y + length;
  // left point
  float x3 = x - length;
  float y3 = y + length;
  triangle(x1, y1, x2, y2, x3, y3);
  if (length > STOP_DIAMETER) {
    float len = length * MULTIPLIER;
    fTriangle(x, y - len, len);
    fTriangle(x + len, y + len, len);
    fTriangle(x - len, y + len, len);
  }
  
}


  void fSquares(float x, float y, float length) {
    rect(x-length, y-length, x+length, y+length);
    if (length > STOP_DIAMETER) {
      float len = length * MULTIPLIER;
      fSquares(x - length, y - length, len);
      fSquares(x + length, y + length, len);
    }
  }
  
  void tree(float x, float y,float angle, float length) {
    int minLength = 5;
    int minAngle = 25;
    int maxAngle = 85;
    float lengthScale = 0.5;
    float strokeWeightScale = 0.02;
    int maxBranches = 7;
    int minBranches = 2;
    if (length < minLength) return;
    // x and y are the origin
    int stroke = (int)(length * strokeWeightScale);
    float x2 = x - (length * cos(angle));
    float y2 = y - (length * sin(angle));
    if (stroke < 1) stroke = 1;
    strokeWeight(stroke);
    line(x, y, x2, y2);
    println(angle);
    int rand = (int)random(maxBranches - minBranches) + minBranches;
    int alternate = -1;
    for (int i = 0; i < rand; i++) {
      float newLength = length * lengthScale;
      float newLendthD = random(newLength);
      alternate *= -1;
      float newAngle = angle + (alternate * radians(random(maxAngle - minAngle) + minAngle));
      float newX = x - (cos(angle) * (newLength + newLendthD));
      float newY = y - (sin(angle) * (newLength + newLendthD));
      tree(newX, newY, newAngle, newLength);
    }
  }