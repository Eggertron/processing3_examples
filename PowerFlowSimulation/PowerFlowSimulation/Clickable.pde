class Clickable {
  boolean dragState;
  PVector pos;
  int size;
  int halfSize;
  int offsetX, offsetY;
  boolean isPowered;
  
  Clickable() {
    pos = new PVector();
  }
  void onPressed() {
    if(!isObjectPressed && isMouseOver()) {
      isObjectPressed = true;
      dragState = true;
    }
  }
  void onReleased() {
    if(dragState) {
      dragState = false;
      isObjectPressed = false;
    }
  }
  void onDrag() {
    if (isMouseOver() && dragState) {
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
}