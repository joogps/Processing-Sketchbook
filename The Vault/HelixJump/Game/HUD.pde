class HUD {
  int score = 0;
  float scoreWidth = 0;

  boolean fadeIn = false;
  boolean fadeOut = true;
  float transition = 255*1.3; 

  void startHUD() {
    pushMatrix();
    resetMatrix();
    camera();
    hint(DISABLE_DEPTH_TEST);
  }

  void endHUD() {
    hint(ENABLE_DEPTH_TEST);
    popMatrix();
  }

  void score() {
    fill(body.ball.ballColor);

    textSize(30);
    textAlign(LEFT, TOP);

    text(constrain(score, 0, body.target), 10, 5);

    fill(body.bodyColor);
    rect(width-90, 10, 80, 20, 40);

    fill(body.ball.ballColor);
    rect(width-90, 10, scoreWidth, 20, 40);

    scoreWidth = lerp(scoreWidth, map(constrain(score, 0, body.target), 0, body.target, 0, 80), 0.2);
  }

  void transition() {
    fill(255, transition);
    rect(0, 0, width, height);

    if (fadeIn)
      transition = lerp(transition, 255, 0.1);

    if (fadeOut)
      transition = lerp(transition, 0, 0.1);

    if (transition >= 253 && fadeIn) {
      fadeIn = false;
      fadeOut = true;

      if (body.ball.dead) 
        SetGame(body.target);

      if (body.ball.finished)
        SetGame(body.target+1);
    } 

    if (transition <= 2 && fadeOut) {
      fadeIn = false;
      fadeOut = false;

      transition = 0;
    }
  }
}
