class Dots {
  //Dot[] _dots;
  DotImg[] _dots;
  int _n;
  int start = -height * 2;
  int speed = 5;
  int end = (int)(height * 0.8);
  int range = end - start;
  int _z;
  
  public Dots(int n, int z) {
    _n = n;
    _z = z;
    init();
  }
  
  public void init() {
    _dots = new DotImg[_n * _n];
    int counter = 0;
    
    float stepX = width / _n;
    float stepY = height / _n;
    int offsetX = (int)(width - (stepX * 0.5));
    int offsetY = (int)(height - (stepY * 0.5));
    
    for (int i = 0; i < _n; i++) {
      for (int j = 0; j < _n; j++) {
        _dots[counter] = new DotImg();
        _dots[counter]._location.x = j + offsetX - (j * stepX);
        _dots[counter]._location.y = i + offsetY - (i * stepY);
        _dots[counter]._location.z = start + _z;
        counter++;
      }
    }
  }
  
  public void draw() {
    int alpha;
    for (int i = 0; i < _dots.length; i++) {
      _dots[i]._location.z += speed;
      if (_dots[i]._location.z > end) {
        _dots[i]._location.z = start;
      }
      alpha = (int)(254 * (_dots[i]._location.z - start) / range);
      //println(start);
      _dots[i].draw(alpha);
    }
  }
}