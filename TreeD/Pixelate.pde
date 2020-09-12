class Pixelate {
  private PImage original, result;
  
  public Pixelate() {
  }
  
  public PImage pixelate(PImage o, int scale) {
    o.loadPixels();
    result = createImage(o.width, o.height, RGB);
    int cellsize = scale,
        cols = o.width / cellsize,
        rows = o.height / cellsize;
        
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int x = i * cellsize + cellsize / 2;
        int y = j * cellsize + cellsize / 2;
        int loc = x + y * o.width; 
        color c = o.pixels[loc];
        result.pixels[loc] = c;
      }
    }
    return result;
  }
}