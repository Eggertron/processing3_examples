class FuseSwitch extends Clickable implements BaseObject {
  //private PVector pos;
  //private int size;
  //private boolean dragState;
  private PImage img;
  
  FuseSwitch(float x, float y, PImage _img) {
    isPowered = true;
    dragState = false;
    size = 55;
    img = _img;
    img.resize(size, 0);
    halfSize = size / 2;
    offsetX = offsetY = -halfSize;
    pos = new PVector();
    pos.x = x;
    pos.y = y;
  }
  void update() {
  }
  void draw() {
    stroke(0);
    if (!isPowered)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    //rect(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y);
    fill(255);
    text("Fuse/Switch", pos.x+5, pos.y+10);
  }
  void onClick() {
    if (isMouseOver()) {
        isUpdated = true;
        isPowered = isPowered?false:true;
    }
  }
}