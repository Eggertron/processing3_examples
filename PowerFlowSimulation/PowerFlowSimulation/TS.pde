class TS extends Clickable implements BaseObject {
  
  TS(float x, float y) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    isPowered = true;
    size = 50;
    offsetX = offsetY = halfSize = size / 2;
  }
  
  void update() {}
  void draw() {
    fill(0, 0, 255);
    rect(pos.x, pos.y, size, size);
    fill(255);
    text("Transfer Switch", pos.x, pos.y);
  }
  void onClick() {}
}