int BoxSize = 40;


Board myBoard;
ControlPanel myPanel;
Contest2023_api contest_api;
int current_turn;
int last_turn;
Logic_control game_Logic;
keypad[] inputKey = new keypad[6];


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
  last_turn = -2;
  current_turn = contest_api.match_turns;
  
  //game_Logic = new Logic_control(this);
  
}
 
void draw()
{
  fill(0, 15);
  rect(0,0,width,height);
  myBoard.update();
  contest_api.get_MatchesRequest();
  check_turnUpdate();
  myPanel.set_turns_label(current_turn ,contest_api.total_turns, contest_api.match_isFirst);
  myPanel.set_trunSecond_label(contest_api.match_turnSeconds, contest_api.tooEarly);
}


void check_turnUpdate(){
  current_turn = contest_api.match_turns;
  if(current_turn != last_turn)
  {
    myPanel.reset_trunSecond_label();
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
    
    last_turn = current_turn;
    myBoard.gridUpdated = true;
  }
}
/*
void keyPressed{
  int keyIndex = -1;
  for(int i=0;i<6;i++)
  ///////////////////////////////////Build///////////////////////////////////
  
    if(key == UP){
      inputKey[i].Action = 2;
      inputKey[i].Direction = 2;
      println("Build Up!!!!")
    }
    else if (key  == DOWN){ 
      inputKey[i].Action = 2;
      inputKey[i].Direction = 6;
      println("Build Down!!!!")
    }
    else if (key  == LEFT){
      inputKey[i].Action = 2;
      inputKey[i].Direction = 8;
      
    }
    else if (key  == RIGHT){
      inputKey[i].Action = 2;
      inputKey[i].Direction = 4;
    }
    //////////////////////////////////Move//////////////////////////////////////////
    else if (key  == 1){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 7;
    }
    else if (key  == 2){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 6;
    }
    else if (key  == 3){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 5;
    }
    else if (key  == 4){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 8;
    }
    else if (key  == 6){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 4;
    }
    else if (key  == 7){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 1;
    }
    else if (key  == 8){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 2;
    }
    else if (key  == 9){
      inputKey[i].Action = 1;
      inputKey[i].Direction = 3;
    }    
    else{
      inputKey[i].Action = 0;
      inputKey[i].Direction = 0;
    
    }
  

}*/
