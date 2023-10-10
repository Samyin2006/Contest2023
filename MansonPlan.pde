class MansonPlan{
  int Action;
  int Direction;
  String real_action;
  
  int current_x;
  int current_y;
  
  int target_x;
  int target_y;
  
  Wall_Type[][] PlannedWallArray = new Wall_Type[25][25];
  
  //Constructor
  MansonPlan()
  {
    Action = 0;
    Direction = 0;
    real_action = "";
    
    current_x = -1;
    current_y = -1;
    
    target_x = -1;
    target_y = -1;
    for(int i=0; i<25; i++){
      for(int j=0; j<25; j++){
        PlannedWallArray[i][j] = Wall_Type.NO_WALL;
      }
    }
  }
  
  void setPlannedWall(int _xPos, int _yPos){
    PlannedWallArray[_xPos][_yPos] = Wall_Type.RED_WALL;
  }
  
  void clearSinglePlannedWall(int _xPos, int _yPos){
    PlannedWallArray[_xPos][_yPos] = Wall_Type.NO_WALL;
  }
  
  void setPlannedWall_round(int _xPos, int _yPos){
    PlannedWallArray[_xPos-1][_yPos] = Wall_Type.RED_WALL;
    PlannedWallArray[_xPos+1][_yPos] = Wall_Type.RED_WALL;
    PlannedWallArray[_xPos][_yPos-1] = Wall_Type.RED_WALL;
    PlannedWallArray[_xPos][_yPos+1] = Wall_Type.RED_WALL;
  }
  
  void clearPlannedWall(){
    for(int i=0; i<25; i++){
      for(int j=0; j<25; j++){
        PlannedWallArray[i][j] = Wall_Type.NO_WALL;
      }
    }
  }
  
  boolean checkPlannedWall_UP(){
    if(current_y-1 > 0){
      if(contest_api.WallArray[current_x][current_y-1] != Wall_Type.RED_WALL){
        if(PlannedWallArray[current_x][current_y-1] == Wall_Type.RED_WALL)
          return true;
      }else
        clearSinglePlannedWall(current_x,current_y-1);
    }
    return false;
  }
  
  boolean checkPlannedWall_DOWN(){
    if(current_y+1 < contest_api.map_height){
      if(contest_api.WallArray[current_x][current_y+1] != Wall_Type.RED_WALL){
        if(PlannedWallArray[current_x][current_y+1] == Wall_Type.RED_WALL)
          return true;
      }else
        clearSinglePlannedWall(current_x,current_y+1);
    }
    return false;
  }
  
  boolean checkPlannedWall_LEFT(){
    if(current_x-1 > 0){
      if(contest_api.WallArray[current_x-1][current_y] != Wall_Type.RED_WALL){
        if(PlannedWallArray[current_x-1][current_y] == Wall_Type.RED_WALL)
          return true;
      }else
        clearSinglePlannedWall(current_x-1,current_y);
    }
    return false;
  }
  
  boolean checkPlannedWall_RIGHT(){
    if(current_x+1 < contest_api.map_width){
      if(contest_api.WallArray[current_x+1][current_y] != Wall_Type.RED_WALL){
        if(PlannedWallArray[current_x+1][current_y] == Wall_Type.RED_WALL)
          return true;
      }else
        clearSinglePlannedWall(current_x+1,current_y);
    }
    return false;
  }
  
  void updatePosition(int _xPos, int _yPos){
    current_x = _xPos;
    current_y = _yPos;
  }
}
