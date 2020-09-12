class PowerSource extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  String title;
  PImage img;
  
  PowerSource(String _title) {
    super();
    size = MAXSIZE;
    halfSize = size / 2;
    title = _title;
    isPowered = true;
    img = _img_powerstation;
    img.resize(size, 0);
  }
  
  void update() {}
  void draw() {
    //stroke(0);
    //fill(myColor);
    //rect(pos.x, pos.y, size, size);
    //fill(textColor);
    //text(title, pos.x + halfSize, pos.y + halfSize);
    image(img, pos.x, pos.y);
  }
  void onClick() {}
}