class Clickable {
  boolean dragState;
  PVector pos;
  int size;
  int halfSize;
  boolean isPowered;
  color myColor;
  
  Clickable() {
    pos = new PVector();
    pos.x = width / 2;
    pos.y = height / 2;
    isPowered = true;
  }
  void onPressed() {
    if(!isObjectPressed && isMouseOver()) {
      isObjectPressed = dragState = true;
    }
  }
  void onReleased() {
    if(dragState) {
      dragState = isObjectPressed = false;
    }
  }
  void onDrag() {
    if (dragState) {
      isUpdated = true;
      pos.x = mouseX - halfSize;
      pos.y = mouseY - halfSize;
    }
  }
  boolean isMouseOver() {
    if (mouseX >= pos.x && mouseX <= (pos.x + size)
      && mouseY >= pos.y && mouseY <= (pos.y + size))
      return true;
    else
      return false;     
  }
  void setX(float _x) {pos.x = _x;}
  void setY(float _y) {pos.y = _y;}
  void setIsPowered(boolean status) { isPowered = status; }
  void setHalfSize(int s){halfSize = s;}
  int getHalfSize(){return halfSize;}
  float getX() { return pos.x + halfSize; }
  float getY() { return pos.y + halfSize; }
  boolean isPowered() { return isPowered; }
  void setColor(color c) { myColor = c; }
  
  void onClick() {}
}