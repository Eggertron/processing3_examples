class SaveButton extends Clickable {
  SaveButton(float x, float y) {
    super();
    pos.x = x;
    pos.y = y;
    size = 30;
    halfSize = size/2;
  }
  void draw() {
    fill(0,255,0);
    rect(pos.x, pos.y, size, size);
    fill(0);
    text("SAVE", pos.x + 5, pos.y + 10);
  }
  void onClick() {
    if (isMouseOver())
      saveFile();
  }
}