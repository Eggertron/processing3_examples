class Relay extends Clickable implements BaseObject {
  
  Relay(float x, float y) {
    isPowered = true;
    dragState = false;
    size = 40;
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
    //ellipse(pos.x, pos.y, size, size);
    rect(pos.x, pos.y, size, size);
    fill(255);
    text("Relay", pos.x - halfSize, pos.y - halfSize);
  }
  void onClick() {
    if (isMouseOver()) {
        isUpdated = true;
        isPowered = isPowered?false:true;
    }
  }
}