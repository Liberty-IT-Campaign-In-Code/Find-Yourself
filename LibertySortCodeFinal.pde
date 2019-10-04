String[] linesOrig;// = loadStrings("code.js");
String[] linesNew;// = loadStrings("code.js");
PImage test, mainStage;
PGraphics buffer, highLights;
IntList imageIndex = new IntList(); //// create an index
int slices=101;
int var1=0;

int w;
int xremain;
int sliceremain=slices;

int j = 0; 
int s = 0; 
int p = 0; 
float th; 

int frFast=120;
int frNorm=1;
int fr=25;
int frameRendered=0;

int predrawcount=0;
int xplot2=0; 

boolean predraw=false;

int lineStep=0;

Segment[] segments = new Segment[slices];

void setup() {
  size(1216, 2160);

  linesOrig=loadStrings("code.js");
  linesNew=loadStrings("code.js");

  background(255, 208, 0);
  test=loadImage("endframecrop2.jpg");
  test.resize(1216, 0);
  mainStage=createImage(width, test.height, ARGB);
  highLights=createGraphics(width, test.height);
  buffer=createGraphics(width, test.height);
  frameRate(25);

  w=test.width;
  randomSeed(99);
  init();
  frameCount=1;
}
float offy=0;
void draw() {
  background(255, 208, 0);
  translate(0, offy);

  //noTint();
  //image(buffer, 0, 0);
  //tint(255, 30);
  //image(highLights, 0, 0);     // disable for quick preview

  if (frameCount%4==0) {
    println(frameCount);
    if (predraw==false) {
      fr=frNorm;
      //frameRate(fr);
      // sort
      //for(int sa=0;sa

      //   updateText(var1);
      //   drawText();
      if (j<slices) {
        //var1=slices;
        //ellipse(random(width),random(height),50,50);
        //text(str(slices), 50, 50);
        float min = slices+1;
        for (int i = j; i<imageIndex.size(); ++i) {
          if (imageIndex.get(i) < min) { 
            min = imageIndex.get(i); 
            s = i;
          }
        }
        th = imageIndex.get(j); 
        imageIndex.set(j, int(min));//recs[j].h = min;
        imageIndex.set(s, int(th));//recs[s].h = th;
        j++;
      }

      // redraw 
      int xplot=0;

      buffer.beginDraw();
      highLights.beginDraw();
      highLights.clear();
      buffer.clear();
      for (int i=0; i<slices; i++) {
        int id=imageIndex.get(i);
        buffer.image(segments[id].img, xplot, 0, segments[id].xwidth, test.height);
        xplot+=segments[id].xwidth;
      }
      buffer.endDraw();
      //highLights.endDraw();


      // highlight s
      if (j!=slices) {

        int highlightx=segments[imageIndex.get(s)].xpos;
        int highlightwidth=segments[imageIndex.get(s)].xwidth;
        highLights.noStroke();

        highLights.fill(255, 0, 0);
        highLights.rect(highlightx, 0, highlightwidth, height, 20);
      }
      highLights.endDraw();
    }
    if (j==slices) {
      //noLoop();
      //background(255, 208, 0);
      //init();
      //noLoop();
    }
  }


  // code text
  translate(0, -offy);
  updateText(var1);
  //println(var1);
  drawText();



  //testDraw(var1);

  float frX=fr/25;
  if (frameCount%frX==0) {
    //saveFrame("anim14/anim14."+frameRendered+".jpg");
    println(frameRendered);
    frameRendered++;
  }
    noTint();
  image(buffer, 0, 0);
  tint(255, 30);
  image(highLights, 0, 0);     // disable for quick preview
  //println(frameRate);
  if(frameCount>260)noLoop();
  //noLoop();
  
  //saveFrame("anim2/anim2."+frameCount+".png");
  
}


class Segment {
  int index;
  int xpos, xwidth;
  PImage img;

  Segment(PImage source, int xpos_, int xwidth_, int index_) {
    index=index_;
    xpos=xpos_;
    xwidth=xwidth_;
    img=makeSegment(source, xpos, xwidth);
  }

  PImage makeSegment(PImage source, int xpos, int xwidth) {
    //PImage segment = createImage(xwidth, height, RGB);
    PImage segment = source.get(xpos, 0, xwidth, source.height);
    // get slice
    return segment;
  }
}

void init() {
  xremain=w;
  slices=int(random(10, 64));
  var1=slices;
  sliceremain=slices;

  j = 0; 
  s = 0; 
  p = 0; 
  //float th; 



  predrawcount=0;
  xplot2=0; 

  imageIndex.clear();
  for (int i=0; i<slices; i++) {
    imageIndex.append(i);
  }

  imageIndex.shuffle();

  while (sliceremain>=1) {
    int xwidth=(xremain/sliceremain);
    int xpos=w-xremain;
    segments[slices-sliceremain]=new Segment(test, xpos, xwidth, slices-sliceremain);
    xremain-=xremain/sliceremain;
    sliceremain--;
  }
  //predraw=true;
}
void updateText(int v1) {
  String s=linesOrig[0];
  //s= s.replace("slices", str(v1));
  linesNew[0]=s;

  s=linesOrig[1];
  //s= s.replace("slices", str(v1));
  linesNew[1]=s;


  s=linesOrig[5];
  //s= s.replace("i", str(int(random(j))));
  linesNew[5]=s;
}

void drawText() {


  textSize(52);

  for (int i = 0; i < linesNew.length; i++) {
    if (i==lineStep && predraw==false ) {
      fill(255, 0, 0);
    } else {
      fill(255, 255, 255);
    } 
  if(frameCount>200){fill(255, 255, 255);}
    
    int yoff=1300;  //650
    text(linesNew[i], 100, yoff+(i*60));
  }
  lineStep++;
  if (lineStep==linesNew.length)lineStep=0;
}

void testDraw(int n) {
  text(str(n), 50, 50);
}