int currentLaserIndex = 0;
int laserNum = 10;

float [] laserX = new float [laserNum]; 
float [] laserY = new float [laserNum]; 
float [] laserVelocityX = new float [laserNum]; 
float [] laserVelocityY = new float [laserNum];
float laserTheta;

void initializeLaser(int a) {
  laserX[a] = -100;
  laserY[a] = -100;
  laserVelocityX[a] =  0; 
  laserVelocityY[a] =  0;
}

void drawLaser(int w) {
  fill(255, 0, 0); 
  ellipse(laserX[w], laserY[w], 10, 10);
}

void moveLaser(int i) { 
  laserX[i] = laserX[i] + laserVelocityX[i];
  laserY[i] = laserY[i] + laserVelocityY[i];
}

void fireLaser(int a) {
    laserX[currentLaserIndex] = spaceShipX;
    laserY[currentLaserIndex] = spaceShipY;
    //  moveLaser(i);
    laserVelocityX[currentLaserIndex]=3*cos(spaceShipTheta); 
    laserVelocityY[currentLaserIndex]=3*sin(spaceShipTheta);
  
}

void keyPressed() {
  if (key == ' ') {
    fireLaser(currentLaserIndex);
    currentLaserIndex= currentLaserIndex+1;
  }
  if(currentLaserIndex>10-1){
   currentLaserIndex=0; 
  }
}

void setup() {
  size(400, 400); 
  //  frameRate(60);
  initializeSpaceShip(); //one spaceship
  for (int i=0; i<asteroidNum; i=i+1) { //making 11 asteroid
    initializeAsteroid(i);
  }
  for (int i=0; i<laserNum; i=i+1) { //making 11 lasers
    initializeLaser(i);
  }
}

void draw() {
  background(0); 
  moveSpaceShip(); 
  controlSpaceShip(); 
  text("Ammo:" + currentLaserIndex, 330, 30);
  text("Lives:" + lives, 30, 30); 
  //  text("Survival (sec):" + tick, 150, 30);
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

int asteroidNum = 10; 
int lives=3; 
int tick=0;

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
  // tick= (tick+1);
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
