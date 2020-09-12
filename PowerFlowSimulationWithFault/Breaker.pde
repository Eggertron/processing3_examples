class Breaker extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  
  Breaker() {
    super();
    size = 40;
    halfSize = size / 2;
    isPowered = true;
    myColor = BLUE;
  }
  
  void update() {}
  void draw() {
    stroke(0);
    fill(myColor);
    rect(pos.x, pos.y, size, size);
    fill(textColor);
    text("B", pos.x + halfSize, pos.y + halfSize);
  }
  void onClick() {
    if (isMouseOver()) {
      isUpdated = true;
      isPowered = isPowered ? false : true;
    }
  }
}