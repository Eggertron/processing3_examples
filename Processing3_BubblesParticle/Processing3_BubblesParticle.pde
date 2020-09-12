Bubble[] bubbles;

void setup() {
  size(800, 800);
  //background(125);
  //frameRate(15);
  
  int numOfBubbles = 100;
  bubbles = new Bubble[numOfBubbles];
  
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i] = new Bubble();
  }
}

void draw() {
  background(125);  // resets the backgrond every frame.
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i].update();
  }
}

class Bubble {
  private int _locY, _locX, _speed,
    _diameter, _hue;  
  private Bubble[] _children;
  private boolean _popped, _isChild;
  
  // constructor for a parent bubble
  Bubble() {
    initValues();
    _isChild = false;
  }
  // constructor for child bubbles
  Bubble(int locX, int locY, int diam) {
    initValues();
    _locX = locX;
    _locY = locY - 5;
    _diameter = (int)(diam * 0.5);
    if (_diameter < 2) {
      _diameter = 5;
    }
    _isChild = true;
  }
  
  public int update() {
    
    // check mouse location, then simulate pop and reset the bubble.
    if (abs(mouseX - _locX) < _diameter * 0.5 && abs(mouseY - _locY) < _diameter * 0.5)
    {
      _children = new Bubble[2];
      // initialize the children.
      _children[0] = new Bubble(_locX - 5, _locY, _diameter);
      _children[1] = new Bubble(_locX + 5, _locY, _diameter);
      _popped = true;
    }
    
    if( _popped ) {
      if( _children[0].update() == 1 && _children[1].update() == 1 ) {
        initValues();
      }
    }
    else {
      _locY = _locY - _speed;
      fill(100, 100, _hue);
      ellipse(_locX, _locY, _diameter, _diameter);
    
      // if bubble reaches the top, reset the bubble
      if (_locY < 1) {
        if (_isChild) {
          return 1;
        }
        else {
          initValues();
        }
      }
    }
    return 0;
  }
  
  private void initValues() {
    _locY = height;
    _locX = (int)random(width);
    _speed = (int)random(10) + 1;
    _diameter = 30 + (int)random(30);
    _hue = 100 + (int)random(100);
    _popped = false;
    _children = null;
  }
}
