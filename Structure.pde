
enum Structure_Type {
  FREESPACE, POND, CASTLE;
  
  int getValue()
  {
    if (this == FREESPACE)
      return 0;
    else if (this == POND)
      return 1;
    else if (this == CASTLE)
      return 2;
    else
      return -1;
  }
}

class Structure {
  
  
}
