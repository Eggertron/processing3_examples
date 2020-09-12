class PowerSource extends Clickable implements BaseObject {
  //private PVector pos;
  //private int size;
  //private int halfSize;
  private PImage img;
  
  PowerSource(float x, float y, PImage _img) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    isPowered = true;
    img = _img;
    size = 100;
    img.resize(size,0);
    halfSize = size / 2;
    offsetX = offsetY = size;
  }
  void update() {}
  void draw() {
    fill(0, 255, 0);
    //rect(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y);
    fill(0);
    text("Sub Station", pos.x + 5, pos.y + 10);
  }
  void onClick() {}
}