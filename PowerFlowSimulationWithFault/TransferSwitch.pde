class TransferSwitch extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  
  TransferSwitch() {
    super();
    size = 40;
    halfSize = size / 2;
    isPowered = true;
    myColor = GREEN;
  }
  
  void update() {}
  void draw() {
    stroke(0);
    fill(BLUE);
    rect(pos.x, pos.y, size, size);
    fill(textColor);
    text("TS", pos.x + halfSize, pos.y + halfSize);
  }
  void onClick() {}
}