class Zombie {
  
  // attributes
  int size;
  float xpos;
  float ypos;
  float speed;
  boolean alive;
  
  // constructor
  Zombie(float x, float y, float s) {
    size = 30;
    xpos = x;
    ypos = y;
    speed = s;
    alive = true;
    
    //spawn behavior
    //randomly pick a side
    int side = int(random(4));
    
    //spawn in the middle 25% of that side
    if (side == 0) {
      //top
      xpos = random(width * 0.375, width * 0.625);
      ypos = -size;
      
    } else if (side == 1) {
      //right
      xpos = width + size;
      ypos = random(height * 0.375, height * 0.625);
      
    } else if (side == 2) {
      //bottom
      xpos = random(width * 0.375, width * 0.625);
      ypos = height + size;
      
    } else {
      //left
      xpos = -size;
      ypos = random(height * 0.375, height * 0.625);
    }
  }
  
  //move towards player
  void move(Player player) {
    
    //angle from the zombie to the player
    float angle = atan2(
      player.posY - ypos,
      player.posX - xpos
    );
    
    xpos += cos(angle) * speed;
    ypos += sin(angle) * speed;
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
