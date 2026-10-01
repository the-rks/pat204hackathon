class Bullet {
  // constructor
  Bullet (float inputSpeed) {
    speed = inputSpeed;
  }

  // attributes
  float posX;
  float posY;
  float velX;
  float velY;
  float speed;
  int diameter = 8;
  boolean active = false; // false = not flying, free to be reused

  // methods
  void fire (float startX, float startY, float targetX, float targetY) {
    posX = startX;
    posY = startY;

    // point the bullet at the target
    // atan2 calcs angle from a certain point to the origin
    // helps us orient via position of cursor, which is how player will aim
    float angle = atan2(targetY - startY, targetX - startX);
    velX = cos(angle) * speed;
    velY = sin(angle) * speed;

    active = true;
  }

  void move () {
    if (active) {
      posX += velX;
      posY += velY;

      // gone off the screen
      if (posX < 0 || posX > width || posY < 0 || posY > height) {
        active = false;
      }
    }
  }

  boolean hits (Zombie z) {
    if (active && z.isOnScreen()) {
      // dist btwn diameter of bullet and diameter of zombie according to positions of bullet and zombie
      return dist(posX, posY, z.posX, z.posY) < (z.diameter + diameter) / 2;
    }
    return false;
  }

  void display () {
    if (active) {
      noStroke();
      fill(255, 230, 80);
      ellipse(posX, posY, diameter, diameter);
    }
  }
}
