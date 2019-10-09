int FRAME_RATE = 60; // Max 60 fps
int RUNTIME_SECONDS = 30; // How long should the simulation last in seconds
int START_DELAY = FRAME_RATE * 4; // How long to wait before starting the simulation. FRAME_RATE * <Seconds>
int SIMULATIONS_PER_FRAME = 1; // Number of simulation iterations to run per frame. 1 or 2 recommended

/* "Physics" Variables: 0 to 100 */
int CHANCE_TO_MOVE_HORIZONTAL = 40;
int CHANCE_TO_MOVE_LEFT = 48;
int CHANCE_TO_MOVE_DOUBLE_DOWN = 50;

int CHANCE_TO_NOT_MOVE = 100; // Chance not to move that slowly decays from the start of the simulation
int DECAY = 1; // Decays the above chance every frame, eventually reaching 0

/* Image Paths */
String CODE_TEXT_FILE_PATH = "../code_falling.js";
String MARKETING_IMAGE_PATH = "../6-sheet-blank-transparent-2.png";
String MARKETING_IMAGE_FADED_PATH = "../6-sheet-blank-transparent-2-faded.png";
String FIND_YOURSELF_IMAGE_PATH = "../find_yourself_mask.png";

boolean RENDER_FADED_MARKETING_IMAGE = true;

/* Code Block Variable */
boolean RENDER_CODE_BLOCK = true;
int FONT_SIZE; // Set by the function findAppropriateTextSize(..)
int FONT_LINE_PADDING = 6; // Spacing between the lines
int CODE_PADDING = -1; // Padding around the code block. Automically generated if -1
String[] code;

/* Mask Variables - will act as barriers for the falling pixels */
boolean RENDER_MASK = false; // For debug
boolean USE_FIND_YOURSELF_MASK = false;

/* Render */
boolean SAVE_FRAMES = false; // Save to "frames" folder


PGraphics sand;
PGraphics mask;
PImage faded;

color libertyYellow = color(255, 208, 0);

/* Keep track of highlighting the code lines */
int mainLineHightlightIndex = 3;
int mainLineHighlightCount = 0;
int loopHighlightIndex = 1;

// These will be set by the size of the canvas, change these values on Line 19
int CANVAS_WIDTH;
int CANVAS_HEIGHT;

void setup() {
  
  /*
    Window Size
  */
  
  //size(3542, 5316); // full Size
  //size(1772, 2658); // 1/2 Size
  //size(886, 1328); // 1/4 Size
  size(708, 1064); // 1/5 Size
  //size(442, 750); // 1/8 Size
  
  /* --------------------------------*/
  
  CANVAS_WIDTH = width;
  CANVAS_HEIGHT = height;
  
  /* Load Code String Lines and Set FONT_SIZE */
  code = loadStrings(CODE_TEXT_FILE_PATH);
  if (CODE_PADDING == -1) {
    CODE_PADDING = (int)((CANVAS_WIDTH * 0.25) / 2);
  }
  FONT_SIZE = findAppropriateTextSize(CANVAS_WIDTH - (CODE_PADDING * 2), code);
  
  // Load Faded Marketing Image
  faded = loadImage(MARKETING_IMAGE_FADED_PATH);
  faded.resize(CANVAS_WIDTH, 0);
  
  // Load Marketing Image
  PImage marketingImage = loadImage(MARKETING_IMAGE_PATH);
  marketingImage.resize(CANVAS_WIDTH, 0);
  
  // Load Find Yourself Image Mask
  PImage findYourselfImage = loadImage(FIND_YOURSELF_IMAGE_PATH);
  findYourselfImage.resize(CANVAS_WIDTH - 100, 0);
  
  sand = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT);
  mask = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT);
  
  // Load Pixels from marketing image into a Graphics obj, pixel by pixel.
  marketingImage.loadPixels();
  sand.beginDraw();
  for (int x = 0; x < marketingImage.width; x++) {
    for (int y = 0; y < marketingImage.height; y++ ) {
      int loc = x + y * marketingImage.width;
      color pc = marketingImage.pixels[loc];
      if (alpha(pc) != 1.0) {
        sand.set(x, y, pc);
      }
    }
  }
  sand.endDraw();
  sand.loadPixels();
  
  mask.beginDraw();
  if (USE_FIND_YOURSELF_MASK) {
    int USE_FIND_YOURSELF_Y_OFFSET = CANVAS_HEIGHT - (int)(findYourselfImage.height * 2);
    for (int x = 0; x < findYourselfImage.width; x++) {
      for (int y = 0; y < findYourselfImage.height; y++ ) {
        int loc = x + y * findYourselfImage.width;
        
        color pc = findYourselfImage.pixels[loc];
        if ((y + USE_FIND_YOURSELF_Y_OFFSET) < CANVAS_HEIGHT && alpha(pc) != 1.0) {
          mask.set(x + 50, y + USE_FIND_YOURSELF_Y_OFFSET, pc);
        }
      }
    }
    
  }
  mask.endDraw();
  mask.loadPixels();
  
  frameRate(FRAME_RATE);
  
  frameCount = 1;
}


