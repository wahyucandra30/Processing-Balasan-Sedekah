int[] colorPalette = {#2a2329,#454050, #f0a984, #752438, #a8d9fe, #d0dac0, #af908c, #514b5e, #7eb0ce,
                      #deeafa, #56ad7a, #eab353, #233f71, #546c96, #e9edf3, #d1d5db, #83858b}; 
float eyeWidth = 14, eyeHeight = 15;
int[] blinkIntervals = {60, 60, 90, 120};
int counter = 0;

PVector bgDis = new PVector(0, 0);
PVector fgDis = new PVector(0, 0);
//Pak Budi
float headRot_B = 0, torsoRot_B = 0, handRotLeft_B = 0, handRotRight_B = 0, legRot_B = 0;
//Pak Yanto
float headRot_Y = 0, torsoRot_Y = 0, handRotLeft_Y = 0, handRotRight_Y = 0, legRot_Y = 0;
float[] mouthVerts_Y = {-30, -64, -28, -56, -18, -56, -16, -64};

void setup()
{
  size(1280, 720);
  smooth(8);  
  frameRate(60);
  strokeWeight(3.5);
  hint(ENABLE_STROKE_PURE);
  strokeCap(ROUND);
}
void draw()
{
  counter++;
  background(colorPalette[14]);
  textSize(18);
  fill(color(0));
  text("FPS: " + round(frameRate), 20, 35);
  text("ET : " + nf(frameToSec(counter), 0, 2), 21, 60);

  if(frameToSec(counter) < 30)
  {
    drawScene1();
  }
  filter(ERODE);
}
void drawScene1()
{
  if (frameToSec(counter) < 14)
  {
    bgDis.x++;
    headRot_B = sin((norm(counter, 0, 1)/15f)) * 3;
    torsoRot_B = sin((norm(counter, 0, 1)/15f)) * 3;
    handRotLeft_B = -sin((norm(counter, 0, 1)/15f)) * 30;
    handRotRight_B = sin((norm(counter, 0, 1)/15f)) * 30;
    legRot_B = sin((norm(counter, 0, 1)/15f)) * 10;
    handRotLeft_Y = -15;
    handRotRight_Y = -30;
  } 
  else if (frameToSec(counter) < 15)
  {
    headRot_B = lerp(headRot_B, 0, frameToSec(counter)/100);
    torsoRot_B = lerp(torsoRot_B, 0, frameToSec(counter)/100);
    handRotLeft_B = lerp(handRotLeft_B, 0, frameToSec(counter)/100);
    handRotRight_B = -lerp(handRotLeft_B, 0, frameToSec(counter)/100);
    legRot_B = lerp(legRot_B, 0, frameToSec(counter)/100);
  } 
  else
  {
    headRot_B = sin((norm(counter, 0, 1)/15f)) * 3;
    torsoRot_B = sin((norm(counter, 0, 1)/15f)) * 3;
    handRotLeft_B = sin((norm(counter, 0, 1)/15f)) * 2;
    handRotRight_B = sin((norm(counter, 0, 1)/15f)) * 2;
    legRot_B = sin((norm(counter, 0, 1)/15f)) * 0;
  }
  if(frameToSec(counter) > 15 && frameToSec(counter) < 16.25)
  {
    headRot_Y = lerp(headRot_Y, 10, frameToSec(counter)/400);
  }
  if (frameToSec(counter) > 18 && frameToSec(counter) < 19.25)
  {
    mouthVerts_Y[1] += 0.1;
    mouthVerts_Y[3] -= 0.1;
    mouthVerts_Y[5] -= 0.1;
    mouthVerts_Y[7] += 0.1;
    headRot_Y = lerp(headRot_Y, -10, frameToSec(counter)/400);
  }

  float i = random(0, 3);
  if (frameCount % blinkIntervals[(int) i] == 0)
  {
    eyeWidth = 19;
    eyeHeight = 4;
  } else
  {
    eyeWidth = 14;
    eyeHeight = 15;
  }
  drawWall();
  
  drawFloor();

  if (frameToSec(counter) > 15 && frameToSec(counter) < 15.375)
  {
    fgDis.x++;
  }

  pushMatrix();
  translate(bgDis.x * 4, bgDis.y);
  translate(fgDis.x * 10, fgDis.y);
  fill(colorPalette[9]);
  
  rect(-1500, 350, 250, 200);//Window R
  rect(-1780, 350, 250, 200);//Window L
  
  noStroke();
  pushMatrix();
  translate(bgDis.x/4, 0);
  drawSun(-1850, 310);
  popMatrix();
  
  fill(colorPalette[14]);
  stroke(colorPalette[16]);
  //Separator
  rect(-1640, 350, 28, 200);
  noStroke();
  rect(-1640, 200, 24, 200);
  rect(-1640, 370, 24, 200);
  
  drawVent(-950, 575);
  drawAC(-1100, 100);
  drawBBoard(120, 350, 400, 250);
  drawDoor(500, 405, 270, 450);
  drawDoubleDoor(-500, 405, 270, 450);
  
  drawPlant(-100, 575, 0.8, 0.9);
  drawPlant(-1200, 575, 0.8, 0.9);
  
  drawChair(-3200, 600);
  drawYanto(-3800, 60, "sitting");
  //drawTable(-3150, 560);
  drawTable(-2900, 550);
  popMatrix();

  translate(fgDis.x * 10, fgDis.y);
  drawBudi(100, 0, "standing");
  
}
void drawBudi(float x, float y, String stance)
{
  pushMatrix();
  translate(x, y);
  
  drawArmStraight(585, 410, 1, 0.9, handRotRight_B, colorPalette[1], colorPalette[2]);

  drawLegStraight(575, 465, 1.1, 1.1, -legRot_B, colorPalette[1], colorPalette[5]);
  drawLegStraight(620, 466, 1.1, 1.1, legRot_B, colorPalette[7], colorPalette[5]);

  drawTorsoSuit(590, 415, 1, 1, torsoRot_B);

  drawHeadBudi(586, 428, 1, 1, -headRot_B);

  drawArmStraight(620, 395, 1.2, 1.1, handRotLeft_B, colorPalette[7], colorPalette[2]);
  popMatrix();
}
void drawYanto(float x, float y, String stance)
{
  pushMatrix();
  translate(x, y);

  if (stance.toLowerCase().equals("sitting"))
  {
    drawArmBent(585, 410, -1, 0.9, handRotRight_Y, colorPalette[11], colorPalette[2]);
    drawLegBent(600, 465, -1.1, 1.1, 0, colorPalette[1], colorPalette[5]);
    drawLegBent(555, 466, -1.1, 1.1, 0, colorPalette[7], colorPalette[5]);
  } 
  else if (stance.toLowerCase().equals("standing"))
  {
    drawArmStraight(585, 410, -1, 0.9, handRotLeft_Y, colorPalette[11], colorPalette[2]);
    drawLegStraight(575, 465, -1.1, 1.1, -legRot_Y, colorPalette[1], colorPalette[5]);
    drawLegStraight(620, 466, -1.1, 1.1, legRot_Y, colorPalette[7], colorPalette[5]);
  }

  drawTorsoShirt(590, 415, -1, 1, torsoRot_Y);

  drawHeadYanto(590, 428, -1, 1, -headRot_Y);

  if(stance.toLowerCase().equals("sitting"))
  {
    drawArmBent(560, 395, -1.2, 1.1, handRotLeft_Y, colorPalette[11], colorPalette[2]);
  }
  else if(stance.toLowerCase().equals("standing"))
  {
    drawArmStraight(560, 395, -1.2, 1.1, handRotLeft_Y, colorPalette[11], colorPalette[2]);
  }
  popMatrix();
}
void drawHeadYanto(float x, float y, float xScale, float yScale, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);

  //Rambut
  fill(colorPalette[1]);
  ellipse(2, -105, 115, 105);

  //Bayangan
  fill(colorPalette[0]);
  noStroke();
  ellipse(-5, -43, 36, 25);

  //Wajah
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[2]);
  vertex(44, -59);
  bezierVertex(27, -33, -37, -23, -55, -61);
  bezierVertex(-59, -83, -59, -94, -55, -116);
  vertex(-16, -120);
  bezierVertex(35, -137, 5, -84, 29, -86);
  bezierVertex(42, -108, 74, -99, 65, -75);
  bezierVertex(63, -64, 55, -53, 36, -64);
  endShape();
  
  //Peci cap
  fill(colorPalette[15]);
  createShape();
  beginShape();
  vertex(60, -125);
  bezierVertex(60, -185, -58, -185,-58, -125);
  endShape(CLOSE);
  
  //Peci brim
  fill(colorPalette[15]);
  createShape();
  beginShape();
  vertex(-60, -112);
  vertex(62, -112);
  vertex(62, -126);
  vertex(-60, -126);
  endShape(CLOSE);
  
  //Daun telinga
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[2]);
  vertex(37, -80);
  bezierVertex(40, -83, 46, -91, 56, -85);
  endShape();

  //Lubang telinga
  createShape();
  beginShape();
  vertex(47, -84);
  bezierVertex(40, -83, 46, -91, 48, -76);
  endShape();


  //Mulut
  noFill();
  stroke(colorPalette[1]);
  pushMatrix();
  translate(-4, 0);
  
  bezier(mouthVerts_Y[0], mouthVerts_Y[1], mouthVerts_Y[2], mouthVerts_Y[3], mouthVerts_Y[4], mouthVerts_Y[5], mouthVerts_Y[6], mouthVerts_Y[7]);
  
  popMatrix();

  drawCustomEllipse(-40, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kiri
  drawCustomEllipse(-10, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kanan

  popMatrix();
}
void drawHeadBudi(float x, float y, float xScale, float yScale, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);
  //Rambut
  fill(colorPalette[1]);
  ellipse(2, -105, 115, 105);

  //Bayangan
  fill(colorPalette[0]);
  noStroke();
  ellipse(-5, -43, 36, 25);

  //Wajah
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[2]);
  vertex(44, -59);
  bezierVertex(27, -33, -37, -23, -55, -61);
  bezierVertex(-59, -83, -59, -94, -55, -116);
  bezierVertex(-27, -128, -52, -100, -16, -112);
  bezierVertex(35, -137, 5, -84, 29, -86);
  bezierVertex(42, -108, 74, -99, 65, -75);
  bezierVertex(63, -64, 55, -53, 36, -64);
  endShape();

  //Daun telinga
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[2]);
  vertex(37, -80);
  bezierVertex(40, -83, 46, -91, 56, -85);
  endShape();

  //Lubang telinga
  createShape();
  beginShape();
  vertex(47, -84);
  bezierVertex(40, -83, 46, -91, 48, -76);
  endShape();

  drawCustomEllipse(-25, -54, 15, 6, colorPalette[3]); //Mulut

  //Kumis
  noFill();
  stroke(colorPalette[1]);
  strokeWeight(15);
  bezier(-36, -56, -43, -65, -6, -65, -14, -57);

  drawCustomEllipse(-40, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kiri
  drawCustomEllipse(-10, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kanan

  popMatrix();
}
void drawCustomEllipse(float x, float y, float w, float h, int col)
{
  noStroke();
  fill(col);
  ellipse(x, y, w, h);
}
void drawTorsoShirt(float x, float y, float xScale, float yScale, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);
  //Badan
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[11]);
  vertex(-60, 72);
  bezierVertex(-80, -68, 107, -53, 70, 72);
  endShape(CLOSE);

  //Dasi
  createShape();
  beginShape();
  strokeWeight(3);
  fill(colorPalette[13]);
  vertex(-25, 55);
  bezierVertex(-27, 28, -28, 42, -22, -7);
  vertex(-7, -7);
  bezierVertex(-6, 25, -2, 42, -6, 55);
  vertex(-13, 65);
  endShape(CLOSE);

  strokeCap(ROUND);
  createShape();
  beginShape();
  stroke(colorPalette[0]);
  fill(colorPalette[13]);
  vertex(-22, -7);
  vertex(-7, -7);
  vertex(-2, -20);
  vertex(-20, -20);
  endShape(CLOSE);

  popMatrix();
}
void drawTorsoSuit(float x, float y, float xScale, float yScale, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);
  
  //Badan
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[7]);
  vertex(-60, 72);
  bezierVertex(-80, -68, 107, -53, 70, 72);
  endShape(CLOSE);

  //Kerah kanan
  createShape();
  beginShape();
  fill(colorPalette[1]);
  vertex(-42, 37);
  vertex(-44, -2);
  vertex(-19, -20);
  endShape(CLOSE);

  //Dasi
  createShape();
  beginShape();
  fill(colorPalette[12]);
  vertex(-42, 72);
  bezierVertex(-46, -18, -23, -30, 15, -25);
  bezierVertex(-25, 1, -20, -9, -20, 72);
  endShape(CLOSE);

  //Pola dasi
  strokeCap(SQUARE);
  strokeWeight(7);
  stroke(colorPalette[13]);
  line(-33, 0, -15, 17);
  line(-39, 18, -17, 39);

  strokeCap(ROUND);
  createShape();
  beginShape();
  stroke(colorPalette[0]);
  strokeWeight(2.5);
  fill(colorPalette[12]);
  vertex(-30, -10);
  vertex(-10, -5);
  vertex(-5, -20);
  vertex(-22, -20);
  endShape(CLOSE);

  //Kancing
  //drawCustomEllipse(-25, 10, 6, 5, colorPalette[1]);
  //drawCustomEllipse(-28, 30, 6, 5, colorPalette[1]);
  //drawCustomEllipse(-28, 50, 6, 5, colorPalette[1]);

  //Daleman
  rectMode(CENTER);
  fill(colorPalette[9]);
  createShape();
  beginShape();
  strokeWeight(3.5);
  vertex(-40, 70);
  vertex(-23, 70);
  vertex(-23, 53);
  vertex(-32, 63);
  vertex(-40, 50);
  endShape(CLOSE);
  //rect(-30, 67, 24, 15);
  strokeCap(ROUND);
  //Kerah kiri
  createShape();
  beginShape();
  strokeWeight(3.5);
  stroke(colorPalette[0]);
  fill(colorPalette[1]);
  vertex(-20, 42);
  bezierVertex(-16, -18, -20, -30, 15, -25);
  bezierVertex(-10, 1, -20, -9, 0, 12);
  endShape(CLOSE);
  popMatrix();
}
void drawArmStraight(float x, float y, float xScale, float yScale, float angle, int colA, int colB)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);
  fill(colB);
  stroke(colorPalette[0]);
  strokeWeight(3);
  ellipse(0, 140, 29, 30);

  createShape();
  beginShape();
  fill(colA);
  vertex(-15, 15);
  bezierVertex(-12, 0, 12, 0, 15, 15);
  vertex(20, 70);
  vertex(15, 130);
  vertex(-15, 130);
  vertex(-10, 70);
  endShape(CLOSE);
  popMatrix();
}
void drawArmBent(float x, float y, float xScale, float yScale, float angle, int colA, int colB)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  scale(xScale, yScale);
  fill(colB);
  stroke(colorPalette[0]);
  strokeWeight(3);
  ellipse(-40, 125, 29, 30);

  createShape();
  beginShape();
  fill(colA);
  vertex(-15, 15);
  bezierVertex(-12, 0, 12, 0, 15, 15);
  vertex(20, 70);
  vertex(-20, 130);
  vertex(-40, 110);
  vertex(-10, 65);
  endShape(CLOSE);
  popMatrix();
}
void drawLegStraight(float x, float y, float xScale, float yScale, float angle, int colA, int colB)
{
  pushMatrix();
  translate(x, y);
  scale(xScale, yScale);
  rotate(radians(angle));
  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colB);
  vertex(-15, 155);
  vertex(-15, 165);
  vertex(20, 165);
  vertex(20, 155);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colA);
  vertex(-27, 0);
  vertex(-27, 65);
  vertex(-22, 155);
  vertex(27, 155);
  vertex(27, 155);
  vertex(22, 69);
  vertex(22, 0);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colA);
  vertex(25, 165);
  vertex(-17, 165);
  bezierVertex(-35, 165, -40, 175, -35, 187);
  vertex(25, 187);

  endShape(CLOSE);

  popMatrix();
}
void drawLegBent(float x, float y, float xScale, float yScale, float angle, int colA, int colB)
{
  pushMatrix();
  translate(x, y);
  scale(xScale, yScale);
  rotate(radians(angle));

  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colB);
  vertex(-80, 120);
  vertex(-80, 130);
  vertex(-45, 130);
  vertex(-45, 120);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colA);
  vertex(28, 20);
  vertex(-55, 23);
  bezierVertex(-90, 30, -88, 30,-88, 120);
  vertex(-45, 120);
  vertex(-45, 75);
  bezierVertex(-45, 55, -42, 60, 6, 60);
  bezierVertex(26, 55, 28, 40, 28, 20);
  endShape();

  createShape();
  beginShape();
  strokeWeight(3.5);
  fill(colA);
  vertex(-45, 120);
  vertex(-82, 120);
  bezierVertex(-100, 120, -105, 130, -100, 142);
  vertex(-45, 142);

  endShape(CLOSE);

  popMatrix();
}
void drawWall()
{
  createShape();
  beginShape();
  noStroke();
  fill(colorPalette[15]);
  vertex(0, height/1.45);
  vertex(width, height/1.45);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}
