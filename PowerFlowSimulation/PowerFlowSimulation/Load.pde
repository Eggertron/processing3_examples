class Load extends Clickable implements BaseObject {
  private PImage img;
  private String name;
  
  Load(float x, float y, PImage _img) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    img = _img;
    isPowered = true;
    size = 80;
    img.resize(size,0);
    offsetX = offsetY = halfSize = size / 2;
  }
  
  void update() {}
  void draw() {
    fill(0, 0, 255);
    //rect(pos.x, pos.y, size, size);
    //size(size, size);
    image(img, pos.x, pos.y); 
    fill(255);
    text(name, pos.x + 5, pos.y + 10);
  }
  void onClick() {}
  void setName(String n){name=n;}
}