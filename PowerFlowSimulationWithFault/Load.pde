class Load extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  int load;
  PImage img;
  
  Load() {
    super();
    size = MAXSIZE;
    halfSize = size / 2;
    img = _img_load;
    img.resize(size, 0);
  }
  
  Load(int l) {
    super();
    size = MAXSIZE;
    halfSize = size / 2;
    load = l;
    img = _img_load;
    img.resize(size, 0);
  }
  
  void update() {}
  void draw() {
    stroke(0);
    //fill(myColor);
    //rect(pos.x, pos.y, size, size);
    //fill(textColor);
    //text("L", pos.x + halfSize, pos.y + halfSize);
    image(img, pos.x, pos.y);
  }
  void onClick() {}
  int getLoad() { return load; }
  void setLoad(int l){load = l;}
}