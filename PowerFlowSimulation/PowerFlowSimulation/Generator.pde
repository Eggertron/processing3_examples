class Generator extends Clickable implements BaseObject {
  private PImage img;
  
  Generator(float x, float y, PImage _img) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    isPowered = false;
    size = 85;
    img = _img;
    img.resize(size,0);
    offsetX = offsetY = halfSize = size / 2;
  }
  
  void update() {}
  void draw() {
    fill(0, 255, 255);
    //rect(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y);
    fill(255);
    text("Backup Generator", pos.x + 5, pos.y + 10);
  }
  void onClick() {
    if (isMouseOver()) {
      isUpdated = true;
      isPowered = isPowered ? false:true;
    }
  }
}