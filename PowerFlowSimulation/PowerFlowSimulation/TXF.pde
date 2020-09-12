class TXF extends Clickable implements BaseObject {
  private PImage img;
  
  TXF(float x, float y, PImage _img) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    img = _img;
    isPowered = true;
    size = 80;
    img.resize(size,0);
    offsetX = offsetY = halfSize = size / 2;
  }
  
  void update() {}
  void draw() {
    fill(255, 0, 255);
    //rect(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y);
    fill(255);
    text("TXF", pos.x + 5, pos.y + 10);
  }
  void onClick() {}
}