void drawSun(float x, float y)
{
  pushMatrix();
  translate(x, y);
  fill(colorPalette[11], 25);
  circle(0, 0, 125);
  fill(colorPalette[11], 50);
  circle(0, 0, 100);
  fill(colorPalette[11], 75);
  circle(0, 0, 75);
  fill(colorPalette[11]);
  circle(0, 0, 50);
  popMatrix();
}
void drawDoor(float x, float y, float w, float h)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
  strokeWeight(4);
  fill(colorPalette[14]);
  rect(0, 0, w/1.2, h); //Base
  fill(colorPalette[15]);
  rect(-w/4, 25, 15, 50); //Handle
  rect(w/2.2, 0, w/9.8, h); //Side
  popMatrix();
}
void drawDoubleDoor(float x, float y, float w, float h)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
  strokeWeight(4);
  fill(colorPalette[14]);
  rect(-w/1.25, 0, w/1.25, h); //Base L
  rect(0, 0, w/1.2, h); //Base R
  fill(colorPalette[15]);
  rect(-w/1.75, 25, 15, 50); //Handle L
  rect(-w/4, 25, 15, 50); //Handle R
  rect(w/2.2, 0, w/9.8, h); //Side
  popMatrix();
}
void drawBBoard(float x, float y, float w, float h)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
  strokeWeight(4);
  fill(colorPalette[15]);
  rect(-w/1.95, 0, w/30, h); //Side
  fill(colorPalette[14]);
  rect(0, 0, w, h); //Frame
  fill(colorPalette[15]);
  noStroke();
  rect(1, 0, w/1.075, h/1.1); //Base
  //Papers
  fill(colorPalette[14]);
  rect(-100, 0, 60, 75);
  rect(-125, -50, 50, 60);
  rect(10, -25, 50, 60);
  rect(-25, 50, 50, 60);
  rect(100, 10, 100, 125);
  popMatrix();
}
void drawVent(float x, float y)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
  strokeWeight(4);
  fill(colorPalette[14]);
  rect(0, 0, 125, 70); //Base
  //Holes
  strokeWeight(6);
  line(-40, -20, -40, 20);
  line(-20, -20, -20, 20);
  line(0, -20, 0, 20);
  line(19, -20, 19, 20);
  line(39, -20, 39, 20);
  popMatrix();
}
void drawAC(float x, float y)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
  strokeWeight(3.5);
  //Side
  fill(colorPalette[15]);
  createShape();
  beginShape();
  vertex(-140, -45);
  bezierVertex(-170, -45, -170, -45, -170, -15);
  vertex(-170, 30);
  vertex(-120, 30);
  vertex(-120, -45);
  endShape(CLOSE);
  
  //Side box
  fill(colorPalette[14]);
  rect(-157, -15, 25, 25);
  
  //Front
  fill(colorPalette[14]);
  createShape();
  beginShape();
  vertex(45, 30);
  bezierVertex(105, 30, 105, 15, 105, -25);
  bezierVertex(105, -45, 105, -45, 55, -45);
  vertex(-125, -45);
  bezierVertex(-124, 0, -125, 25, -160, 30);
  endShape(CLOSE);
  
  //Vent
  line(-130, 10, 99, 10);
  line(-135, 18, 97, 18);
  popMatrix();
}
void drawFloor()
{
  createShape();
  beginShape();
  noStroke();
  fill(colorPalette[14]);
  vertex(0, height - 90);
  vertex(width, height - 90);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  createShape();
  beginShape();
  strokeWeight(4);
  stroke(colorPalette[16]);
  vertex(0, height-90);
  vertex(width, height-90);
  endShape();
  
}
void drawChair(float x, float y)
{
  pushMatrix();
  translate(x, y);
  fill(colorPalette[15]);
  rect(-15, 32.5, 20, 65); //Shaft
  //Bot
  createShape();
  beginShape();
  //vertex(-25, 100);
  vertex(-35, 60);
  vertex(-38, 73);
  vertex(8, 73);
  vertex(5, 60);
  endShape(CLOSE);
  fill(colorPalette[8]);
  rect(0, 0, 150, 20, 4*PI); //Cushion
  popMatrix();
}
void drawTable(float x, float y)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[0]);
  
  fill(colorPalette[0]);
  noStroke();
  
  //Leg - Back Right
  createShape();
  beginShape();
  vertex(95, 2);
  vertex(80, 126);
  vertex(92.5, 126);
  vertex(106.5, 2);
  endShape();
  
  fill(colorPalette[6]);
  stroke(colorPalette[0]);
  //Leg - Back Left
  createShape();
  beginShape();
  vertex(-150, 2);
  vertex(-165, 126);
  vertex(-152.5, 126);
  vertex(-138.5, 2);
  endShape();
  
  //Leg - Front Left
  createShape();
  beginShape();
  vertex(-107, 6);
  vertex(-90, 130);
  vertex(-77.5, 130);
  vertex(-95.5, 6);
  endShape();
  
  //Leg - Front Right
  createShape();
  beginShape();
  vertex(143, 6);
  vertex(160, 130);
  vertex(172.5, 130);
  vertex(154.5, 6);
  endShape();
  
  rect(0, 0, 360, 12);//Tabletop
  
  popMatrix();
}
void drawPlant(float x, float y, float xScale, float yScale)
{
  pushMatrix();
  translate(x, y);
  scale(xScale, yScale);
  stroke(colorPalette[0]);
  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(3.25);
  vertex(-17, -25);
  vertex(10, -225);
  vertex(20, -225);
  vertex(-7, -25);
  endShape(CLOSE);

  drawLeaf(10, -155, 1.45, 1, PI/2.12, 2.7);

  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(3.5);
  vertex(-40, -25);
  vertex(-40, -260);
  vertex(-30, -260);
  vertex(-30, -25);
  endShape(CLOSE);

  drawLeaf(-30, -190, 1.7, 1.3, PI/3, 2.25);
  drawLeaf(-33, -235, 1.1, 1.1, 11*PI/6, 3.15);
  drawLeaf(-42, -155, 1.8, 1.45, 5*PI/3, 2.15);
  drawLeaf(-42, -100, 2.25, 1.8, 19.0*PI/12.0, 1.65);
  drawLeaf(-30, -85, 1.8, 1.45, PI/3, 2.25);

  createShape();
  beginShape();
  strokeWeight(4.25);
  fill(colorPalette[9]);
  vertex(-75, 70);
  vertex(25, 70);
  vertex(40, -25);
  vertex(-95, -25);
  endShape(CLOSE);

  createShape();
  beginShape();
  fill(colorPalette[8]);
  vertex(-100, -25);
  vertex(45, -25);
  vertex(45, -15);
  vertex(-100, -15);
  endShape(CLOSE);
  popMatrix();
}

void drawLeaf(float x, float y, float xScale, float yScale, float angle, float strokeWeight)
{
  pushMatrix();
  translate(x, y);
  scale(xScale, yScale);
  rotate(angle);
  strokeWeight(strokeWeight);
  createShape();
  beginShape();
  fill(colorPalette[10]);
  vertex(0, 0);
  bezierVertex(-20, -5, -20, -40, 0, -50);
  bezierVertex(20, -40, 20, -5, 0, 0);
  endShape(CLOSE);  

  createShape();
  beginShape();
  noFill();
  vertex(0, 0);
  vertex(0, -30);
  endShape();
  popMatrix();
}

static float frameToSec(float frame)
{
  return frame/60f;
}
