import de.voidplus.leapmotion.*;

float INTERACTION_SPACE_WIDTH = 200; // left-right from user
float INTERACTION_SPACE_DEPTH = 150; // away-and-toward user
float FINGER_DOT = 30;

LeapMotion leap;

void setup() {
  size(1000, 600);
  leap = new LeapMotion(this);
  textAlign(CENTER);
}

void draw() {
  background(100);

  // FPS
  int fps = leap.getFrameRate();
  fill(#00E310);
  text(fps + " fps", 40, 20);

  for (Hand hand : leap.getHands ()) {

    PVector thumbTip = hand.getThumb().getRawPositionOfJointTip();
    PVector indexTip = hand.getIndexFinger().getRawPositionOfJointTip();
    PVector ringTip = hand.getRingFinger().getRawPositionOfJointTip();
    PVector middleTip = hand.getMiddleFinger().
                        getRawPositionOfJointTip();
    PVector pinkyTip = hand.getPinkyFinger().getRawPositionOfJointTip();

    handleFinger(thumbTip, "thb");
    handleFinger(indexTip, "idx");
    handleFinger(middleTip, "mdl");
    handleFinger(ringTip, "rng");
    handleFinger(pinkyTip, "pky");

    hand.draw();
  }
}

void handleFinger(PVector pos, String id) {

  // map finger tip position to 2D surface
  float x = map(pos.x, -INTERACTION_SPACE_WIDTH,
  INTERACTION_SPACE_WIDTH, 0, width);
  float y = map(pos.z, -INTERACTION_SPACE_DEPTH,
  INTERACTION_SPACE_DEPTH, 0, height);

  fill(#00E310);
  noStroke();
  ellipse(x, y, FINGER_DOT, FINGER_DOT);

  // ID
  fill(0);
  text(id, x, y + 5);
}