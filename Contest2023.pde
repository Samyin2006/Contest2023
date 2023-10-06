int BoxSize = 40;

Board myBoard;
ControlPanel myPanel;
Contest2023_api contest_api;
int current_turn;
int last_turn;
int manson_keyIn;
MansonPlan[] actionPlan = new MansonPlan[6];


void settings()
{
  contest_api = new Contest2023_api();
  while( !contest_api.get_initMatchesRequest() )
    delay(100);
  

  if(BoxSize * contest_api.map_height > 700){
    BoxSize = 700 / (contest_api.map_height+2);
  }
  else{
    BoxSize = (displayHeight) / (contest_api.map_height+2);
  }
  
  
  
  myBoard = new Board(this, contest_api.map_width, contest_api.map_height, BoxSize);
  //size(myBoard.width(), myBoard.height());
  fullScreen();
  
  
}
  
void setup()
{
  myBoard.init_board();
  myPanel = new ControlPanel(this, contest_api.map_width, contest_api.map_height, BoxSize);
  for(int i=0; i<contest_api.mason_num; i++){
    actionPlan[i] = new MansonPlan();
  }
  myPanel.clear_action_label(contest_api.mason_num);
  last_turn = -2;
  manson_keyIn = 0;
  current_turn = contest_api.match_turns;
}
 
void draw()
{
  fill(0, 100);
  rect(0,0,width,height);
  myBoard.update();
  contest_api.get_MatchesRequest();
  check_turnUpdate();
  myPanel.set_turns_label(current_turn ,contest_api.total_turns, contest_api.match_isFirst);
  myPanel.set_trunSecond_label(contest_api.match_turnSeconds, contest_api.tooEarly);
  if(myPanel.get_currentSecond() < 500 && myPanel.my_turn == true)
    contest_api.post_MatchesRequest();
}


void check_turnUpdate(){
  current_turn = contest_api.match_turns;
  if(current_turn != last_turn)
  {
    println("======================> current_turn = " + str(current_turn));
    for(int i=0; i<contest_api.map_width; i++){
      for(int j=0; j<contest_api.map_height; j++){
          if(contest_api.StructuresArray[i][j] == Structure_Type.FREESPACE)
            myBoard.gridType[i][j] = MRect_Type.FREESPACE;
          else if(contest_api.StructuresArray[i][j] == Structure_Type.POND)
            myBoard.gridType[i][j] = MRect_Type.POND;
          else if(contest_api.StructuresArray[i][j] == Structure_Type.CASTLE)
            myBoard.gridType[i][j] = MRect_Type.CASTLE;
        }
    }
    
    for(int i=0; i<contest_api.map_width; i++){
      for(int j=0; j<contest_api.map_height; j++){
          if(contest_api.WallArray[i][j] == Wall_Type.RED_WALL)
            myBoard.gridType[i][j] = MRect_Type.RED_WALL;
          else if(contest_api.WallArray[i][j] == Wall_Type.GREEN_WALL)
            myBoard.gridType[i][j] = MRect_Type.GREEN_WALL;
        }
    }
    
    for(int i=0; i<contest_api.map_width; i++){
      for(int j=0; j<contest_api.map_height; j++){
        if(contest_api.MansonArray[i][j].manson_ID > 0){
          myBoard.gridType[i][j] = MRect_Type.RED_MANSON;
          myBoard.r[i][j].setCaptionLabel(str(contest_api.MansonArray[i][j].manson_ID));
        }
        else if(contest_api.MansonArray[i][j].manson_ID < 0){
          myBoard.gridType[i][j] = MRect_Type.GREEN_MANSON;
          myBoard.r[i][j].setCaptionLabel(str(contest_api.MansonArray[i][j].manson_ID));
        }
      }
    }
    
    myPanel.reset_trunSecond_label();             // Reset Timer 
    for(int i=0; i<contest_api.mason_num; i++)    // Display Manson location
      myPanel.set_manson_pos_label(i, contest_api.MansonPos[i].xPos, contest_api.MansonPos[i].yPos);    
    
    if(myPanel.my_turn == true){                  // Clear Manson Action Plan
      manson_keyIn = 0;
      myPanel.clear_action_label(contest_api.mason_num);
      clearAllActions();
    }
    last_turn = current_turn;
    myBoard.gridUpdated = true;                    // Update grid display
  }
}


 
 
 
void clearAllActions(){
  for(int i=0; i<contest_api.mason_num; i++){
    actionPlan[i].Action = 0;
    actionPlan[i].Direction = 0;
  }
}

void clearMansonActions(int _mansonID){
  if( _mansonID+1 < contest_api.mason_num){
    actionPlan[_mansonID-1].Action = 0;
    actionPlan[_mansonID-1].Direction = 0;
  }
}

