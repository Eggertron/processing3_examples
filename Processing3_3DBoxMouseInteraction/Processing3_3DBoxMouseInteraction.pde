// Author: Edgar H. Han
// Playing with a 3D box and mouseClicked function
// mouse clicks toggles from wireframe mode to color fading
// mode that ratates with mouse lacation movements.

// Global Variables
private int _rotY, _rotX, _rotZ, _red, _fade;
private boolean _isToggled;
private String[] _lines, _dataSet;

void setup() {
  size(800, 800, P3D);
  //frameRate(10);
  _rotY = 0;
  _rotX = 0;
  _rotZ = 0;
  _red = 1;
  _fade = 3;
  _isToggled = false;
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //println("User selected " + selection.getAbsolutePath());
    _lines = loadStrings(selection.getAbsolutePath());
    _dataSet = new String[(int)(_lines.length * 0.5)];
    
    for (int i = 1, j = 0; i < _lines.length; i += 2 ) {
      _dataSet[j] = _lines[i];
      j++;
    }
  }
}

void draw() {
  if(!_isToggled)
    background(125);
    
  _rotY += 2;
  translate(width / 2, height / 2, 0);
  rotateY(radians(_rotY));
  
  if(_isToggled) {
    if(_red < 1 || _red > 254)
      _fade *= -1;
      
    _red += _fade;
    fill(_red, 0, 255);
    
    _rotX = mouseX - width;
    _rotZ = mouseY - height;
    rotateX(radians(_rotX));
    rotateZ(radians(_rotZ));
  }
  else
    noFill();
    
  box(width / 2, height / 3, 50);
  
  
}

void mouseClicked() {
  if(_isToggled) {
    _isToggled = false;
  }
  else {
    _isToggled = true;
  }
}
