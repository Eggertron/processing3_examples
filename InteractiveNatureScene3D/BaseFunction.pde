class BaseFunction {
  float yPos(float x, float z) {
    return (-sin((x*x) + (z*z))/((x*x) + (z*z)) * height) + height;
  }
}