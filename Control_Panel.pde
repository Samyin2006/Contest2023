class ControlPanel{
  PApplet my_applet;
  ControlP5 controlPanel_CP5;
  ControlTimer timer;
  controlP5.Label postbutton;
  Textlabel trunSecond_label;
  Textlabel turns_label;
  Textlabel bonus, allies_count, opponent_count;
  Textlabel match_id, opponent_name ;
  Textlabel[] action_label = new Textlabel[6];
  Textlabel[] mansonPos_label = new Textlabel[6];
  
  PFont font;
  int button_height;
  int button_width;
  int board_height;
  int board_width;
  int remainMillisSec;
  boolean my_turn;

  
  ControlPanel(PApplet _applet, int _board_width, int _board_height ,int _BoxSize){
    my_applet = _applet;
    BoxSize = _BoxSize;
    button_height = BoxSize;
    button_width = BoxSize * 3;
    board_height = _board_height;
    board_width = _board_width;
    my_turn = false;
    
    controlPanel_CP5 = new ControlP5(my_applet);
    timer = new ControlTimer();
    timer.setSpeedOfTime(1);
    font = createFont("Arial",24);
    
    
    
    turns_label = controlPanel_CP5.addTextlabel("turns_label")
                                  .setText("00 / 00")
                                  .setPosition(displayWidth-controlPanel_width, 20)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",70))
                                  ;
    
    trunSecond_label = controlPanel_CP5.addTextlabel("turnsSecond_label")
                                  .setText("0.0 sec / 0.0 sec")
                                  .setPosition(displayWidth-controlPanel_width, 100)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",40))
                                  ;

    match_id = controlPanel_CP5.addTextlabel("match_id")
                              .setText("ID: " + contest_api.match_id)
                              .setPosition(displayWidth-controlPanel_width , 150)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",40))
                              ;

    for(int i=0; i<6 ;i++){
      action_label[i] = controlPanel_CP5.addTextlabel("action_label" + str(i))
                                    .setText("")
                                    .setPosition(displayWidth-controlPanel_width, (250+i*50))
                                    .setColorValue(0xffffffff)
                                    .setFont(createFont("Arial",40))
                                    ;
      
      mansonPos_label[i] = controlPanel_CP5.addTextlabel("mansonPos_label" + str(i))
                                    .setText("")
                                    .setPosition(displayWidth-controlPanel_width-100, (250+i*50))
                                    .setColorValue(0xffffffff)
                                    .setFont(createFont("Arial",40))
                                    .setVisible(false);
                                    ;
      
    }
    
    opponent_count = controlPanel_CP5.addTextlabel("opponent_count")
                              .setText("" + str(contest_api.wall_count(Wall_Type.GREEN_WALL)) + "\n"
                                          + str(contest_api.Territories_count(Territories_Type.GREEN_TERRITORIES)) + "\n"
                                          + str(contest_api.castle_count(Territories_Type.GREEN_TERRITORIES)) )
                              .setPosition(displayWidth-controlPanel_width+300 , displayHeight-400)
                              .setColorValue(color(0, 255, 0))
                              .setFont(createFont("Courier New",40))
                              ;
                              
    allies_count = controlPanel_CP5.addTextlabel("allies_count")
                              .setText("" + str(contest_api.wall_count(Wall_Type.RED_WALL)) + "\n"
                                          + str(contest_api.Territories_count(Territories_Type.RED_TERRITORIES)) + "\n"
                                          + str(contest_api.castle_count(Territories_Type.RED_TERRITORIES)) )
                              .setPosition(displayWidth-controlPanel_width+200 , displayHeight-400)
                              .setColorValue(color(255, 0, 0))
                              .setFont(createFont("Courier New",40))
                              ;
    
    bonus = controlPanel_CP5.addTextlabel("bonus")
                              .setText(   "W: " + contest_api.wallBonus + "\n"
                                        + "T: " + contest_api.territoryBonus +"\n"
                                        + "C: " + contest_api.castleBonus) 
                              .setPosition(displayWidth-controlPanel_width , displayHeight-400)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Courier New",40))
                              ;


    
    postbutton = controlPanel_CP5.addButton( "POST" ) //Create button with ID
                             .plugTo(this, "post_btn_click")                      //Link this button event to "btn_click" function
                             .setLock(false)
                             .setPosition(displayWidth-controlPanel_width, displayHeight-80)              //Button position
                             .setSize(250, 50)           //Button size
                             .setFont(font)                                  //Set font type and size
                             .getCaptionLabel()
                             .align(ControlP5.CENTER, ControlP5.CENTER)
                             .setVisible(true) //Set Label align and invisible
                             ;
  }
  
  void post_btn_click() {   
      println(" -----POST_btn: ");
      contest_api.post_MatchesRequest();
  }
  
  void set_action_label(int mansionIndex, String real_action){
    action_label[mansionIndex].setText( str(mansionIndex+1) + ": " + real_action );
  }
  
  void set_all_action_label(){
    for(int i=0; i<contest_api.mason_num; i++)
      action_label[i].setText( str(i+1) + ": " + contest_api.actionPlan[i].real_action );
  }
  
  void set_manson_pos_label(int mansionIndex, int _x, int _y){
    mansonPos_label[mansionIndex].setText( "[" + str(_x) + "," + str(_y) + "]");
  }
  
  void clear_action_label(int manson_num){
    for(int i=0; i<manson_num; i++){
      action_label[i].setText(str(i+1) + ":");
    }
  }
  
  void clear_one_action(int manson_num){
    if(manson_num <  contest_api.mason_num){
      action_label[manson_num].setText(str(manson_num+1) + ":");
    }
  }
  
  void bouns_Count(){
    opponent_count.setText("" + str(contest_api.wall_count(Wall_Type.GREEN_WALL)) + "\n"
                              + str(contest_api.Territories_count(Territories_Type.GREEN_TERRITORIES)) + "\n"
                              + str(contest_api.castle_count(Territories_Type.GREEN_TERRITORIES)) );
    
    allies_count.setText("" + str(contest_api.wall_count(Wall_Type.RED_WALL)) + "\n"
                            + str(contest_api.Territories_count(Territories_Type.RED_TERRITORIES)) + "\n"
                            + str(contest_api.castle_count(Territories_Type.RED_TERRITORIES)) );
  }
  
  
  
  
  void set_turns_label( int _currentTurn, int _total_turns , boolean _isFirst ){
    if(_currentTurn < 0){
      if(_isFirst){
        turns_label.setColor(color(255, 0, 0));
        turns_label.setFont(createFont("Arial",30));
        turns_label.setText( "First Hand\n    READY" );
      }
      else{
        turns_label.setColor(color(0, 255, 0));
        turns_label.setFont(createFont("Arial",30));
        turns_label.setText( "Second Hand\n    READY" );
      }
    }
    else{
      turns_label.setText( str(_currentTurn) + "/" + str(_total_turns) );
      if(_isFirst){
        if(_currentTurn%2 == 0){
          turns_label.setColor(color(255, 0, 0));
          turns_label.setFont(createFont("Arial",70));
          my_turn = true;
        }
        else{
          turns_label.setColor(color(0, 255, 0));
          turns_label.setFont(createFont("Arial",70));
          my_turn = false;
        }
      }
      else
      {
        if(_currentTurn%2 == 0){
          turns_label.setColor(color(0, 255, 0));
          turns_label.setFont(createFont("Arial",70));
          my_turn = false;
        }
        else{
          turns_label.setColor(color(255, 0, 0));
          turns_label.setFont(createFont("Arial",70));
          my_turn = true;
        }
      }
    }
      
  }
  
  void set_trunSecond_label( int _turn_time, boolean _TooEarly){
    
    timer.update(); 
    int currentSecond = _turn_time - timer.second();
    remainMillisSec = _turn_time * 1000 - timer.millis() - timer.second()*1000;
    
    if(_TooEarly){
      trunSecond_label.setText( "Turn time = " + str(_turn_time) + "s");
    }
    else
      trunSecond_label.setText( str( currentSecond ) + " sec / " + str(_turn_time) + " sec");

  }
  
  int get_currentSecond(){
    return remainMillisSec;
  }
  
  void reset_trunSecond_label( ){
    timer.reset();
  }
  
  
  
  
  
  
  
  
}
