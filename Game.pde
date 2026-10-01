class Game {
  // constructor
  Game () {
    player = new Player(color(100, 100, 100)); // whatever color idk
    
    for (int i = 0; i < zombieArray.length; ++i) {
      zombieArray[i] = new Zombie(30); // or whatever amount
    }
    
    for (int i = 0; i < bulletArray.length; ++i) {
      bulletArray[i] = new Bullet(10); // or whatever amount
    }
    
    // zombie gates will be middle of each edge of canvas
    gateX[0] = width / 2;
    gateX[1] = width / 2;
    gateX[2] = 0;
    gateX[3] = width;
    gateY[0] = height / 2;
    gateY[1] = height / 2;
    gateY[2] = 0;
    gateY[3] = height;
    
    // attributes
    Player player;
    Zombie[] zombieArray = new Zombie[20]; // most amount of zombies per wave
    Bullet[] bulletArray = new Bullet[30];
    
    int gateX[] = new int[4];
    int gateY[] = new int[4];
    
    int lives = 3;
    int score = 0;
    int wave = 1;
    int lastWave = 5; // survive this many waves to win
    int waveTimer; // frames left in this wave, 60 frames = 1 sec
    int numZombies;
    float zombieSpeed;
    
    int shootTimer = 0; // frames until player can shoot again, to avoid total spam
    int blinkTimer = 0;
    
    boolean gameOver = false;
    boolean won = false;
    boolean blinking = false;
    
    // methods
    // set wave or reset after player dies
    void startWave () {
      numZombies = 5 + wave * 3; // more zombies each wave
      zombieSpeed = 1 + wave * 0.4; // faster zombies each wave
      waveTimer = 20 * 60; // 20 seconds
      int spawnGap = 900 / numZombies; // frames between zombies spawning
    }
    
    player.reset();
    
    for (int i = 0; i < zombieArray.length; ++i) {
      
      if (i < numZombies) {
        // spawn behavior
        // randomly pick a side
        int side = int(random(4));
        zombieArray[i].spawn(gateX[gate], gateY[gate], zombieSpeed, i * spawnGap);
      }
      else {
        zombieArray[i].alive = false;
      }
    }
    for (int i = 0; i < bulletArray.length; i++) {
      bulletArray[i].active = false;
    }
    
  }

  void newGame () {
    lives = 3;
    score = 0;
    wave = 1;
    gameOver = false;
    won = false;
    blinking = false;
    player.visible = true;
    startWave();
  }
  
  // uses the first bullet that isn't already flying
  void fireBullet () {
    boolean fired = false;

    for (int i = 0; i < bulletArray.length; i++) {
      if (bulletArray[i].active == false && fired == false) {
        bulletArray[i].fire(player.posX, player.posY, mouseX, mouseY);
        fired = true;
      }
    }
  }

  void update () {
  
    if (gameOver == false && won == false) {
      
      if (blinking) {
        // player blinking = reset level
      
        --blinkTimer;
        player.visible = (blinkTimer == 0)
        
      
      }
      
      
      
      
      
      
    }
  
  }






}
