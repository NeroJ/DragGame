final int cellWidth = 50;
final int cellHeight = cellWidth;
final int numRow = 15;
final int numCols = numRow;
color [] Ball_Color = new color[15];
///////////////////////////////////Ball Array////////////////////////////////////////
Ball [][] Ball_st = new Ball[15][15];
///////////////////////////////////Square Array//////////////////////////////////////
Square [][] Square_st = new Square[15][15];
//////////////////////////////////////Record/////////////////////////////////////////
int indexi, indexj;
int dis = 0;
int dx, dy;
boolean flag = false, flagS = false;
Ball ball;
Square square;
///////////////////////////////Class Ball////////////////////////////////////////////
class Ball
{
  int rad;
  int x, y;
  color c;
  
  Ball(int row, int col) 
  {
    rad = 22;
    x = col * cellWidth + cellWidth/2;
    y = row * cellHeight + cellWidth/2;
  }
  
  void display()
  {
    fill(c);
    noStroke();
    ellipse(x, y, 2*rad, 2*rad);
  }
}
/////////////////////////////Class Square//////////////////////////////////////
class Square
{
  int wid, hei;
  int x, y;
  color c;
  
  Square(int row, int col)
  {
    wid = 44;
    hei = wid;
    x = col * cellWidth + 3;
    y = row * cellHeight + 3;
  }
  
  void display()
  {
    fill(c);
    noStroke();
    rect(x, y, wid, hei);
  }
}
/////////////////////////////Distance Judgement////////////////////////////////
int Distance(int x1,int y1,int x2,int y2)
{
  return int(sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2)));
}
///////////////////////////Set Up and Draw/////////////////////////////////
void setup()
{
  background(255);
  setGrid();
  size(cellWidth * 15 , cellHeight * 15); 
}

void draw()
{
  background(255,255,255);
  drawGrid();
  if (flag == true)
  {
    ball.x = mouseX - dx;
    ball.y = mouseY - dy;
    ball.display();
    Ball_st[indexi][indexj].display();
  }
  if (flagS == true)
  {
    square.x = mouseX - dx;
    square.y = mouseY - dy;
    square.display();
  }
  drawLines();
}
///////////////////////////////Mouse Fonction Part/////////////////////////////
void mousePressed()
{
  for (int i = 0; i < 15; i++) 
  {
    for (int j = 0; j < 15; j++) 
    {
      if (Ball_st[i][j] != null)
      {
        dis = Distance(Ball_st[i][j].x, Ball_st[i][j].y, mouseX, mouseY);
        if (dis <= Ball_st[i][j].rad)
         {
           flag = true;
           ball = new Ball(j,i);
           ball.c = Ball_st[i][j].c;
           dx = mouseX - Ball_st[i][j].x;
           dy = mouseY - Ball_st[i][j].y;
           indexi = i;
           indexj = j;
         }
      }
    }
  }
//////////////////////////////////
  int row0, col0;
  for (int i = 0; i < 15; i++) 
  {
    for (int j = 0; j < 15; j++) 
    {
      if (Square_st[i][j] != null)
      {
         col0 = int(mouseX / 50) ;
         row0 = int(mouseY / 50) ;
        if (row0 == i && col0 == j)
         {
           flagS = true;
           square = new Square(j,i);
           square.c = Square_st[i][j].c;
           dx = mouseX - Square_st[i][j].x;
           dy = mouseY - Square_st[i][j].y;
           indexi = i;
           indexj = j;
         }
      }
    }
  }
}

