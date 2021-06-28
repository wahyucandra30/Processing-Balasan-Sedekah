void setup()
{
  size(600, 600);
}
void draw()
{
  drawHead(0,0);
}
void drawHead(int x, int y)
{
  createShape();
  beginShape();
  strokeWeight(3);
  stroke(60);
  fill(#f0a984);
  vertex(x+344.6, y+241.7);
  bezierVertex(x+327.4, y+267.8, x+263.2, y+277.8, x+245.3, y+239.6);
  bezierVertex(x+241.4, y+217.5, x+241.1, y+206.6, x+245.9, y+184.2);
  bezierVertex(x+271.4, y+170.1, x+257.4, y+195.4, x+279.5, y+187.2);
  bezierVertex(x+335.2, y+163.3, x+305.9, y+216.9, x+329.2, y+214.5);
  bezierVertex(x+342.8, y+192.1, x+374.1, y+201.2, x+365.5, y+225.7);
  bezierVertex(x+363.4, y+236.9, x+355.8, y+247.2, x+336.4, y+236.9);
  endShape(CLOSE);
  



}
void drawHair(int x, int y)
{
  createShape();
  beginShape();
  noFill();
  vertex(x+328.1, y+217.8);
  bezierVertex(x+306.5, y+210.3, x+329.7, y+167.2, x+290, y+188.2);
  bezierVertex(x+255.6, y+199.1, x+273.6, y+174.9, x+245.7, y+183.1);
  bezierVertex(x+276.5, y+102.7, x+366.9, y+152.7, x+355, y+197.7);
  bezierVertex(x+353.4, y+236.7, x+354.8, y+234, x+328.1, y+217.8);
  endShape(CLOSE);
  
  /*
  noFill();
  stroke(-16777216);
  strokeWeight(4.3333335);
  bezier(328.01996, 217.86255, 306.52438, 210.29367, 329.68137, 167.15866, 279.78543, 188.21526);

  noFill();
  stroke(-16777216);
  strokeWeight(4.3333335);
  bezier(283.53204, 186.85286, 255.60287, 199.11444, 273.6546, 174.93188, 245.7255, 183.10626);

  noFill();
  stroke(-16777216);
  strokeWeight(4.3333335);
  bezier(245.7255, 182.08447, 276.53952, 102.7793, 366.97888, 152.79292, 355.0579, 197.75204);

  noFill();
  stroke(-16777216);
  strokeWeight(4.3333335);
  bezier(329.67303, 218.03816, 353.4177, 236.72246, 354.8346, 234.04439, 355.17715, 198.7544);
*/
}
