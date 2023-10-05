class Board{
  MRect[][] r = new MRect[25][25];
  MRect_Type[][] gridType = new MRect_Type[25][25];
  PApplet my_applet;
  boolean gridUpdated;
  int numOfHorizontal;
  int numOfVertical;
  int sizePerBox;
  int spaceBetweenBox;
  int offset_xPos;
  int offset_yPos;

  
  Board(PApplet _applet, int _numOfHorizontal, int _numOfVertical, int _sizePerBox){
    my_applet = _applet;
    numOfHorizontal = _numOfHorizontal;
    numOfVertical = _numOfVertical;
    sizePerBox = _sizePerBox;
    spaceBetweenBox = 2;
    offset_xPos = _sizePerBox;
    offset_yPos = _sizePerBox;
    gridUpdated = true;
    
  }
  
  int width(){
    return 2 * offset_xPos + numOfHorizontal * sizePerBox + 6 * sizePerBox;
  }
  
  int height(){
    return 2 * offset_yPos + numOfVertical * sizePerBox;
  }
  
  void init_board(){
    for(int i=0; i<numOfHorizontal; i++){
      for(int j=0; j<numOfVertical; j++){
        r[i][j] = new MRect(my_applet, offset_xPos+i*sizePerBox, offset_yPos+j*sizePerBox, sizePerBox, spaceBetweenBox, i, j, MRect_Type.FREESPACE);
        gridType[i][j] = MRect_Type.FREESPACE;
      }
    }
  }
  
  void update(){
    if(gridUpdated == true)
    {
      background(0);
      strokeWeight(2);
      stroke(0, 204, 153);
      fill(0, 204, 153);
      rect(0,0,width,height);
      //update
      for(int i=0; i<numOfHorizontal; i++){
        for(int j=0; j<numOfVertical; j++){
          r[i][j].setMRect_Type(gridType[i][j]);
        }
      }
      gridUpdated = false;
    }
  }
  
}