void mouseReleased()
{
   if (flag == true)
   {
     if (mouseX <= width && mouseX >= 0 && mouseY <= height && mouseY >= 0)
     {
       flag = false;
       Position(mouseX, mouseY);
     }
   }
   ///////////////////////////////////////////////////////////////////////////
   if (flagS == true)
   {
     if (mouseX <= width && mouseX >= 0 && mouseY <= height && mouseY >= 0)
     {
       flagS = false;
       PositionS(mouseX, mouseY);
     }
   }
   
}
/////////////////////////////////////Keyboard Function/////////////////////////////////////
void keyPressed()
{
  if (keyCode == 32)
  {
    for (int i = 0; i < 15; i++)
    {
      for (int j = 0; j < 15; j++)
      {
        Ball_st[i][j] = null;
      }
    }
    //////////////////////////
    for (int i = 0; i < 15; i++)
    {
      for (int j = 0; j < 15; j++)
      {
        Square_st[i][j] = null;
      }
    }
  }
}
/////////////////////////////////////Set Position//////////////////////////////////////////
void Position(int x, int y)
{
 int row0, col0;
 col0 = int(x / 50) ;
 row0 = int(y / 50) ;
 if (Square_st[row0][col0] == null)
 {
   if(row0 != indexi || col0 != indexj)
   {
     Ball_st[row0][col0] = new Ball(row0, col0);
     Ball_st[row0][col0].c = Ball_st[indexi][indexj].c;
     //Ball_st[indexi][indexj] = null;
     Ball_st[row0][col0].x = col0 * cellWidth + cellWidth/2;
     Ball_st[row0][col0].y = row0 * cellHeight + cellWidth/2;
   }
 }
 else
 {
   if(row0 != indexi || col0 != indexj)
   {
     if (row0 != 0)
     {
        Square_st[row0][col0] = null;
        Ball_st[row0][col0] = new Ball(row0, col0);
        Ball_st[row0][col0].c = Ball_st[indexi][indexj].c;
        //Ball_st[indexi][indexj] = null;
        Ball_st[row0][col0].x = col0 * cellWidth + cellWidth/2;
        Ball_st[row0][col0].y = row0 * cellHeight + cellWidth/2;
     }
   }
 }
}

void PositionS(int x, int y)
{
 int row0, col0;
 col0 = int(x / 50) ;
 row0 = int(y / 50) ;
 if (Ball_st[row0][col0] == null)
 {
  if(row0 != indexi || col0 != indexj)
  {
   Square_st[row0][col0] = new Square(row0, col0);
   Square_st[row0][col0].c = Square_st[indexi][indexj].c;
   //Square_st[indexi][indexj] = null;
   Square_st[row0][col0].x = col0 * cellWidth + 3;
   Square_st[row0][col0].y = row0 * cellHeight + 3;
  }
 }
 else
 {
   if(row0 != indexi || col0 != indexj)
  {
    if (row0 != 14)
    {
         Ball_st[row0][col0] = null;
         Square_st[row0][col0] = new Square(row0, col0);
         Square_st[row0][col0].c = Square_st[indexi][indexj].c;
         //Square_st[indexi][indexj] = null;
         Square_st[row0][col0].x = col0 * cellWidth + 3;
         Square_st[row0][col0].y = row0 * cellHeight + 3;
    }
  }
 }
}
//////////////////////////////////All Kinds Of Draw Functions /////////////////////////////////////////////
void drawGrid() 
{
///////////////////////////////////////
  for (int j = 0; j < 15; j++)
  {
    drawBall(14, j, Ball_Color[j]);
  }
  for (int j = 0; j < 15; j++)
  {
    drawSquare(0, j, Ball_Color[j]);
  }
////////////////////////////////////
  for (int i = 0; i < 15; i++) 
  {
    for (int j = 0; j < 15; j++) 
    {
      if (Ball_st[i][j] != null)
      {
        Ball_st[i][j].display();
      }
    }
  }
  for (int i = 0; i < 15; i++) 
  {
    for (int j = 0; j < 15; j++) 
    {
      if (Square_st[i][j] != null)
      {
        Square_st[i][j].display();
      }
    }
  }
}

void drawBall(int row, int col, color co)
{
  Ball_st[row][col] = new Ball(row, col);
  Ball_st[row][col].c = co;
  Ball_st[row][col].display();
}

void drawSquare(int row, int col, color co)
{
  Square_st[row][col] = new Square(row, col);
  Square_st[row][col].c = co;
  Square_st[row][col].display();
}
/////////////////////////////////////////////////Draw Lines Fucntions/////////////////////////
void drawLines()
{
  for (int i = 0; i < 16; i++)
  {
    stroke(0);
    line(i*cellWidth, 0, i*cellWidth, height);
    line(0, i*cellWidth, width, i*cellWidth);
  }
}
//////////////////////////////////////////////////Color Initialization/////////////////////////////////////
void setGrid() 
{ 
  for (int i = 0; i < 15; i++)
  {
    Ball_Color[i] = color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));   
  }
}
