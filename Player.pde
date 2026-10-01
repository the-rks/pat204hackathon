class Player {
  // constructor
  Player (color inputColor) {
    playerColor = inputColor;
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

    // stay on the screen
    posX = 
    posY = 
  }

  void display () {
    if (visible) {
      noStroke();
      fill(playerColor);
      rect(posX, posY, size, size);

      fill(255);
    }
  }

}
