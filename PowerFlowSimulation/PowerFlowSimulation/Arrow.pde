class Arrow extends Clickable implements BaseObject {
  Arrow(float x, float y){
    super();
    pos.x = x;
    pos.y = y;
    size = 20;
    halfSize = size / 2;
    isPowered = true;
  }
  void draw(){
    strokeWeight(10);
    stroke(0,255,0);
    line(pos.x, pos.y, pos.x+halfSize, pos.y+halfSize);
    line(pos.x+halfSize, pos.y+halfSize, pos.x, pos.y+(2*halfSize));
  }
  void onClick(){}
  void update(){}
}