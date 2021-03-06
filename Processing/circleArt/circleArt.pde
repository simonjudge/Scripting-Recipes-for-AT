String shapeName = "circle";
float redc = 102;
float greenc = 102;
float bluec = 102;

void setup()
{
  size(screen.width, screen.height);
  background(102);
  smooth();
}


void draw() 
{
  // Call the variableEllipse() method and send it the
  // parameters for the current mouse position
  // and the previous mouse position
  variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
}


// The simple method variableEllipse() was created specifically 
// for this program. It calculates the speed of the mouse
// and draws a small ellipse if the mouse is moving slowly
// and draws a large ellipse if the mouse is moving quickly 

void variableEllipse(int x, int y, int px, int py) 
{
  float speed = abs(x-px) + abs(y-py);
  stroke(speed);
  fill(redc, greenc, bluec);
  if (mousePressed == true ) {    
    changeColour();
  }
      drawShape(x, y, speed, speed);

}

void toggleShape(int x, int y, float speedx, float speedy){
if (shapeName == "circle"){
      rect(x, y, speedx, speedy);
      shapeName = "rectangle";
} else {
    ellipse(x, y, speedx, speedy);
    shapeName = "circle";
}
}

void drawShape(int x, int y, float speedx, float speedy){
if (shapeName == "circle"){
      ellipse(x, y, speedx, speedy);
} else {
    rect(x, y, speedx, speedy);
}
}

void changeColour(){
  redc = random(0, 255);
  greenc = random(0, 255);
  bluec = random(0, 255);
}
