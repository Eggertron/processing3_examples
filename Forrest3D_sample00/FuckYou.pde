class FuckYou {
  private PShape shape;
  private PVector pos;
  
  public FuckYou() {
    pos = new PVector();
    pos.x = 0;
    pos.y = 0;
    pos.z = 0;
    shape = createShape();
    
  }
  
  public void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    shape(shape);
    popMatrix();
  }
  
  private void updatePos() {
  }
}