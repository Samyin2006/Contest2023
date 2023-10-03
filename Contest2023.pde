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
  contest_api.get_initMatchesRequest();
  BoxSize = (displayHeight) / (contest_api.map_height+2);
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
    
    myPanel.reset_trunSecond_label();
    if(myPanel.my_turn == true){
      manson_keyIn = 0;
      myPanel.clear_action_label(contest_api.mason_num);
      contest_api.clearActionsArray();
    }
    last_turn = current_turn;
    myBoard.gridUpdated = true;
  }
}

void keyReleased(){
  if(key >= 0xFFFF)
    return;
  
  // Space key clear all pressed action
  if(key == ' '){
    manson_keyIn = 0;
    myPanel.clear_action_label(contest_api.mason_num);
    contest_api.clearActionsArray();
    return;
  }
 
  //////////////////////////////////Build/Destory//////////////////////////////////////////
  if(manson_keyIn < contest_api.mason_num){
    if(keyCode == UP){
      actionPlan[manson_keyIn].Action = 2;
      actionPlan[manson_keyIn].Direction = 2;
      println("Build Up!!!!");
    }
    else if (keyCode  == DOWN){ 
      actionPlan[manson_keyIn].Action = 2;
      actionPlan[manson_keyIn].Direction = 6;
      println("Build Down!!!!");
    }
    else if (keyCode  == LEFT){
      actionPlan[manson_keyIn].Action = 2;
      actionPlan[manson_keyIn].Direction = 8;
      println("Build Left!!!!");
    }
    else if (keyCode  == RIGHT){
      actionPlan[manson_keyIn].Action = 2;
      actionPlan[manson_keyIn].Direction = 4;
      println("Build Right!!!!");
    }
    //////////////////////////////////Move//////////////////////////////////////////
    else if (key  == '1'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 7;
    }
    else if (key  == '2'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 6;
    }
    else if (key  == '3'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 5;
    }
    else if (key  == '4'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 8;
    }
    else if (key  == '6'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 4;
    }
    else if (key  == '7'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 1;
    }
    else if (key  == '8'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 2;
    }
    else if (key  == '9'){
      actionPlan[manson_keyIn].Action = 1;
      actionPlan[manson_keyIn].Direction = 3;
    }    
    else if (key == '0'){
      actionPlan[manson_keyIn].Action = 0;
      actionPlan[manson_keyIn].Direction = 0;
    }
    myPanel.set_action_label(manson_keyIn, actionPlan[manson_keyIn].Action, actionPlan[manson_keyIn].Direction);
    contest_api.appendActionsArray(actionPlan[manson_keyIn].Action, actionPlan[manson_keyIn].Direction);
    manson_keyIn++;
  }
}
