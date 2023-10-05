class MansonPlan{
  int Action;
  int Direction;
  String real_action;
  
  //Constructor
  MansonPlan()
  {
    Action = 0;
    Direction = 0;
    real_action = "";
  }
}

enum Action_Type { 
  MANSON_STOP, MANSON_MOVE, MANSON_BUILD, MANSON_DESTORY;
  
  int getValue()
  {
    if (this == MANSON_STOP)
      return 0;
    else if (this == MANSON_MOVE)
      return 1;
    else if (this == MANSON_BUILD)
      return 2;
    else if (this == MANSON_DESTORY)
      return 3;
    else
      return -1;
  }
} 

enum Direction_Type {
  NO_DIRECTION, TOP_LEFT, UP_, TOP_RIGHT, RIGHT_, BOTTOM_RIGHT, BOTTOM_, BOTTOM_LEFT, LEFT_;
  
  int getValue()
  {
    if (this == NO_DIRECTION)
      return 0;
    else if (this == TOP_LEFT)
      return 1;
    else if (this == UP_)
      return 2;
    else if (this == TOP_RIGHT)
      return 3;
    else if (this == RIGHT_)
      return 4;
    else if (this == BOTTOM_RIGHT)
      return 5;
    else if (this == BOTTOM_)
      return 6;
    else if (this == BOTTOM_LEFT)
      return 7;
    else if (this == LEFT_)
      return 8;
    else
      return -1;
  }
  
  String getMoveArrow()
  {
    switch(this)
    {
      case TOP_LEFT:
        return "\u2196";
      case UP_:
        return "\u2191";
      case TOP_RIGHT:
        return "\u2197";
      case RIGHT_:
        return "\u2192";
      case BOTTOM_RIGHT:
        return "\u2198";
      case BOTTOM_:
        return "\u2193";
      case BOTTOM_LEFT:
        return "\u2199"; 
      case LEFT_:
        return "\u2190";
      case NO_DIRECTION:
      default:
        return null;
    }
  }
  
  String getBuildArrow()
  {
    switch(this)
    {
      case UP_:
        return "\u21E7";
      case RIGHT_:
        return "\u21E8";
      case BOTTOM_:
        return "\u21E9";
      case LEFT_:
        return "\u21E6";
      
      case TOP_LEFT:
      case TOP_RIGHT:
      case BOTTOM_RIGHT:
      case BOTTOM_LEFT:
      default:
        println("Invalid MANSON_BUILD direction");
      case NO_DIRECTION:
        return null;
    }
  }
}
