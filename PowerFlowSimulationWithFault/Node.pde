class Node extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  Node() {
    super();
    size = 40;
    halfSize = size / 2;
    myColor = GREEN;
  }
  
  void update() {}
  void draw() {
    stroke(0);
    fill(myColor);
    rect(pos.x, pos.y, size, size);
    fill(textColor);
    text("N", pos.x + halfSize, pos.y + halfSize);
  }
  void onClick() {
    if ( isMouseOver() ) {
      isUpdated = true;
      isPowered = isPowered ? false : true;
      if (this == controlBox.node1)
        controlBox.syncNode1();
      else if (this == controlBox.node2)
        controlBox.syncNode2();
    }
  }
}