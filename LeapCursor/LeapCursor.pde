import de.voidplus.leapmotion.*;

/**
 * (c) 2017 Michael Kipp
 * Augsburg University of Applied Sciences
 */

LeapMotion leap;
ArrayList<TimeoutButton> buttons = new ArrayList<TimeoutButton>();
ArrayList<PVector> cursors = new ArrayList<PVector>();

void setup() {
  size(1000, 600);

  leap = new LeapMotion(this);
  buttons.add(new TimeoutButton(200, 100, 150, 200, 1));
  buttons.add(new TimeoutButton(400, 400, 200, 100, 2));
  buttons.add(new TimeoutButton(700, 200, 100, 100, .5));
}

void draw() {
  background(0);
  cursors.clear();

  // handle buttons
  for (TimeoutButton b : buttons) {
    b.render();
  }

  strokeWeight(3);
  noFill();
  for (Hand hand : leap.getHands()) {
    Finger index = hand.getIndexFinger();
    PVector pos = index.getPosition();
    if (hand.isRight()) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 255, 0);
    }
    ellipse(pos.x, pos.y, 30, 30);
    cursors.add(pos);
  }

  for (TimeoutButton b : buttons) {
    b.update(cursors);
  }
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("Index Finger Cursors (right = red, left = green)", width/2, 50);
}