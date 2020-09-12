class BoxObj {
  float _locX, _locY, _locZ;
  float _width, _height, _depth;
  float _rotX, _rotY, _rotZ;
  float _colorR, _colorG, _colorB;
  
  BoxObj() {
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
  
  void genRandom() {
    _locX = random(width * 2) - width;
    _locY = random(height * 2) - height;
    _locZ = random(width * 2) - width;
    _colorR = random(200);
    _colorG = random(200);
    _colorB = random(200);
  }
  
  void draw() {
    pushMatrix(); // translate() will not be persistent if we push and pop it from a matrix.
    fill(_colorR, _colorG, _colorB);
    translate(_locX, _locY, _locZ);
    box(_width, _height, _depth);
    text("Hello", _locX, _locY, _locZ);
    popMatrix();
  }
}