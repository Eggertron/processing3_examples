// Author: Edgar Han
// Sound Inspirations: Electroplankton
// oct 3 page proposal, address the tree question.

// constant values;
final float eyeCenterX = width/2, eyeCenterY = height/2, eyeCenterZ = (height/2) / tan(PI/6);
final float sceneCenterX = width/2, sceneCenterY = height/2, sceneCenterZ = 0;
final float upCenterX = 0, upCenterY = 1, upCenterZ = 0;

boxObj[] _box;
float eyeX, eyeY, eyeZ;
float camX, camY, camZ;
float upX, upY, upZ;
float mouseZ;

void setup() {
  size(800, 800, P3D);
  genBoxes(100);
  initCamera();
  mouseZ = 0;
}

void draw() {
  background(255);
  updateCamera();
  updateBoxes();
  drawHUD();
}

void mouseDragged() {
  
}

void mouseClicked() {}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // negative for upscroll, positive for downscroll.
  //println(e);
  mouseZ += e * 50;
}

/*
  Consider the vanishing points of the 3D space, is it set by the size() function?
*/
void updateCamera() {
  //camX = mouseY - (height * 0.5);
  //camY = mouseX - (width * 0.5);
  int scale = 9;
  camera((mouseY -(height * 0.5)) * scale, eyeCenterY + mouseZ, (eyeCenterZ + (mouseX - (width * 0.5))) * scale, sceneCenterX, camY, camZ, 
       upX, upY, upZ);
}

void updateBoxes() {
  for (int i = 0; i < _box.length; i++) {
    _box[i].draw();
  }
}

void genBoxes(int numOfBoxes) {
  _box = new boxObj[numOfBoxes];
  for (int i = 0; i < numOfBoxes; i++) {
    _box[i] = new boxObj();
    // define the parameters of the box;
    // why does this algorithm line the boxes up linear?
    _box[i]._locX = random(800);
    _box[i]._locY = random(800);
    _box[i]._locZ = random(800);
    _box[i]._colorR = random(200);
    _box[i]._colorG = random(200);
    _box[i]._colorB = random(200);
  }
}

void initCamera() {
  eyeX = eyeCenterX;
  eyeY = eyeCenterY;
  eyeZ = eyeCenterZ;
  camX = sceneCenterX;
  camY = sceneCenterY;
  camZ = sceneCenterZ;
  upX = upCenterX;
  upY = upCenterY;
  upZ = upCenterZ;
}

void drawHUD() {
  int varTextSize = 24;
  int locTextY = 60;
  camera();    // reset the camera view
  noLights();
  textSize(varTextSize);
  fill(0);
  stroke(0);
  text("mouseX: " + mouseX, 0, locTextY);
  locTextY += varTextSize;
  text("mouseY: " + mouseY, 0, locTextY);
  locTextY += varTextSize;
  text("number of boxes: " + _box.length, 0, locTextY);
  locTextY += varTextSize;
  text("mouse scroll offset: " + mouseZ, 0, locTextY);
}

class boxObj {
  float _locX, _locY, _locZ;
  float _width, _height, _depth;
  float _rotX, _rotY, _rotZ;
  float _colorR, _colorG, _colorB;
  
  boxObj() {
    _locX = 100;
    _locY = 110;
    _locZ = 110;
    _width = 100;
    _height = 100;
    _depth = 100;
    _colorR = 100;
    _colorG = 0;
    _colorB = 0;
  }
  
  void draw() {
    pushMatrix(); // translate() will not be persistent if we push and pop it from a matrix.
    fill(_colorR, _colorG, _colorB);
    //translate(); // need to reset because it is cumulative.
    translate(_locX, _locY, _locZ);
    box(_width, _height, _depth);
    popMatrix();
  }
}