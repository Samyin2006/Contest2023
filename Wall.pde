enum Wall_Type { 
  NO_WALL,
  RED_WALL, 
  GREEN_WALL;
  
  int getValue()
  {
    if (this == NO_WALL)
      return 0;
    else if (this == RED_WALL)
      return 1;
    else if (this == GREEN_WALL)
      return 2;
    else
      return -1;
  }
}  

class Wall{
  
}
