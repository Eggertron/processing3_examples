class Background {
  private PImage img;
  private PShape background;
  private int posX;
  
  public Background(PImage img) {
    this.img = img;
    background = createShape();
    background.beginShape();
    background.textureMode(NORMAL);
    background.vertex(0, 0, 0, 0);
    background.vertex(img.width, 0, 1, 0);
    background.vertex(img.width, img.height, 1, 1);
    background.vertex(0, img.height, 0, 1);
    background.endShape();
  }
  
  public void draw() {
    
  }
}