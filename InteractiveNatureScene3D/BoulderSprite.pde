class BoulderSprite {
  PImage img;
  BaseFunction _bf;
  float _locX, _locY, _locZ;
  float _width, _height, _depth;
  float _rotX, _rotY, _rotZ;
  float _colorR, _colorG, _colorB;
  
  BoulderSprite() {
    _bf = new BaseFunction();
    img = loadImage("PNG/rpgTile217.png");
    intBoulderSprite();
  }
  
  void intBoulderSprite() {
    float wid = width * 0.5;
    // use offsets to fit the objects onto the ground. ground will be the basic form of equations.
    float yOffset = 64;
    float xOffset = 32;
    _locX = random(width * 2) - width;
    _locZ = random(height * 2) - height;
    _locY = _bf.yPos(_locX / wid, _locZ / wid) - yOffset;
    _locX -= xOffset;
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
    translate(_locX, _locY, _locZ);
    tint(255, 255);
    image(img, 0, 0);
    //image(img, 0, 0, width/2, height/2);
    popMatrix();
  }
}