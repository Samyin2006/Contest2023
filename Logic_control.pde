enum Logic_state {
  IDLE, MANSON_SELECTED
}

class Logic_control{ 
  int[] xPos = new int[5]; // x_position <current position stor in array 0 --> Old position store in 4>
  int[] yPos = new int[5]; // y_position
  MRect_Type[] clickType = new MRect_Type[5];
  PApplet my_applet;
  Logic_state stateMachine;
  
  
  Logic_control(PApplet _applet){
    my_applet = _applet;
    stateMachine = Logic_state.IDLE;
    for(int i=0; i<5; i++){    //init all button click record
      xPos[i] = -1;
      yPos[i] = -1;
      clickType[i] = MRect_Type.NULL;
    }
  }
  
  void button_click(int _x, int _y, MRect_Type _type){
    for(int i=0; i<4; i++){
      xPos[i+1] = xPos[i];
      yPos[i+1] = yPos[i];
      clickType[i+1] = clickType[i];
    }
    xPos[0] = _x;
    yPos[0] = _y;
    clickType[0] = _type;
    println("button_click!!  [" + str(xPos[0]) + "] [" + str(yPos[0]) + "] " + clickType[0].name() );
    this.logic_update();
  }
  
  void logic_update(){
    println("logic_update!!");
    switch(stateMachine)
    {
      case IDLE:
        if(clickType[0] == MRect_Type.RED_MANSON){
          stateMachine = Logic_state.MANSON_SELECTED;
          println("Logic_state.MANSON_SELECTED!!  [" + str(xPos[0]) + "] [" + str(yPos[0]) + "]");
        }
      break;
      
      case MANSON_SELECTED:
      
        if(mouseButton == LEFT){
          if(this.isValidMove()){
              //myBoard.mansonPlan[xPos[1]][yPos[1]].update_action(Action_Type.MANSON_MOVE, this.check_direction());
              myBoard.gridUpdated = true;
              xPos[0] = -1;
              yPos[0] = -1;
          }
        
        }
        
        
        
        
        
        
        stateMachine = Logic_state.IDLE;
        println("Return Logic_state.IDLE!!");
      break;
    }
  }
  
  boolean isValidMove(){
    if(clickType[0] == MRect_Type.RED_MANSON && !(xPos[0] == xPos[1] && yPos[0] == yPos[1]) ) 
      return false;
    if(clickType[0] == MRect_Type.GREEN_MANSON)
      return false;
    if(clickType[0] == MRect_Type.GREEN_WALL)
      return false;
    if(clickType[0] == MRect_Type.POND)
      return false;
    if(xPos[0] == -1 || xPos[1] == -1 || yPos[0] == -1 || yPos[1] == -1)
      return false;
    if (abs(xPos[0] - xPos[1]) > 1 || abs(yPos[0] - yPos[1]) > 1)
      return false;
    return true;
  }
  
    boolean isValidBuild(){
    if(clickType[0] == MRect_Type.RED_MANSON && !(xPos[0] == xPos[1] && yPos[0] == yPos[1]) ) 
      return false;
    if(clickType[0] == MRect_Type.GREEN_MANSON)
      return false;
    if(clickType[0] == MRect_Type.GREEN_WALL)
      return false;
    if(clickType[0] == MRect_Type.POND)
      return false;
    if(xPos[0] == -1 || xPos[1] == -1 || yPos[0] == -1 || yPos[1] == -1)
      return false;
    if (abs(xPos[0] - xPos[1]) > 1 || abs(yPos[0] - yPos[1]) > 1)
      return false;
    if (abs(xPos[0] - xPos[1]) > 1 || abs(yPos[0] - yPos[1]) > 1)
      return false;
    if (abs(xPos[0] - xPos[1]) > 1 || abs(yPos[0] - yPos[1]) > 1)
      return false;


    return true;
  }
  
  
  
  Direction_Type check_direction(){
    //NO_DIRECTION, TOP_LEFT, UP_, TOP_RIGHT, RIGHT_, BOTTOM_RIGHT, BOTTOM_, BOTTOM_LEFT, LEFT_ 
    if(xPos[0] < xPos[1] && yPos[0] < yPos[1])
      return Direction_Type.TOP_LEFT;
    else if(xPos[0] == xPos[1] && yPos[0] < yPos[1])
      return Direction_Type.UP_;
    else if(xPos[0] > xPos[1] && yPos[0] < yPos[1])
      return Direction_Type.TOP_RIGHT;
    else if(xPos[0] > xPos[1] && yPos[0] == yPos[1])
      return Direction_Type.RIGHT_;
    else if(xPos[0] > xPos[1] && yPos[0] > yPos[1])
      return Direction_Type.BOTTOM_RIGHT;
    else if(xPos[0] == xPos[1] && yPos[0] > yPos[1])
      return Direction_Type.BOTTOM_;
    else if(xPos[0] < xPos[1] && yPos[0] > yPos[1])
      return Direction_Type.BOTTOM_LEFT;
    else if(xPos[0] < xPos[1] && yPos[0] == yPos[1])
      return Direction_Type.LEFT_;
    else
      return Direction_Type.NO_DIRECTION;
  }
  
}
