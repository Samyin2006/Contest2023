class ControlPanel{
  PApplet my_applet;
  ControlP5 controlPanel_CP5;
  ControlTimer timer;
  controlP5.Label postbutton;
  Textlabel trunSecond_label;
  Textlabel turns_label;
  Textlabel castle_bonus, wall_bonus, territory_bonus, is_first, mason_num, map_width, map_height;
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
                                  .setPosition(displayWidth-800, 100)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",40))
                                  ;
    
    trunSecond_label = controlPanel_CP5.addTextlabel("turnsSecond_label")
                                  .setText("0.0 sec / 0.0 sec")
                                  .setPosition(displayWidth-400, 100)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",30))
                                  ;

    match_id = controlPanel_CP5.addTextlabel("match_id")
                              .setText("ID: " + contest_api.match_id)
                              .setPosition(displayWidth-800 , 200)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    opponent_name = controlPanel_CP5.addTextlabel("opponent_name")
                              .setText("Opponent: " + contest_api.opponent_name)
                              .setPosition(displayWidth-600 , 200)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    map_width = controlPanel_CP5.addTextlabel("map_width")
                              .setText("Rows: " + contest_api.map_width)
                              .setPosition(displayWidth-800 , 300)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    map_height = controlPanel_CP5.addTextlabel("map_height")
                              .setText("Columns: " + contest_api.map_height)
                              .setPosition(displayWidth-400 , 300)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    is_first = controlPanel_CP5.addTextlabel("is_first")
                              .setText("isFirst: " + contest_api.match_isFirst)
                              .setPosition(displayWidth-800 , 400)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    mason_num = controlPanel_CP5.addTextlabel("mason_num")
                              .setText("Masons: " + contest_api.mason_num)
                              .setPosition(displayWidth-400 , 400)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    castle_bonus = controlPanel_CP5.addTextlabel("castle_bonus")
                              .setText("Castle: " + contest_api.castleBonus)
                              .setPosition(displayWidth-800 , 500)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;

    territory_bonus = controlPanel_CP5.addTextlabel("territory_bonus")
                              .setText("Territory: " + contest_api.territoryBonus)
                              .setPosition(displayWidth-550 , 500)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;


    wall_bonus = controlPanel_CP5.addTextlabel("wall_bonus")
                              .setText("Wall: " + contest_api.wallBonus)
                              .setPosition(displayWidth-300 , 500)
                              .setColorValue(0xffffffff)
                              .setFont(createFont("Arial",30))
                              ;


    
    
    for(int i=0; i<6 ;i++){
      action_label[i] = controlPanel_CP5.addTextlabel("action_label" + str(i))
                                    .setText("")
                                    .setPosition(displayWidth-650, (600+i*100))
                                    .setColorValue(0xffffffff)
                                    .setFont(createFont("Arial",30))
                                    ;
      
      mansonPos_label[i] = controlPanel_CP5.addTextlabel("mansonPos_label" + str(i))
                                    .setText("")
                                    .setPosition(displayWidth-800, (600+i*100))
                                    .setColorValue(0xffffffff)
                                    .setFont(createFont("Arial",30))
                                    ;
      
    }
    
    postbutton = controlPanel_CP5.addButton( "POST" ) //Create button with ID
                             .plugTo(this, "post_btn_click")                      //Link this button event to "btn_click" function
                             .setLock(false)
                             .setPosition(displayWidth-800, displayHeight-200)              //Button position
                             .setSize(button_width, button_height)           //Button size
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
  
  void set_manson_pos_label(int mansionIndex, int _x, int _y){
    mansonPos_label[mansionIndex].setText( "[" + str(_x) + "," + str(_y) + "]");
  }
  
  //void set_action_label(int mansionIndex, int action, int direction){
  //  action_label[mansionIndex].setText( str(mansionIndex) + ": " + str(action) + " , " + str(direction) );
  //}
  
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
  
  
  
  
  
  
  void set_turns_label( int _currentTurn, int _total_turns , boolean _isFirst ){
    if(_currentTurn < 0){
      if(_isFirst){
        turns_label.setColor(color(255, 0, 0));
        turns_label.setText( "First Hand" );
      }
      else{
        turns_label.setColor(color(0, 255, 0));
        turns_label.setText( "Second Hand" );
      }
    }
    else{
      turns_label.setText( str(_currentTurn) + "/" + str(_total_turns) );
      if(_isFirst){
        if(_currentTurn%2 == 0){
          turns_label.setColor(color(255, 0, 0));
          my_turn = true;
        }
        else{
          turns_label.setColor(color(0, 255, 0));
          my_turn = false;
        }
      }
      else
      {
        if(_currentTurn%2 == 0){
          turns_label.setColor(color(0, 255, 0));
          my_turn = false;
        }
        else{
          turns_label.setColor(color(255, 0, 0));
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
      trunSecond_label.setText( "READY\nTurn time = " + str(_turn_time) + "s");
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
