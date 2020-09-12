
// put global variables here
Player player;
Audio audioPlayer;
// this function is run before other function by processing.
void setup() {
  //size( 1000, 1000); // creates a window that is 1000x1000
  fullScreen();  // this is fullscreen mode.
  initialize();
}

// this function is run automatically by processing
// should be synced with framerate variable.
void draw() {
  // update the background
  
  // draw the player
  if (audioPlayer.player.isPlaying() && player.isAlive) {
    //background(124);
    background(map(audioPlayer.player.left.get(1000), -1, 1, 0, 255));
    audioPlayer.draw();
    player.draw();
  }
  if (!player.isAlive) {
    audioPlayer.player.pause();
    initialize();
    text("You Died!", width / 2, height / 4);
  }
}

void initialize() {
  background(0);
  player = new Player();
  audioPlayer = new Audio();
  audioPlayer.setup(this);
  text("Press Space to Begin", width / 2, height / 2);
}

void keyPressed() {
  audioPlayer.keyPressed();
}