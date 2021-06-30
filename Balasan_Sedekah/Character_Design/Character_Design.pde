int[] colorPalette = {#2a2329, #454050, #f0a984, #752438, #a8d9fe, #d0dac0, #af908c, #514b5e, #7eb0ce, #deeafa, #56ad7a, #e8c170, #233f71, #546c96}; 
float eyeWidth = 14, eyeHeight = 15;
int[] blinkIntervals = {60, 60, 90, 120};
int counter = 0;

PVector bgDis = new PVector(0, 0);
PVector fgDis = new PVector(0, 0);
//Pak Budi
float headRot_B = 0, torsoRot_B = 0, handRotLeft_B = 0, handRotRight_B = 0, legRot_B = 0;
//Pak Yanto
float headRot_Y = 0, torsoRot_Y = 0, handRotLeft_Y = 0, handRotRight_Y = 0, legRot_Y = 0;

void setup()
{
  size(1280, 720);
  smooth(8);  
  frameRate(60);
  strokeWeight(4);
  hint(ENABLE_STROKE_PURE);
  strokeCap(ROUND);
}
void draw()
{
  counter++;
  background(colorPalette[8]);
  textSize(18);
  fill(#FFFF00);
  text("FPS: " + round(frameRate), 20, 35);
  text("ET : " + nf(frameToSec(counter), 0, 2), 21, 60);

  drawScene1();

  if (frameCount < 2)
  {
    filter(ERODE);
  }
}
void drawScene1()
{
  
  if (frameToSec(counter) < 7)
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
  else if (frameToSec(counter) < 8)
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
  drawFloor();

  if (frameToSec(counter) > 7 && frameToSec(counter) < 7.5)
  {
    fgDis.x++;
  }

  pushMatrix();
  translate(bgDis.x * 4, bgDis.y);
  drawPlant(-100, 575, 0.8, 0.9);
  drawYanto(-2000, 60, "sitting");
  popMatrix();

  //translate(fgDis.x * 10, fgDis.y);
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
  strokeWeight(4);
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

  //Daun telinga
  createShape();
  beginShape();
  strokeWeight(4);
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
  strokeWeight(4);
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
  strokeWeight(4);
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
  strokeWeight(4);
  stroke(colorPalette[0]);
  fill(colorPalette[11]);
  vertex(-60, 72);
  bezierVertex(-80, -68, 107, -53, 70, 72);
  endShape(CLOSE);

  //Dasi
  createShape();
  beginShape();
  strokeWeight(3.5);
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
  strokeWeight(4);
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
  stroke(colorPalette[13]);
  line(-33, 0, -15, 17);
  line(-39, 18, -17, 39);

  strokeCap(ROUND);
  createShape();
  beginShape();
  stroke(colorPalette[0]);
  strokeWeight(3);
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
  strokeWeight(4);
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
  strokeWeight(4);
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
  strokeWeight(3.5);
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
  strokeWeight(3.5);
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
  strokeWeight(4);
  fill(colB);
  vertex(-15, 155);
  vertex(-15, 165);
  vertex(20, 165);
  vertex(20, 155);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(4);
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
  strokeWeight(4);
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
  strokeWeight(4);
  fill(colB);
  vertex(-80, 120);
  vertex(-80, 130);
  vertex(-45, 130);
  vertex(-45, 120);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(4);
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
  strokeWeight(4);
  fill(colA);
  vertex(-45, 120);
  vertex(-82, 120);
  bezierVertex(-100, 120, -105, 130, -100, 142);
  vertex(-45, 142);

  endShape(CLOSE);

  popMatrix();
}
void drawFloor()
{
  createShape();
  beginShape();
  noStroke();
  fill(colorPalette[9]);
  vertex(0, height - 90);
  vertex(width, height - 90);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(5);
  stroke(colorPalette[0]);
  vertex(width/6, height - 90);
  vertex(width - width/6, height - 90);
  endShape();
}
void drawPlant(float x, float y, float xScale, float yScale)
{
  pushMatrix();
  translate(x, y);
  scale(xScale, yScale);
  circle(0, 0, 50);
  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(3.75);
  vertex(-17, -25);
  vertex(10, -225);
  vertex(18, -225);
  vertex(-9, -25);
  endShape(CLOSE);

  drawLeaf(10, -155, 1.45, 1, PI/2.12, 3.2);

  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(4);
  vertex(-40, -25);
  vertex(-40, -260);
  vertex(-32, -260);
  vertex(-32, -25);
  endShape(CLOSE);

  drawLeaf(-30, -190, 1.7, 1.3, PI/3, 2.75);
  drawLeaf(-35, -235, 1.1, 1.1, 11*PI/6, 3.65);
  drawLeaf(-42, -155, 1.8, 1.45, 5*PI/3, 2.65);
  drawLeaf(-42, -100, 2.25, 1.8, 19.0*PI/12.0, 2.15);
  drawLeaf(-30, -85, 1.8, 1.45, PI/3, 2.75);

  createShape();
  beginShape();
  strokeWeight(4.75);
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
