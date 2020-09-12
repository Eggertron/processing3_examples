// new tabs can be created and also classes.
// classes are not separate from the main file so
// the scope of the global variables will be available
// to each class.

class Player {
  PVector pos;
  PImage img;
  int stepSize;
  int size;
  boolean isAlive;
  
  public Player() {
    pos = new PVector();
    // quick cropping, add the animation later.
    PImage tmp = loadImage("spritesheetvolt_run.png");
    img = tmp.get(0, 0, tmp.width / 5, tmp.height / 2);
    pos.x = 50;
    pos.y = height / 2;
    stepSize = 10;
    size = 100;
    isAlive = true;
  }
  
  public void draw() {
    updateMovement();
    checkCollision();
    // this is the current character, need to make a real one.
    ellipse(pos.x, pos.y, size, size);
    //image(img, pos.x, pos.y, 200, 200);
  }
  
  private void updateMovement() {
    if (keyPressed) {
      if (key == 'w') {
        pos.y -= stepSize;
      }
      else if (key == 's') {
        pos.y += stepSize;
      }
    }
  }
  
  private void checkCollision() {
    if (pos.y < 0)
      pos.y = 0;
    else if (pos.y > height)
      pos.y = height;
    if (pos.y < audioPlayer.track[audioPlayer.current1]) {
      isAlive = false;
    }
    else if (pos.y > audioPlayer.track[audioPlayer.current1] + audioPlayer.distance) {
      isAlive = false;
    }
  }
}