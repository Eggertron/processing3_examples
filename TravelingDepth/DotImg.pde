class DotImg {
  PImage img;
  PVector _location;
  
  public DotImg() {
    _location = new PVector();
    img = createImage(10, 10, ARGB);
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      //img.pixels[i] = color(255, 255, 255, i % img.width * 2); 
      img.pixels[i] = color(255, 255, 255, 180); 
    }
    img.updatePixels();
  }
  
  public void draw(int tint) {
    pushMatrix();
    translate(_location.x, _location.y, _location.z);
    tint(255, tint);
    image(img, 0, 0);
    // find out how to efficiently add blur
    popMatrix();
  }
}