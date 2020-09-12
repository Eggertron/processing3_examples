/* SEL-451 Control System
*/
class SEL451 extends Clickable implements BaseObject {
  private SEL451 remote;
  private boolean delayDraw;
  private boolean delayFlip;
  private int counter;
  private PImage img;
  
  SEL451(float x, float y, PImage _img) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    isPowered = false;
    size = 50;
    img = _img;
    img.resize(size,0);
    halfSize = size / 2;
    offsetX = offsetY = 0;
    dragState = false;
    delayDraw = false;
    delayFlip = false;
    counter = 0;
  }
  void setRemoteSEL(SEL451 _remote) {
    remote = _remote;
  }
  void setRemoteDelayFlip(boolean status) { delayFlip = status; }
  void setIsPowered(boolean status) { isPowered = status; }
  void update() {
    if(delayFlip) {
      isUpdated = true;
      delayFlip = false;
      isPowered = !remote.isPowered();
      delay(500);
    }
    if(delayDraw) {
      isUpdated = true;
      if(counter++ ==2) {
        counter = 0;
        remote.setRemoteDelayFlip(true);
        delayDraw = false;
      }
      delay(1000);
    }
  }
  void draw() {
    noStroke();
    if (isPowered)
      fill(0, 255, 0);
    else
      fill(255, 0, 0);
    rect(pos.x, pos.y, size, size);
    image(img, pos.x, pos.y);
    fill(255);
    text("SEL", pos.x + 5, pos.y + 10);
  }
  void onClick() { 
    if(isMouseOver()) {
      isUpdated = true;
      isPowered = isPowered ? false : true;
      delayDraw = true;
    }
  }
}