void keyReleased(){
  //for external keypad
  if(key >= 0xFFFF && keyCode != UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT )
    return;
    
  
  // Space key clear all pressed action
  if(key == ' '){
    manson_keyIn = 0;
    myPanel.clear_action_label(contest_api.mason_num);
    clearAllActions();
    return;
  }
  //Clear one action by pressing Q,W,E,R,T,Y seperately
  if(key == 'Q' || key == 'q'){
    manson_keyIn = 0;
    myPanel.clear_one_action(0);
    clearMansonActions(1);
    return;
  }
  else if(key == 'W' || key == 'w'){
    manson_keyIn = 1;
    myPanel.clear_one_action(1);
    clearMansonActions(2);
    return;
  } 
  else if(key == 'E' || key == 'e'){
    manson_keyIn = 2;
    myPanel.clear_one_action(2);
    clearMansonActions(3);
    return;
  } 
  else if(key == 'R' || key == 'r'){
    manson_keyIn = 3;
    myPanel.clear_one_action(3);
    clearMansonActions(4);
    return;
  } 
  else if(key == 'T' || key == 't'){
    manson_keyIn = 4;
    myPanel.clear_one_action(4);
    clearMansonActions(5);
    return;
  } 
  else if(key == 'Y' || key == 'y'){
    manson_keyIn = 5;
    myPanel.clear_one_action(5);
    clearMansonActions(6);
    return;
  }
  
  //////////////////////////////////Build/Destory//////////////////////////////////////////
  if(manson_keyIn < contest_api.mason_num){
    int pos_x = contest_api.MansonPos[manson_keyIn].xPos;
    int pos_y = contest_api.MansonPos[manson_keyIn].yPos;
    
    if(keyCode == UP){
      actionPlan[manson_keyIn].Direction = 2;
      if(contest_api.WallArray[pos_x][pos_y-1] == Wall_Type.GREEN_WALL){
        actionPlan[manson_keyIn].Action = 3;  
        actionPlan[manson_keyIn].real_action = "Destroy UP";
        println("Destroy Up!!!!");
      }
      else{
        actionPlan[manson_keyIn].Action = 2;
        actionPlan[manson_keyIn].real_action = "BUILD UP";
        println("Build Up!!!!");
      }

    }
    else if (keyCode  == DOWN){ 
      
      actionPlan[manson_keyIn].Direction = 6;
      if(contest_api.WallArray[pos_x][pos_y+1] == Wall_Type.GREEN_WALL){
        actionPlan[manson_keyIn].Action = 3;  
        actionPlan[manson_keyIn].real_action = "Destroy DOWN";
        println("Destroy DOWN!!!!");
      }
      else{
        actionPlan[manson_keyIn].Action = 2;
        actionPlan[manson_keyIn].real_action = "BUILD DOWN";
        println("Build DOWN!!!!");
      }
  
    }
    else if (keyCode  == LEFT){
      actionPlan[manson_keyIn].Direction = 8;
      if(contest_api.WallArray[pos_x-1][pos_y] == Wall_Type.GREEN_WALL){
        actionPlan[manson_keyIn].Action = 3;  
        actionPlan[manson_keyIn].real_action = "Destroy LEFT";
        println("Destroy LEFT!!!!");
      }
      else{
        actionPlan[manson_keyIn].Action = 2;
        actionPlan[manson_keyIn].real_action = "BUILD LEFT";
        println("Build LEFT!!!!");
      }

    }
    else if (keyCode  == RIGHT){
      actionPlan[manson_keyIn].Direction = 4;
      if(contest_api.WallArray[pos_x-1][pos_y] == Wall_Type.GREEN_WALL){
        actionPlan[manson_keyIn].Action = 3;  
        actionPlan[manson_keyIn].real_action = "Destroy RIGHT";
        println("Destroy RIGHT!!!!");
      }
      else{
        actionPlan[manson_keyIn].Action = 2;
        actionPlan[manson_keyIn].real_action = "BUILD RIGHT";
        println("Build RIGHT!!!!");
      }
    }
    
    
    
    //////////////////////////////////Move//////////////////////////////////////////
    else if (key  == '1'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 7;
      actionPlan[manson_keyIn].real_action = "MOVE BOTTOM LEFT";
    }
    else if (key  == '2'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 6;
      actionPlan[manson_keyIn].real_action = "MOVE DOWN";
    }
    else if (key  == '3'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 5;
      actionPlan[manson_keyIn].real_action = "MOVE BOTTOM RIGHT";
    }
    else if (key  == '4'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 8;
      actionPlan[manson_keyIn].real_action = "MOVE LEFT";
    }
    else if (key  == '6'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 4;
      actionPlan[manson_keyIn].real_action = "MOVE RIGHT";
    }
    else if (key  == '7'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 1;
      actionPlan[manson_keyIn].real_action = "MOVE TOP LEFT";
    }
    else if (key  == '8'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 2;
      actionPlan[manson_keyIn].real_action = "MOVE UP";
    }
    else if (key  == '9'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 3;
      actionPlan[manson_keyIn].real_action = "MOVE TOP RIGHT";
    }    
    else if (key == '0' || key == '5'){
      actionPlan[manson_keyIn].Action = 0;
      actionPlan[manson_keyIn].Direction = 0;
      actionPlan[manson_keyIn].real_action = "HOLD";
    }
    myPanel.set_action_label(manson_keyIn, actionPlan[manson_keyIn].real_action);
    //myPanel.set_action_label(manson_keyIn, actionPlan[manson_keyIn].Action, actionPlan[manson_keyIn].Direction);
    manson_keyIn++;
  }
}
