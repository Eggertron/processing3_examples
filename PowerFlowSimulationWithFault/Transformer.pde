class Transformer extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  PImage img;
  
  Transformer() {
    super();
    size = MAXSIZE;
    halfSize = size / 2;
    img = _img_transformer;
    img.resize(size, 0);
  }
  
  void update() {}
  void draw() {
    //stroke(0);
    //fill(myColor);
    //rect(pos.x, pos.y, size, size);
    //fill(textColor);
    //text("T", pos.x + halfSize, pos.y + halfSize);
    image(img, pos.x, pos.y);
  }
  void onClick() {}
}