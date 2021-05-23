float spaceShipX; 
float spaceShipY; 
float spaceShipTheta;
float spaceShipVelocity;

void setup() {
  size(400, 400);
  initializeSpaceShip();
}

void draw() {
  background(0);
  moveSpaceShip();
  controlSpaceShip();
  drawSpaceShip(spaceShipX, spaceShipY, spaceShipTheta);
}

void initializeSpaceShip() { 
  spaceShipX = 200; 
  spaceShipY = 200; 
  spaceShipTheta = -PI/2; //pointing up initially
  spaceShipVelocity = 0.0; //starts at rest
}

void drawSpaceShip(float x, float y, float theta) { // draws the ship - DON'T MODIFY
  fill(255);  
  translate(x, y); 
  rotate(theta); 
  int frontX = 15; 
  int sideY = 10; 
  beginShape();
  vertex(frontX, 0);
  vertex(-frontX, sideY);
  vertex(-frontX/2, 0);
  vertex(-frontX, -sideY);
  endShape(CLOSE);
  resetMatrix();
}

void controlSpaceShip() { // responds to user input
  if (keyPressed && keyCode == UP) {
    spaceShipVelocity = 1.0;
  }
  if (keyPressed && keyCode == RIGHT) {
    spaceShipTheta += 0.05;
  }
  if(keyPressed && keyCode == LEFT){ 
  spaceShipTheta -=0.05;
  }
}

void moveSpaceShip() { // moves the spaceship forward in a straight line - DON'T MODIFY
  spaceShipX = spaceShipX + spaceShipVelocity*cos(spaceShipTheta); 
  spaceShipY = spaceShipY + spaceShipVelocity*sin(spaceShipTheta); 
  spaceShipVelocity = spaceShipVelocity* 0.96; // makes the ship slow down on its own
}
