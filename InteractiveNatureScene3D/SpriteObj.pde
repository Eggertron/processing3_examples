class SpriteObj {
  PVector _location;
  PImage img;
  
  public SpriteObj(String file) {
    img = loadImage(file);
    _location = new PVector();
  }
  
  public void setLocation(float x, float y, float z) {
    _location.x = x;
    _location.y = y;
    _location.z = z;
  }
  
  void draw() {
    pushMatrix(); // translate() will not be persistent if we push and pop it from a matrix.
    fill(100, 0, 0);
    translate(_location.x + (mouseX * 0.5), _location.y, _location.z);
    tint(255, 255);
    image(img, 0, 0);
    //image(img, 0, 0, width/2, height/2);
    popMatrix();
  }
}