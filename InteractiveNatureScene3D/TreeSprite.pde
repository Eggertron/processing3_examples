class TreeSprite {
  PImage img;
  BaseFunction _bf;
  float _locX, _locY, _locZ;
  float _width, _height, _depth;
  float _rotX, _rotY, _rotZ;
  float _colorR, _colorG, _colorB;
  String note;
  String[] notes;
  boolean isPlaying;
  SineInstrument sounds;
  
  TreeSprite() {
    _bf = new BaseFunction();
    notes = new String[] {"A3", "B3", "C3", "D3", "E3", "F#3", "G3"};
    img = loadImage("PNG/rpgTile195.png");
    initTreeSprite();
  }
  
  void initTreeSprite() {
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
    _depth = _locY;
    _colorR = 100;
    _colorG = 0;
    _colorB = 0;
    note = notes[(int)random(notes.length)];
    isPlaying = false;
  }

  void draw() {
    pushMatrix(); // translate() will not be persistent if we push and pop it from a matrix.
    fill(_colorR, _colorG, _colorB);
    translate(_locX, _locY, _locZ);
    tint(255, 255);
    image(img, 0, 0);
    //image(img, 0, 0, width/2, height/2);
    popMatrix();
    if ((int)random(100000) == 0) {
      play(note);
      isPlaying = true;
    }
    if (isPlaying) {
      updatePlay();
    }
  }
  
  // a simple animation for when the musical note is played.
  void updatePlay() {
    _locY -= 5;
    if (_depth - _locY > 100) {
      _locY = _depth;
      isPlaying = false;
    }
  }
}