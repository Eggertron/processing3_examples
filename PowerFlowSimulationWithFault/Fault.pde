class Fault extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  
  Fault() {
    super();
    size = 40;
    halfSize = size / 2;
    isPowered = true;
    myColor = GREEN;
  }
  
  void update() {}
  void draw() {
    stroke(0);
    fill(myColor);
    rect(pos.x, pos.y, size, size);
    fill(textColor);
    text("F", pos.x + halfSize, pos.y + halfSize);
  }
  void onClick() {
    if (isMouseOver()) {
      isUpdated = true;
      isPowered = isPowered ? false : true;
    }
  }
}