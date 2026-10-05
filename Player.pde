class Player {
  // constructor
  Player (color inputColor) {
    playerColor = inputColor;
    reset();
  }

  // attributes
  color playerColor;
  float posX;
  float posY;
  float speed = 4;
  int size = 30;
  boolean visible = true;

  boolean movingUp = false;
  boolean movingDown = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  
  // methods
  void reset () {
    posX = width / 2;
    posY = height / 2;
    movingUp = false;
    movingDown = false;
    movingLeft = false;
    movingRight = false;
  }

  void move () {
    
    if (movingUp) {
      posY -= speed;
    }
    
    if (movingDown) {
      posY += speed;
    }
    
    if (movingLeft) {
      posX -= speed;
    }
    
    if (movingRight) {
      posX += speed;
    }

    // boundary checks so we dont go off screen
    if (posX < size / 2) {
        posX = size / 2;
    }
    else if (posX > width - size / 2) {
        posX = width - size / 2;
    }

    if (posY < size / 2) {
        posY = size / 2;
    }
    else if (posY > height - size / 2) {
        posY = height - size / 2;
    }
  }

  void display () {
    if (visible) {
      //noStroke();
      //fill(playerColor);
      
      //rectMode(CENTER);
      //rect(posX, posY, size, size);
      //rectMode(CORNER);
      
      rectMode(CENTER);
      
      // shadow
      noStroke();
      fill(0, 60);
      ellipse(posX, posY + size / 2, size, size / 3);
      
      // gun, pointing at the mouse
      float angle = atan2(mouseY - posY, mouseX - posX);
      stroke(40);
      strokeWeight(5);
      line(posX, posY, posX + cos(angle) * 24, posY + sin(angle) * 24);
      
      // body (shirt color is playerColor)
      noStroke();
      fill(playerColor);
      rect(posX, posY + 4, size - 8, size - 8);
      
      // head
      fill(220, 180, 95);
      ellipse(posX, posY - 8, 14, 14);
      
      // hat
      fill(120, 70, 30);
      ellipse(posX, posY - 12, 28, 8); // brim
      rect(posX, posY - 17, 14, 10); // top
      
      rectMode(CORNER);
    }
  }
}
