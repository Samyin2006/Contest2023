class MansonPlan{
  int Action;
  int Direction;
  String real_action;
  
  int current_x;
  int current_y;
  
  int target_x;
  int target_y;
  boolean enable_AI;
  
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
    enable_AI = false;
  }
  
  void updatePosition(int _xPos, int _yPos){
    current_x = _xPos;
    current_y = _yPos;
  }
}
