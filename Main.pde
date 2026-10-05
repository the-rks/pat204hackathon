Game game;


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