void draw() {
  background(libertyYellow);
  //background(0, 0, 0);
  
  if (RENDER_FADED_MARKETING_IMAGE) {
    image(faded, 0, 0);
  }
  
  image(sand, 0, 0);
  
  if (RENDER_MASK) {
    image(mask, 0, 0);
  }
  
  if (RENDER_CODE_BLOCK) {
    updateAndDrawCodeBlock();
  }
  
  if (frameCount > START_DELAY) {
    for (int i = 0; i < SIMULATIONS_PER_FRAME; i++) {
      simulationUpdate();
    }
  }
  
  if (SAVE_FRAMES) {
    saveFrame("../frames/frame-######.png");
  }
  
  if (frameCount > FRAME_RATE * RUNTIME_SECONDS) {
    background(255, 0, 0);
    noLoop();
  }
}


void updateAndDrawCodeBlock() {
  textSize(FONT_SIZE);
  textAlign(LEFT, TOP);
  int FONT_Y = CANVAS_HEIGHT - (((code.length + 1) * FONT_SIZE) + ((code.length + 1) * FONT_LINE_PADDING));
  for (int i = 0; i < code.length; i++) {
    if (i == 0 && frameCount <= START_DELAY) {
      fill(255, 0, 0);
    } else if ((i == mainLineHightlightIndex || i == loopHighlightIndex) && frameCount > START_DELAY) {
      fill(255, 0, 0);
    } else {
      fill(255, 255, 255);
    }
    text(code[i], CODE_PADDING, FONT_Y + (i * FONT_SIZE) + (i * FONT_LINE_PADDING));
  }
  if (frameCount > START_DELAY) {
    if (frameCount % 2 == 0) {
      mainLineHightlightIndex = mainLineHightlightIndex > (code.length - 1) ? 3 : mainLineHightlightIndex + 1;
      if (mainLineHightlightIndex == 3) {
        mainLineHighlightCount += 1;
      }
      if (mainLineHighlightCount == 5) {
        loopHighlightIndex = 1;
      } else if (mainLineHighlightCount == 6) {
        mainLineHighlightCount = 0;
      } else {
        loopHighlightIndex = 2;
      }
    }
  }
}


