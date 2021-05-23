int asteroidNum = 11;

float [] asteroidX = new float [asteroidNum]; 
float [] asteroidY = new float [asteroidNum]; 
float [] asteroidVelocityX = new float [asteroidNum]; 
float [] asteroidVelocityY = new float [asteroidNum];

void setup() {
  size(400, 400);
  initializeSpaceShip(); //one spaceship

  for (int i=0; i<asteroidNum; i=i+1) { //making certain num of asteroid
    initializeAsteroid(i);
  }
}

void draw() {
  background(0);
  moveSpaceShip();
  controlSpaceShip();
  drawSpaceShip(spaceShipX, spaceShipY, spaceShipTheta);
  for (int i=0; i<asteroidNum; i=i+1) {
    drawAsteroid(i);
    moveAsteroid(i);
  }
}
void drawAsteroid(int w) {
  fill(128);
  ellipse(asteroidX[w], asteroidY[w], 30, 30);
}

void initializeAsteroid(int i) {
  asteroidX[i] = random(-100,500); 
  asteroidY[i] = random(-100,500); 
  asteroidVelocityX[i] =  random(-5, 5);
  asteroidVelocityY[i] = random(-5, 5);
}

void moveAsteroid(int b) { 
  asteroidX[b] = asteroidX[b] + asteroidVelocityX[b];
  asteroidY[b] = asteroidY[b] + asteroidVelocityY[b];
}



float spaceShipX; 
float spaceShipY; 
float spaceShipTheta;
float spaceShipVelocity;

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
  if (keyPressed && keyCode == LEFT) { 
    spaceShipTheta -=0.05;
  }
}
void moveSpaceShip() { // moves the spaceship forward in a straight line - DON'T MODIFY
  spaceShipX = spaceShipX + spaceShipVelocity*cos(spaceShipTheta); 
  spaceShipY = spaceShipY + spaceShipVelocity*sin(spaceShipTheta); 
  spaceShipVelocity = spaceShipVelocity* 0.96; // makes the ship slow down on its own
}
