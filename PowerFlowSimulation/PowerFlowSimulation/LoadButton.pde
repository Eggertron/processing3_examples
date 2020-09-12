class LoadButton extends Clickable {
  LoadButton(float x, float y) {
    super();
    pos.x = x;
    pos.y = y;
    size = 100;
    halfSize = size /2;
  }
  void draw() {
    fill(0,255,0);
    rect(pos.x, pos.y, size, size);
    fill(0);
    text("LOAD", pos.x+5, pos.y+10);
  }
  void onClick() {
    if(isMouseOver()) {
      isUpdated = true;
      loadFile();
    }
  }
}