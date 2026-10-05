class Zombie {
  
  // constructor
  Zombie(int inputDiameter) {
    diameter = inputDiameter;
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
        --delay;
      }
      else {
        
        float angle = atan2(
          targetY - ypos,
          targetX - xpos
        );
        
        xpos += cos(angle) * speed;
        ypos += sin(angle) * speed;
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
    
    return distance < (diameter / 2 + player.size / 2);
  }
  
  void display() {
    
    if (alive) {
      fill(255, 0, 0);
      ellipse(xpos, ypos, diameter, diameter);
    }
  }
}