void simulationUpdate() {
  // Loop over the canvas from top to bottom, left to right
  for (int y = CANVAS_HEIGHT - 1; y >= 0; y--) {
    for (int x = CANVAS_WIDTH - 1; x >= 0; x--) {
      int currentLoc = x + y * CANVAS_WIDTH;
      
      // Don't process a pixel if it's empty
      if (sand.pixels[currentLoc] == 0) continue;
      
      // Don't touch the pixels that are at the bottom
      if (y < CANVAS_HEIGHT - 1) {
        boolean shouldIMove = (int)random(0, 100) > CHANCE_TO_NOT_MOVE;
        
        if (shouldIMove) {
          try {
            int downLoc = x + (y + 1) * CANVAS_WIDTH;
            int moveSidewaysProbability = (int)random(0, 100);
            
            if (moveSidewaysProbability > CHANCE_TO_MOVE_HORIZONTAL && sand.pixels[downLoc] == 0 && mask.pixels[downLoc] == 0) {
              int loc = downLoc;
              
              int downDownLoc = x + (y + 2) * CANVAS_WIDTH;
              boolean shouldMoveDoubleDown = (int)random(0, 100) <= CHANCE_TO_MOVE_DOUBLE_DOWN;
              if (shouldMoveDoubleDown && (y + 2) < CANVAS_HEIGHT && sand.pixels[downDownLoc] == 0 && mask.pixels[downDownLoc] == 0) {
                loc = downDownLoc;
              }
              
              color currentColor = sand.pixels[currentLoc];
              if (alpha(currentColor) != 0) {
                currentColor = color(red(currentColor), green(currentColor), blue(currentColor));
              }
              
              sand.pixels[loc] = currentColor;
              sand.pixels[currentLoc] = 0;
              
            } else {
              
              int downLeftLoc = (x - 1) + (y + 1) * CANVAS_WIDTH;
              int downRightLoc = (x + 1) + (y + 1) * CANVAS_WIDTH;
              
              int direction = (int)random(0, 100);
              
              boolean canMoveDownLeft = (x > 0) && sand.pixels[downLeftLoc] == 0  && mask.pixels[downLeftLoc] == 0;
              boolean canMoveDownRight = (x < CANVAS_WIDTH - 1) && sand.pixels[downRightLoc] == 0  && mask.pixels[downRightLoc] == 0;
              
              if (direction < CHANCE_TO_MOVE_LEFT && canMoveDownLeft) {
                  sand.pixels[downLeftLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              } 
              else if (direction >= CHANCE_TO_MOVE_LEFT && canMoveDownRight) {
                  sand.pixels[downRightLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              }
              
              int downLeftLeftLoc = (x - 2) + (y + 1) * CANVAS_WIDTH;
              int downRightRightLoc = (x + 2) + (y + 1) * CANVAS_WIDTH;
              
              boolean canMoveDownLeftLeft = (x > 1) && sand.pixels[downLeftLeftLoc] == 0  && mask.pixels[downLeftLeftLoc] == 0;
              boolean canMoveDownRightRight = (x < CANVAS_WIDTH - 2) && sand.pixels[downRightRightLoc] == 0  && mask.pixels[downRightRightLoc] == 0;
              
              if (direction < CHANCE_TO_MOVE_LEFT && canMoveDownLeftLeft) {
                  sand.pixels[downLeftLeftLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              } 
              else if (direction >= CHANCE_TO_MOVE_LEFT && canMoveDownRightRight) {
                  sand.pixels[downRightRightLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              }
              
              int leftLoc = (x - 1) + y * CANVAS_WIDTH;
              int rightLoc = (x + 1) + y * CANVAS_WIDTH;
              
              boolean canMoveLeft = (x > 0) && sand.pixels[leftLoc] == 0  && mask.pixels[leftLoc] == 0;
              boolean canMoveRight = (x < CANVAS_WIDTH - 1) && sand.pixels[rightLoc] == 0  && mask.pixels[rightLoc] == 0;
              
              if (direction < CHANCE_TO_MOVE_LEFT && canMoveLeft) {
                  sand.pixels[leftLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              } 
              else if (direction >= CHANCE_TO_MOVE_LEFT && canMoveRight) {
                  sand.pixels[rightLoc] = sand.pixels[currentLoc];
                  sand.pixels[currentLoc] = 0;
                  continue;
              }
              
            }
          } catch (Exception e) {
            System.out.println("canvasWidth: " + CANVAS_WIDTH);
            System.out.println("canvasHeight: " + CANVAS_HEIGHT);
            System.out.println("x: " + x);
            System.out.println("y: " + y);
            e.printStackTrace();
            throw e;
          }
        }
      }
    }
  }
  
  CHANCE_TO_NOT_MOVE = CHANCE_TO_NOT_MOVE - DECAY < 0 ? 0 : CHANCE_TO_NOT_MOVE - DECAY;
  sand.updatePixels();
}


int findAppropriateTextSize(int containerWidth, String[] testStrings) {
  FONT_SIZE = 256;
  boolean fits = false;
  int fontSize = FONT_SIZE;
  do {
    textSize(fontSize);
    boolean fontSizePass = true;
    for (int i = 0; i < testStrings.length; i++) {
      //System.out.println(textWidth(testStrings[i]) + " > " + containerWidth);
      if (textWidth(testStrings[i]) > containerWidth) {
        fontSizePass = false;
      }
    }
    if (fontSize < 7) { 
      fits = true;
    } else if (!fontSizePass) {
      fontSize -= 1;
    } else {
      fits = true;
    }
  } while(!fits);
  return fontSize;
}
