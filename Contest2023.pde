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
  
  //Box size base on map longer side.  
  if(contest_api.map_height >= contest_api.map_width){
    BoxSize = (displayHeight) / (contest_api.map_height+2);
  }
  else{
    BoxSize = (displayWidth - 300) / (contest_api.map_width+2);
  }
  
  myBoard = new Board(this, contest_api.map_width, contest_api.map_height, BoxSize);
  //size(myBoard.width(), myBoard.height());
  fullScreen();
  
  println("screen size = " + displayWidth + " x " + displayHeight );
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
  if(current_turn != last_turn)    //Check turn change
  {
    println("======================> current_turn = " + str(current_turn));
    
    //Layer 1 Display structure on board
    for(int i=0; i<contest_api.map_width; i++){
      for(int j=0; j<contest_api.map_height; j++){
          if(contest_api.StructuresArray[i][j] == Structure_Type.FREESPACE){
            if(contest_api.TerritoriesArray[i][j] == Territories_Type.RED_TERRITORIES )
              myBoard.gridType[i][j] = MRect_Type.RED_TERRITORIES;
            else if(contest_api.TerritoriesArray[i][j] == Territories_Type.GREEN_TERRITORIES )
              myBoard.gridType[i][j] = MRect_Type.GREEN_TERRITORIES;
            else
              myBoard.gridType[i][j] = MRect_Type.FREESPACE;
          }
          else if(contest_api.StructuresArray[i][j] == Structure_Type.POND)
            myBoard.gridType[i][j] = MRect_Type.POND;
          else if(contest_api.StructuresArray[i][j] == Structure_Type.CASTLE)
            myBoard.gridType[i][j] = MRect_Type.CASTLE;
        }
    }
    
    //Layer 2 Display Wall on board (Cover POND / FREESPACE)
    for(int i=0; i<contest_api.map_width; i++){
      for(int j=0; j<contest_api.map_height; j++){
          if(contest_api.WallArray[i][j] == Wall_Type.RED_WALL){
            if(contest_api.StructuresArray[i][j] == Structure_Type.POND)
              myBoard.gridType[i][j] = MRect_Type.RED_WALL_POND;
            else
              myBoard.gridType[i][j] = MRect_Type.RED_WALL;
          }
          else if(contest_api.WallArray[i][j] == Wall_Type.GREEN_WALL)
            myBoard.gridType[i][j] = MRect_Type.GREEN_WALL;
        }
    }
    
    //Layer 3 Display Manson on board (Cover Wall, Freespace, Walls)
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
    
    myPanel.reset_trunSecond_label();            // Reset Timer 
    for(int i=0; i<contest_api.mason_num; i++)   // Display Manson location
      myPanel.set_manson_pos_label(i, contest_api.MansonPos[i].xPos, contest_api.MansonPos[i].yPos);    
    
    if(myPanel.my_turn == true)                  // Clear Manson Action Plan
      clearAllActions();
    myPanel.bouns_Count();
    last_turn = current_turn;
    myBoard.gridUpdated = true;                  // Update grid display
  }
}

void clearAllActions(){
  manson_keyIn = 0;
  myPanel.clear_action_label(contest_api.mason_num);
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
