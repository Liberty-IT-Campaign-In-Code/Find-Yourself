// In this attempt I wanted to have the background image appear as the ellipse moved across the screen //<>//

PImage logo, libertyIT;
 
// Initial coordinates and speed of logo 
float x = 200; 
float y = 300; 
float xspeed = 5; 
float yspeed = 5;
 
void setup() { 
  size(800, 800);
  
  logo = loadImage("logo.jpg");
  logo.resize(250, 250);
  
  libertyIT = loadImage("endframecrop2.jpg");
  libertyIT.resize(800, 800);
}
 
void draw() { 
  background(libertyIT);

  x = x + xspeed; 
  y = y + yspeed;
 
   if ((x > width - 40) || (x < 0)) 
  { 
    xspeed = xspeed * -1;
  }
 
  if ((y > height - 40) || (y < 0)) 
  { 
    yspeed = yspeed * -1;
  }
 
  stroke(0); 
  fill(225);
  // Draws the image at location x, y at a width of 50 pixels and a height of 50 pixels)
  image(logo, x, y, 50, 50);
}
