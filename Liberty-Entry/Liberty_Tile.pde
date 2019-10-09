final static int GRID = 10, NUM = GRID*GRID;
final PImage[] pieces = new PImage[NUM];
PImage img;
 
int jigX, jigY;
boolean isShuffling = true;
 
void setup() {
  size(1216, 2160);
  frameRate(.5);
 
  img = loadImage("336x280-static.jpg");
 
  jigX = (int) (img.width/GRID);  // (int) is to force integer division for JS!
  jigY = (int) (img.height/GRID);
 
  final int diff = img.height - (jigY>>2);
  int i = 0, jx = 0, jy = 0;
 
  while (i != NUM) {
    pieces[i++] = img.get(jx, jy, jigX, jigY);
 
    if ((jy += jigY) > diff) {
      jx += jigX;
      jy = 0;
    }
  }
}
 
void draw() {
  //background(img);
 
  if (isShuffling) for ( int i = 0; i != NUM;
    image(pieces[i++], (int) random(GRID)*jigX, (int) random(GRID)*jigY) );
 
  else for ( int i = 0; i != NUM; 
    image(pieces[i], (int) (i/GRID) * jigX, i++ % GRID * jigY) );
}
 
void mousePressed() {
  isShuffling = !isShuffling;
}
 
void keyPressed() {
  mousePressed();
}
