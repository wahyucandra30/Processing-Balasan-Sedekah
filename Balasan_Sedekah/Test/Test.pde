int[] colorPalette = {#2a2329,#454050, #f0a984, #752438, #a8d9fe, #d0dac0, #af908c, #514b5e, #7eb0ce,
                      #deeafa, #56ad7a, #eab353, #233f71, #546c96, #e9edf3, #d1d5db, #83858b}; 
float eyeWidth = 14, eyeHeight = 15;

//Pak Yanto
float headRot_Y = 0, torsoRot_Y = 0, handRotLeft_Y = 0, handRotRight_Y = 0, legRot_Y = 0;

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
  background(colorPalette[14]);
  //drawYanto(0, 60, "sitting");
  drawAC(width/2, 100);
  drawSofa(width/2, height - height/3);
  filter(ERODE);
}
void drawSofa(float x, float y)
{
  pushMatrix();
  translate(x, y);
  
  stroke(colorPalette[0]);
  
  //Back Foot L
  fill(colorPalette[15]);
  rect(-65, 65, 22, 40);
  //Front Foot L
  fill(colorPalette[14]);
  rect(35, 65, 22, 40);
  //Back Foot R
  fill(colorPalette[15]);
  rect(215, 65, 22, 40);
  //Front Foot R
  fill(colorPalette[14]);
  rect(315, 65, 22, 40);
  
  //Front R
  fill(colorPalette[14]);
  createShape();
  beginShape();
  vertex(-15, -15);
  vertex(320, -15);
  bezierVertex(330, -15, 340, -10, 340, 10);
  vertex(340, 75);
  vertex(-65, 75);
  endShape(CLOSE);
  
  //Side R
  fill(colorPalette[15]);
  createShape();
  beginShape();
  vertex(-15, -15);
  vertex(290, -15);
  bezierVertex(300, -15, 310, -10, 310, 10);
  vertex(310, 75);
  vertex(-65, 75);
  endShape(CLOSE);
  
  //Top Cushion
  fill(colorPalette[14]);
  createShape();
  beginShape();
  vertex(-60, -95);
  vertex(230, -95);
  bezierVertex(240, -95, 250, -90, 250, -75);
  vertex(250, 75);
  vertex(-65, 75);
  endShape(CLOSE);
  
  //Bottom Cushion
  fill(colorPalette[14]);
  createShape();
  beginShape();
  vertex(-60, 25);
  vertex(290, 25);
  bezierVertex(300, 25, 310, 30, 310, 45);
  vertex(310, 75);
  vertex(-65, 75);
  endShape(CLOSE);
  
  //Front L
  fill(colorPalette[14]);
  createShape();
  beginShape();
  vertex(-15, -15);
  vertex(40, -15);
  bezierVertex(50, -15, 60, -10, 60, 10);
  vertex(60, 75);
  vertex(-65, 75);
  endShape(CLOSE);

  //Side L
  fill(colorPalette[15]);
  createShape();
  beginShape();
  vertex(-75, 75);
  vertex(-75, -80);
  bezierVertex(-75, -90, -65, -95, -60, -95);
  bezierVertex(-50, -95, -35, -95, -35, -15);
  vertex(10, -15);
  bezierVertex(20, -15, 30, -10, 30, 10);
  vertex(30, 75);
  endShape(CLOSE);
  popMatrix();
}
void drawChair(float x, float y)
{
  rectMode(CENTER);
  pushMatrix();
  translate(x, y);
  fill(colorPalette[15]);
  rect(-15, 50, 20, 100); //Shaft
  //Bot
  createShape();
  beginShape();
  //vertex(-25, 100);
  vertex(-35, 100);
  vertex(-38, 113);
  vertex(8, 113);
  vertex(5, 100);
  endShape(CLOSE);
  fill(colorPalette[8]);
  rect(0, 0, 150, 20, 4*PI); //Cushion
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
  //strokeWeight(15);
  pushMatrix();
  translate(-4, 0);
  bezier(-30, -64, -28, -56, -18, -56, -16, -64);
  popMatrix();

  drawCustomEllipse(-40, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kiri
  drawCustomEllipse(-10, -81, eyeWidth, eyeHeight, colorPalette[1]);//Mata kanan

  popMatrix();
}
void drawAC(float x, float y)
{
  pushMatrix();
  translate(x, y);
  stroke(colorPalette[16]);
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
  rect(-170, -30, 25, 25);
  
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
void drawCustomEllipse(float x, float y, float w, float h, int col)
{
  noStroke();
  fill(col);
  ellipse(x, y, w, h);
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
