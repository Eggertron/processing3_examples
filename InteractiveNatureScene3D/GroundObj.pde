class GroundObj {
  PVector[] _points;
  float _n;
  float _scale;
  BaseFunction _bf;
  
  GroundObj() {
    _bf = new BaseFunction();
    _scale = 2;
    int n = 100;
    initGround(100);
  }
  
  void initGround(int n) {
    _n = n * 0.5;    // use only half the pixel count.
    int nn = (int)(_n * _n);
    float nWidth = width * 2 / _n;
    float nHeight = height * 2 / _n;
    float nWidthHalf = nWidth * 0.5;
    float nHeightHalf = nHeight * 0.5;
    float wid = width * 0.5;
    float hei = height * 0.5;
    float x = 0, y = 0;
    
    _points = new PVector[nn];
    for (int i = 0; i < nn; i++) {
      _points[i] = new PVector();
      _points[i].x = (x * nWidth) - width;
      _points[i].y = (y * nHeight) - height;
      _points[i].z = _bf.yPos(_points[i].x / wid, _points[i].y / hei);
      if (x++ >= _n) {
        x = 0;
        y++;
      }
    }
  }
  
  void draw() {
    float nn = _n * _n;
    
    for (int i = 0; i < nn; i++) {
      if (i > 0) {
        stroke(0, 255, 0);
        line(_points[i - 1].x, _points[i - 1].z, _points[i - 1].y,  _points[i].x, _points[i].z, _points[i].y);
      }
    }
    
    line(width, 0, height, -width, 0, height);
    line(width, 0, height, width, 0, -height);
    line(-width, 0, height, -width, 0, -height);
    line(width, 0, -height, -width, 0, -height);
  }
}