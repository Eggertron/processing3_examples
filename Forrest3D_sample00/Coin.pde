class Coin {
  private PShape[] shape;
  private PVector pos, tmp;
  private int index, frames = 10, counter, coins, coinX;
  private float theta;
  private boolean isActive;
  
  public Coin(PImage img) {
    pos = new PVector();
    pos.x = 0;
    pos.y = -400;
    pos.z = 2500;
    shape = new PShape[frames];
    int frameW = img.width / frames;
    for (int i = 0; i < frames; i++) {
      shape[i] = createShape();
      shape[i].beginShape();
      shape[i].texture(img.get(i * frameW, 0, img.width + 1, img.height));
      shape[i].vertex(0, 0, 0, 0);
      shape[i].vertex(frameW, 0, frameW, 0);
      shape[i].vertex(frameW, img.height, frameW, img.height);
      shape[i].vertex(0, img.height, 0, img.height);
      shape[i].endShape();
    }
    counter = 0;
    coins = 0;
    isActive = false;
  }
  
  public void draw() {
    if (isActive) {
      updatePos();
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rotateY(theta);
      shape(shape[index = (index + 1) % frames]);
      //shape(shape[index]);
      if (counter-- == 0) {
        counter = 2;
        //index = (index + 1) % frames;
      }
      popMatrix();
    }
    else {
      if ((int)random(10) == 0) {
        int index = (int)random(trees.length);
        initCoin(trees[index].pos, (int)random(1));
      }
    }
  }
  
  public void initCoin(PVector p, int n) {
    pos.x = p.x;
    pos.y = p.y;
    pos.z = p.z;
    tmp  = p;
    coins = n;
    isActive = true;
    theta = random(radians(360));
    coinX = 5;
  }
  
  private void updatePos() {
    if (pos.y > 1) {
      initCoin(tmp, coins - 1);
    }
    if (coins == 0) isActive = false;
    pos.y = tmp.y - 625 + pow(coinX--, 2);
    pos.x -= 2;
  }
}