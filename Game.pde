class Game {
  
  //constructor
  Game() {
    
    player = new Player(color(100, 100, 100));
    
    for (int i = 0; i < zombieArray.length; ++i) {
      zombieArray[i] = new Zombie(30);//maybe make the number of zombies variable
    }
    
    for (int i = 0; i < bulletArray.length; ++i) {
      bulletArray[i] = new Bullet(10);
    }
    
    // zombie gates
    // 0 = top
    // 1 = bottom
    // 2 = left
    // 3 = right
    
    gateX[0] = width / 2;
    gateY[0] = 0;
    
    gateX[1] = width / 2;
    gateY[1] = height;
    
    gateX[2] = 0;
    gateY[2] = height / 2;
    
    gateX[3] = width;
    gateY[3] = height / 2;
    
    startWave();
  }
  
  
  
  Player player;
  
  Zombie[] zombieArray = new Zombie[20];
  Bullet[] bulletArray = new Bullet[30];
  
  int[] gateX = new int[4];
  int[] gateY = new int[4];
  
  int lives = 3; // num of lives player has to start with
  int score = 0; // score
  
  int wave = 1; // indicates which wave we are one
  int lastWave = 5; // survive this many waves to win
  
  int waveTimer; //frames left in this wave, 60 frames = 1 sec
  int numZombies;
  float zombieSpeed;
  
  int shootTimer = 0; // frames until player can shoot again, to avoid total spam
  
  int blinkTimer = 0;
  boolean blinking = false;
  
  boolean gameOver = false;
  boolean won = false;

  //methods
  //set wave or reset after player dies
  void startWave() {
    
    numZombies = 5 + wave * 3; // more zombies each wave
    zombieSpeed = 1 + wave * 0.4; // faster zombies each wave
    waveTimer = 20 * 60; // 20 seconds
    
    //reset player
    player.reset();
    player.visible = true;
    
    blinking = false;
    blinkTimer = 0;
    
    // clear out zombies from last wave
    for (int i = 0; i < zombieArray.length; ++i) {
      zombieArray[i].alive = false;
    }
    
    // clear out bullets from last wave
    for (int i = 0; i < bulletArray.length; ++i) {
      bulletArray[i].active = false;
    }
    
    //spawn zombies
    int spawnGap = 900 / numZombies;
    
    for (int i = 0; i < numZombies; ++i) {
      
      //random gate
      int side = int(random(4));
      
      //spawn somewhere in the middle 25% of the selected side
      float spawnX;
      float spawnY;
      
      if (side == 0) {
        //top
        spawnX = random(width * 0.375, width * 0.625);
        spawnY = -30;
      }
      else if (side == 1) {
        //bottom
        spawnX = random(width * 0.375, width * 0.625);
        spawnY = height + 30;
      }
      else if (side == 2) {
        //left
        spawnX = -30;
        spawnY = random(height * 0.375, height * 0.625);
      }
      else {
        //right
        spawnX = width + 30;
        spawnY = random(height * 0.375, height * 0.625);
      }
      
      zombieArray[i].spawn(
        spawnX,
        spawnY,
        zombieSpeed,
        i * spawnGap
      );
    }
  }
  
  
  void newGame() {
    
    lives = 3;
    score = 0;
    wave = 1;
    
    gameOver = false;
    won = false;
    blinking = false;
    
    player.visible = true;
    
    startWave();
  }
  
  
  void fireBullet() {
    
    if (shootTimer > 0) {
      return;
    }
    
    boolean fired = false;
    
    for (int i = 0; i < bulletArray.length; ++i) {
      
      if (!bulletArray[i].active && !fired) {
        
        bulletArray[i].fire(
          player.posX,
          player.posY,
          mouseX,
          mouseY
        );
        
        fired = true;
      }
    }
    
    // small delay between shots
    shootTimer = 8;
  }
  
  
  // =========================
  // UPDATE
  // =========================
  
  void update() {
    
    // don't update if game has ended
    if (gameOver || won) {
      return;
    }
    
    if (shootTimer > 0) {
      --shootTimer;
    }
    
    if (!blinking) {
      player.move();
    }
    
    
    for (int i = 0; i < bulletArray.length; ++i) {
      
      bulletArray[i].move();
    }
    
    
    for (int i = 0; i < zombieArray.length; ++i) {
      
      Zombie z = zombieArray[i];
      
      if (z.alive) {
        
        z.move(player.posX, player.posY);
        
        
        // zombie touches player
        if (!blinking && z.touching(player)) {
          playerHit();
        }
        
        
        //check bullets
        for (int j = 0; j < bulletArray.length; ++j) {
          
          if (bulletArray[j].hits(z)) {
            
            z.alive = false;
            bulletArray[j].active = false;
            
            score++;
            
            break; // stop checking once a bullet hits a zombie
          }
        }
      }
    }
    
    
    // wave timer

    if (!blinking) {
      --waveTimer;
    }
    
    if (waveTimer <= 0 && !blinking) {
      
      if (wave >= lastWave) {
        won = true;
      }
      else {
        ++wave;
        startWave();
      }
    }
    
    
    // player blinking
    
    if (blinking) {
      
      --blinkTimer;
      
      // Make player blink
      // flips cowboy on and off every 5 frames to mimic a blinking effect
      player.visible = (frameCount % 10 < 5);
      
      if (blinkTimer <= 0) {
        
        blinking = false;
        player.visible = true;
        
        if (lives > 0) {
          startWave();
        }
      }
    }
  }
  
  
//player hit
  
  void playerHit() {
    
    if (blinking) {
      return;
    }
    
    --lives;
    
    // dead
    if (lives <= 0) {
      
      lives = 0;
      gameOver = true;
      player.visible = false;
      
      return;
    }
    
    blinking = true;
    blinkTimer = 90; // about 1.5 seconds
    
    player.visible = false;
  }
  
  
  
  void display() {
    
    // Background
    background(30, 100, 30);
    
    
    // zombies    
    for (int i = 0; i < zombieArray.length; ++i) {
      zombieArray[i].display();
    }
    
    //bullets
    
    for (int i = 0; i < bulletArray.length; ++i) {
      bulletArray[i].display();
    }
    

    //player    
    player.display();
    
    
    //ui stuff
    
    fill(255);
    textSize(20);
    
    text("Lives: " + lives, 20, 30);
    text("Score: " + score, 20, 55);
    text("Wave: " + wave, 20, 80);
    
    int secondsLeft = max(0, waveTimer / 60);
    text("Time: " + secondsLeft, 20, 105);
    
    
    if (gameOver) {
      
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(50);
      text("GAME OVER", width / 2, height / 2 - 30);
      
      textSize(20);
      text("Press R to restart", width / 2, height / 2 + 30);
      
      textAlign(LEFT, BASELINE);
    }
    
    
    
    if (won) {
      
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(50);
      text("YOU WIN!", width / 2, height / 2 - 30);
      
      textSize(20);
      text("Final score: " + score, width / 2, height / 2 + 30);
      text("Press R to play again", width / 2, height / 2 + 60);
      
      textAlign(LEFT, BASELINE);
    }
  }
}
