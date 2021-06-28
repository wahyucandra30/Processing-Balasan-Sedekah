int[] colorPalette = {#2a2329, #454050, #f0a984, #752438, #a8d9fe, #d0dac0, #af908c, #514b5e, #7eb0ce, #deeafa, #56ad7a, #e8c170, #233f71, #546c96}; 
float eyeWidth = 14, eyeHeight = 15;
int[] blinkIntervals = {30, 60, 90, 120};
int counter = 0;

float[] headDis = {0,0};
float headRot = 0, torsoRot = 0, handRot = 0;

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
  
  headRot = sin((norm(counter, 0, 1)/15f)) * 3;
  torsoRot = sin((norm(counter, 0, 1)/15f)) * 3;
  handRot = sin((norm(counter, 0, 1)/15f)) * 30;
  

  background(colorPalette[8]);
  textSize(18);
  fill(#FFFF00);
  text("FPS: " + round(frameRate), 20, 35);
  float i = random(0, 3);
  if (frameCount % blinkIntervals[(int) i] == 0)
  {
    eyeWidth = 19;
    eyeHeight = 4;
  } 
  else
  {
    eyeWidth = 14;
    eyeHeight = 15;
  }
  drawFloor();

  translate(width/4, height/7 + 18);

  pushMatrix();
  scale(0.8, 0.9);
  drawPlant(240, 65);
  popMatrix();

  drawArm(285, 300, 1, 0.9, handRot, colorPalette[1], colorPalette[2]);
  
  drawLeg(250, 302, 1.1, 1.1, colorPalette[1], #ffffff);
  drawLeg(295, 303, 1.1, 1.1, colorPalette[7], #ffffff);
  
  drawTorso(290, 285, torsoRot);
  
  drawHead(286, 298, -headRot);
  
  drawArm(270, 242, 1.2, 1.1, -handRot, colorPalette[7], colorPalette[2]);

  if (frameCount < 2)
  {
    filter(ERODE);
  }
}
void drawHead(float x, float y, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  
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
void drawTorso(float x, float y, float angle)
{
  pushMatrix();
  translate(x, y);
  rotate(radians(angle));
  
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
void drawArm(float x, float y, float scalarX, float scalarY, float angle, int colA, int colB)
{
  
  pushMatrix();
  scale(scalarX, scalarY);
  translate(x, y);
  rotate(radians(angle));
  fill(colB);
  stroke(colorPalette[0]);
  strokeWeight(4);
  ellipse(0, 140, 29, 30);
  
  createShape();
  beginShape();
  strokeWeight(4);
  fill(colA);
  vertex(-15, 15);
  bezierVertex(-12,0,12,0,15, 15);
  vertex(20, 70);
  vertex(15, 130);
  vertex(-15, 130);
  vertex(-10, 70);
  endShape(CLOSE);
  popMatrix();
}

void drawLeg(float x, float y, float scalarX, float scalarY, int colA, int colB)
{
  pushMatrix();
  scale(scalarX, scalarY);
  createShape();
  beginShape();
  strokeWeight(4);
  fill(colB);
  vertex(x-15, y+155);
  vertex(x-15, y+165);
  vertex(x+20, y+165);
  vertex(x+20, y+155);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(4);
  fill(colA);
  vertex(x-27, y);
  vertex(x-27, y+65);
  vertex(x-22, y+155);
  vertex(x+27, y+155);
  vertex(x+27, y+155);
  vertex(x+22, y+69);
  vertex(x+22, y);
  endShape(CLOSE);

  createShape();
  beginShape();
  strokeWeight(4);
  fill(colA);
  vertex(x+25, y+165);
  vertex(x-17, y+165);
  bezierVertex(x-35, y+165, x-40, y+175, x-35, y+187);
  vertex(x+25, y+187);

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
void drawPlant(float x, float y)
{
  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(3);
  vertex(x+433, y+425);
  vertex(x+460, y+225);
  vertex(x+468, y+225);
  vertex(x+439, y+425);
  endShape(CLOSE);

  pushMatrix();
  translate(0, -40);
  drawLeaf(x, y, PI/2.12, 3.21, 2.3, 1, 1.45, 3.5);
  popMatrix();
  createShape();
  beginShape();
  fill(colorPalette[9]);
  strokeWeight(3);
  vertex(x+410, y+425);
  vertex(x+410, y+190);
  vertex(x+418, y+190);
  vertex(x+418, y+425);
  endShape(CLOSE);

  pushMatrix();
  translate(0, -40);
  drawLeaf(x, y, PI/3, 2.38, 0.22, 1.45, 1.5, 2.4);
  drawLeaf(x, y, 11*PI/6, 1.81, 5.6, .9, 1.1, 4);
  drawLeaf(x, y, 5*PI/3, 1.55, 9.8, 1.45, 1.8, 2.75);
  drawLeaf(x, y, 19.0*PI/12.0, 1.65, 12.7, 1.8, 2.25, 2);
  drawLeaf(x, y, 5*PI/12, 2.85, 1.5, 1.45, 1.8, 2.75);
  popMatrix();

  createShape();
  beginShape();
  strokeWeight(4);
  fill(colorPalette[9]);
  vertex(x+375, y+520);
  vertex(x+475, y+520);
  vertex(x+490, y+425);
  vertex(x+355, y+425);
  endShape(CLOSE);

  createShape();
  beginShape();
  fill(colorPalette[8]);
  vertex(x+350, y+425);
  vertex(x+495, y+425);
  vertex(x+495, y+435);
  vertex(x+350, y+435);
  endShape(CLOSE);
}

void drawLeaf(float x, float y, float rotation, float deltaX, float deltaY, float scalarX, float scalarY, float strokeWeight)
{
  pushMatrix();
  strokeWeight(strokeWeight);
  translate(deltaX * x, deltaY*y);
  rotate(rotation);
  scale(scalarX, scalarY);
  createShape();
  beginShape();
  fill(colorPalette[10]);
  vertex(x, y);
  bezierVertex(x-20, y-5, x-20, y-40, x, y-50);
  bezierVertex(x+20, y-40, x+20, y-5, x, y);
  endShape(CLOSE);

  createShape();
  beginShape();
  noFill();
  vertex(x, y);
  vertex(x, y-25);
  endShape();
  popMatrix();
}
