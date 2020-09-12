/*
  Testing out some of the WebCam Capture methods
*/

import processing.video.*;

private Capture cam;

float THRESHOLDVALUE = 0.8;
int BLACK = color(0, 0, 0);
int WHITE = color(255, 255, 255);
int[] detection;
int detectionHeight;
boolean isInitialized;

void setup() {
  //size(1280, 720, P3D);
  size(900, 900, P3D);
  initCapture();
  isInitialized = false;
}

void draw() {
  background(124);
  updateCapture();
}

void initCapture() {
  String[] cameras = Capture.list();
  if (cameras.length == 0) println("No Cameras Available");
  else for (int i = 0; i < cameras.length; i++) println("Camera["+i+"] is "+cameras[i]);
  //cam = new Capture(this, cameras[0]);
  cam = new Capture(this, cameras[25]);
  cam.start();
  if (cam.available()) cam.read();
}

void updateCapture() {
  if (cam.available() == true) {
    cam.read();
    if (!isInitialized) {
      isInitialized = true;
      detectionHeight = cam.height / 2; // about the center of the camera
      detection = new int[cam.width];
    }
    //cam.filter(THRESHOLD);
    //println("camera width: " + cam.width);
    //println("camera height: " + cam.height);
    //println("black is: " + BLACK);
    //println("white is: " + WHITE);
    //printMatrix(pixelateImage(100));
    MotionDetection(cam);
    printArray(detection);
  }
  //image(cam, 0, 0);
  //set(0, 0, cam); // this is faster if we just want to throw it up on screen. but does not work well with capture.
  //filter(THRESHOLD);
  
  //loadPixels();    // now loaded to pixels
  // do stuff with pixel array here
  //updatePixels(); // finalize the pixels
  set(0, 0, cam); // this is faster if we just want to throw it up on screen. but does not work well with capture.
  //filter(THRESHOLD);
}

void MotionDetection(PImage img) {
  int y = (int)(img.height * 0.5); // half of the height;
  img.loadPixels();
  img.filter(THRESHOLD, THRESHOLDVALUE);
  for (int i = 0; i < detection.length; i++) detection[i] = img.pixels[detectionHeight * img.width + i] == BLACK ? 0 : 1;
  if (img.pixels != null)  println("array size: " + img.pixels.length);
  if (img.pixels[y * img.width + 10] > BLACK ) {
    println("something on the right?");
    println("color value: " + img.get(10, (int)(cam.height * 0.5)));
  }
  if (img.pixels[y * img.width + (img.width - 10)] > BLACK ) {
    println("something on the left?");
    println("color value: " + img.get(500, (int)(cam.height * 0.5)));
  }
  img.updatePixels();
}

int[][] pixelateImage(int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (cam.width < cam.height) {
    ratio = cam.height/cam.width;
  }
  else {
    ratio = cam.width/cam.height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  
  // create a matrix to send data back
  int[][] result = new int[pxSize][pxH];
  int col, xR = 0, yR = 0;
  
  noStroke();
  for (int x = 0; x < cam.width; x += pxSize) {
    for (int y = 0; y < cam.height; y += pxH) {
      col = cam.get(x, y);
      fill(col);
      rect(x, y, pxSize, pxH);
      result[xR++][yR] = col;
    }
    yR++;
    xR = 0;
  }
  return result;
}

void printMatrix(int[][] matrix) {
  println("width: " + matrix[0].length);
  println("height: " + matrix.length);
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[0].length; j++)
      print(" " + matrix[i][j]);
    print("\n");
  }
}

void printArray(int[] array) {
  println("Array length: " + array.length);
  for( int i = 0; i < array.length; i++) print(array[i]);
  print("\n");
}