class Generator extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  private PImage img;
  
  Generator() {
    super();
    size = MAXSIZE;
    halfSize = size / 2;
    isPowered = false;
    img = _img_generator;
    img.resize(size, 0);
    myColor = BLUE;
  }
  
  void update() {}
  
  void draw() {
    //stroke(0);
    //fill(myColor);
    //rect(pos.x, pos.y, size, size);
    //fill(textColor);
    //text("G", pos.x + halfSize, pos.y + halfSize);
    image(img, pos.x, pos.y);
  }
  void onClick() {
    if (isMouseOver() && (isNodeFault() || isSecondaryFault() || isSecondaryBreaker() || isMainFault() )) {
      isUpdated = true;
      isPowered = isPowered ? false : true;
    }
  }
}