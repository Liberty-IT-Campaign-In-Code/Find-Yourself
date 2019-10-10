PImage libertyIT;  
 
void setup() {
  size(1216, 2160);
  //background(255, 208, 0);
  libertyIT = loadImage("endframecrop2.jpg");
  
  // This breaks and causes null pointer.
  libertyIT.resize(1216, 0);
}
 
void draw() {
  //image(libertyIT, 0, 0);
  //loadPixels();
  //libertyIT.loadPixels();
  //for (int x = 0; x < width; x++) {
  //  for (int y = 0; y < height; y++) {
      
  //    int loc = x+y*width;
  //    float r = red(libertyIT.pixels[loc]);
  //    float g = green(libertyIT.pixels[loc]);
  //    float b = blue(libertyIT.pixels[loc]);
  //    float d = dist(width/2, height/2, x, y);
  //    float factor = map(d, 0, 200, 0, 2);
  //    pixels[loc] = color(r*factor, g*factor, b*factor);
  //  }
  //}
  //updatePixels();
}
