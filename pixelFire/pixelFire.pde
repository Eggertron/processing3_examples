PImage firePixels;
int FIRE_WIDTH, FIRE_HEIGHT, COLOR_STEP;

void setup() {
  FIRE_WIDTH = 250;
  FIRE_HEIGHT = 36;
  COLOR_STEP = 10;
  size(250, 250);
  colorMode(HSB, 36, 1, 1);
  firePixels = createImage(FIRE_WIDTH, FIRE_HEIGHT, RGB);
  initPixels();
  frameRate(10);
}

void draw() {
  // calculate fire particles
  doFire();
  // update fire image object with pixel set
  firePixels.updatePixels();
  // display fire image object
  image(firePixels, 0, 100);
}

void doFire() {
  for (int x = 0; x < FIRE_WIDTH; x++) {
    for (int y = 1; y < FIRE_HEIGHT; y++) {
      spreadFire(y * FIRE_WIDTH + x);
    }
  }
}

void spreadFire(int src) {
  int pixel = firePixels.pixels[src];
  if(pixel == 255) {
    firePixels.pixels[src - FIRE_WIDTH] = 255;
  } else {
    int rand = round(random(0, 3.0));
    int dst = src + rand + 1;
    firePixels.pixels[dst - FIRE_WIDTH] = firePixels.pixels[src] - (rand & 1);
  }
}

void initPixels() {
  for (int x = 0; x < FIRE_WIDTH; x++) {
    for (int y = 1; y < FIRE_HEIGHT; y++) {
      firePixels.pixels[x * y] = color(36);
    }
  }
  // set bottom line
  for(int i = 0; i < FIRE_WIDTH; i++) {
    firePixels.pixels[(FIRE_HEIGHT-1)*FIRE_WIDTH + i] = color(0);
  }
}
