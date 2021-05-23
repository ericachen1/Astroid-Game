int currentLaserIndex = -1;
int laserNum = 10;

float [] laserX = new float [laserNum]; 
float [] laserY = new float [laserNum]; 
float [] laserVelocityX = new float [laserNum]; 
float [] laserVelocityY = new float [laserNum];
float laserTheta;

void initializeLaser(int a) {
  //laserTheta = -PI/2; 
  // if (keyPressed && keyCode == DOWN) {
  laserX[a] = 0;
  laserY[a] = 0;
  laserVelocityX[a] =  0; 
  laserVelocityY[a] =  0;
}

void drawLaser(int w) {
  fill(255, 0, 0); 
  ellipse(laserX[w], laserY[w], 20, 20);
}

void moveLaser(int i) { 
  initializeLaser(i);
  laserX[i] = laserX[i] + laserVelocityX[i];
  laserY[i] = laserY[i] + laserVelocityY[i];
}

void fireLaser(int i) {


  if (currentLaserIndex < 11) {
    currentLaserIndex = currentLaserIndex +1;
  } else {
    currentLaserIndex=0;
  }
}


void setup() {
  size(400, 400); 
  initializeSpaceShip(); //one spaceship
  for (int i=0; i<asteroidNum; i=i+1) { //making 10 asteroid
    initializeAsteroid(i); 
    initializeLaser(i);
  }
}

void draw() {
  background(0); 
  moveSpaceShip(); 
  controlSpaceShip(); 
  text("Ammo:" + currentLaserIndex, 370, 30);
  text("Lives:" + lives, 30, 30); 
  drawSpaceShip(spaceShipX, spaceShipY, spaceShipTheta); 
  for (int i=0; i<asteroidNum; i=i+1) {
    drawAsteroid(i); 
    moveAsteroid(i); 
    shipCollision(i);
    moveLaser(i);
    drawLaser(i);
  }
}

void shipCollision(int a) {
  if (dist(spaceShipX, spaceShipY, asteroidX[a], asteroidY[a]) < 20) {
    asteroidX[a] = random(-100, 0); 
    asteroidY[a] = random(-100, 0); 
    spaceShipX = 200; 
    spaceShipY = 200; 
    spaceShipTheta = -PI/2; //pointing up initially
    spaceShipVelocity = 0.0; //starts at rest
    initializeAsteroid(a); 
    lives = lives - 1;
  }
}


void drawAsteroid(int w) {
  fill(128); 
  ellipse(asteroidX[w], asteroidY[w], 30, 30);
}

void initializeAsteroid(int i) {
  if (i < 4) {
    asteroidX[i] = random(-100, 0); 
    asteroidY[i] = random(-100, 0); 
    asteroidVelocityX[i] = random(-3, 3); 
    asteroidVelocityY[i] = random(-3, 3);
  }
  if (i >= 4 && i < 7) {
    asteroidX[i] = random(400, 500); 
    asteroidY[i] = random(-100, 00); 
    asteroidVelocityX[i] = random(-3, 3); 
    asteroidVelocityY[i] = random(-3, 3);
  }
  if (i >=7 && i <= 11) {
    asteroidX[i] = random(-100, 0); 
    asteroidY[i] = random(400, 500); 
    asteroidVelocityX[i] = random(-3, 3); 
    asteroidVelocityY[i] = random(-3, 3);
  }
}

void moveAsteroid(int i) { 
  asteroidX[i] = asteroidX[i] + asteroidVelocityX[i]; 
  asteroidY[i] = asteroidY[i] + asteroidVelocityY[i]; 
  if (asteroidX[i] >500 ||  asteroidX[i] <-100 || asteroidY[i] >500 ||  asteroidY[i] <-100 ) {
    initializeAsteroid(i);
  }
}

int asteroidNum = 11; 
int lives=3; 

float [] asteroidX = new float [asteroidNum]; 
float [] asteroidY = new float [asteroidNum]; 
float [] asteroidVelocityX = new float [asteroidNum]; 
float [] asteroidVelocityY = new float [asteroidNum]; 

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
