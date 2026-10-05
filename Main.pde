Game game;
// essentially, this is a game where the player (a cowboy) has to ward off
// zombies, apocalpyse style
// zombies spawn at random from four locations and move towards the player
// who can shoot them with bullets by clicking the mouse and move with WASD
// they have 3 lives and if they lose all of them, they can press R to restart

void setup() {
  size(800, 800);
  game = new Game();
}


void draw() {
  game.update();
  game.display();
}


void keyPressed() {
  
  //restart
  if (key == 'r' || key == 'R') {
    game.newGame();
  }
  
  //movement
  if (key == 'w' || key == 'W' || keyCode == UP) {
    game.player.movingUp = true;
  }
  
  if (key == 's' || key == 'S' || keyCode == DOWN) {
    game.player.movingDown = true;
  }
  
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    game.player.movingLeft = true;
  }
  
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    game.player.movingRight = true;
  }
  
  if (key == ' '){//testing out using space as shoot too
    game.fireBullet();
  }
   
}

void keyReleased() {
  
  if (key == 'w' || key == 'W' || keyCode == UP) {
    game.player.movingUp = false;
  }
  
  if (key == 's' || key == 'S' || keyCode == DOWN) {
    game.player.movingDown = false;
  }
  
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    game.player.movingLeft = false;
  }
  
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    game.player.movingRight = false;
  }
}

//shooting
void mousePressed() {
  
  if (mouseButton == LEFT) {
    game.fireBullet();
  }
}
