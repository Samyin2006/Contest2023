class Manson{
  int manson_ID;
  
  //Constructor
  Manson(int _manson_ID)
  {
    manson_ID = _manson_ID;
  }
}

class MansonPosition{
  int xPos;
  int yPos;
  
  //Constructor
  MansonPosition(){
    xPos = -1;
    yPos = -1;
  }
  
  void updatePosition(int _xPos, int _yPos){
    xPos = _xPos;
    yPos = _yPos;
  }
  
}
