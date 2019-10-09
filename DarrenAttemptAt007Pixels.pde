PImage libertyIT;
String[] linesOrig;// = loadStrings("code.js");
String[] linesNew;// = loadStrings("code.js");

void setup() {
  size(1216, 2160);
  background(255, 208, 0);
  
  //linesOrig=loadStrings("code.js");
  //linesNew=loadStrings("code.js");
  
  libertyIT = loadImage("endframecrop2.jpg");
  libertyIT.resize(1216, 0);
}

void draw() {
  //image(libertyIT, 0, 0);
  libertyIT.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      println("x = " + x);
      println("y = " + y);
      println("width = " + width);
      int loc = x+y*width;
       println("loc = " + loc);
      float r = red(libertyIT.pixels[loc]);
      println("red = " + loc);
      float g = green(libertyIT.pixels[loc]);
      println("green = " + loc);
      float b = blue(libertyIT.pixels[loc]);
      println("blue = " + loc);
      float d = dist(width/2,height/2,x,y);
      println("dist = " + loc);
      
      // Should be brighter towards center and darker towards edge
      // Creating a kind of "007 shot"
      // But my RGB pixel count keeps returning 0, sad
      float factor = map (d, 0, 200, 2, 0);
      pixels[loc] = color(r*factor, g*factor, b*factor);
      //pixels[loc] = color(r+mouseX, g+mouseX, b+mouseX);
    }
  }
  updatePixels();
}
  
// Output

//x = 0
//y = 0
//width = 1216
//loc = 0
//red = 0
//green = 0
//blue = 0
//dist = 0
//NullPointerException
  
 