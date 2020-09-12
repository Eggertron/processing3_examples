class Dot {
  PVector _location;
  float _radius;
  
  public Dot() {
    _location = new PVector();
    _radius = 5;
  }
  
  public Dot(float x, float y, float z) {
    _location = new PVector();
    _location.x = x;
    _location.y = y;
    _location.z = z;
    _radius = 5;
  }
  
  public void draw() {
    pushMatrix();
    noStroke();
    lights();
    fill(255);
    translate(_location.x, _location.y, _location.z);
    sphere(_radius);
    popMatrix();
  }
}