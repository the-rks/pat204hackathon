class Zombie {
  
  // constructor
  Zombie(int diameter) {
    diameter = inputDiameter
  }
  
  // attributes
  int diameter;
  float xpos;
  float ypos;
  float speed;
  int delay = 0; // frames to wait before appearing
  boolean alive = false;
  
  void spawn (float startX, float startY, float inputSpeed, int inputDelay) {
    xpos = startX;
    ypos = startY;
    speed = inputSpeed;
    delay = inputDelay;
    alive = true;    
  }
  
  //move towards player
  void move(float targetX, float targetY) {
    
    if (alive) {
      
      if (delay > 0) {
        --delay; // decrement delay if there is still delay
      }
      else {
    
        //angle from the zombie to the player
        float angle = atan2(
          player.posY - ypos,
          player.posX - xpos
        );
        
        xpos += cos(angle) * speed;
        ypos += sin(angle) * speed;
        
        // boundary checks so we dont go off screen
        if (xpos < diameter / 2) {
            xpos = diameter / 2;
        }
        else if (xpos > width - diameter / 2) {
            xpos = width - diameter / 2;
        }
    
        if (ypos < diameter / 2) {
            ypos = diameter / 2;
        }
        else if (ypos > height - diameter / 2) {
            ypos = height - diameter / 2;
        }
      }
    }
  }
  
  boolean touching(Player player) {
    
    if (!alive) {
      return false;
    }
    
    float distance = dist(
      xpos, ypos,
      player.posX, player.posY
    );
    
    return distance < (size / 2 + player.size / 2);
  }
  
  void display() {
    
    if (alive) {
      fill(255, 0, 0);
      ellipse(xpos, ypos, size, size);
    }
  }
}
