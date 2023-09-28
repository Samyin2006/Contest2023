class ControlPanel{
  PApplet my_applet;
  ControlP5 controlPanel_CP5;
  ControlTimer timer;
  controlP5.Label postbutton;
  Textlabel trunSecond_label;
  Textlabel turns_label;
  
  PFont font;
  int button_height;
  int button_width;
  int board_height;
  int board_width;

  
  ControlPanel(PApplet _applet, int _board_width, int _board_height ,int _BoxSize){
    my_applet = _applet;
    BoxSize = _BoxSize;
    button_height = BoxSize;
    button_width = BoxSize * 3;
    board_height = _board_height;
    board_width = _board_width;
    
    controlPanel_CP5 = new ControlP5(my_applet);
    timer = new ControlTimer();
    timer.setSpeedOfTime(1);
    font = createFont("Arial",24);
    
    
    turns_label = controlPanel_CP5.addTextlabel("turns_label")
                                  .setText("00 / 00")
                                  .setPosition((board_width+3)*BoxSize, BoxSize*1)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",40))
                                  ;
    
    trunSecond_label = controlPanel_CP5.addTextlabel("turnsSecond_label")
                                  .setText("0.0 sec / 0.0 sec")
                                  .setPosition((board_width+3)*BoxSize, BoxSize*2)
                                  .setColorValue(0xffffffff)
                                  .setFont(createFont("Arial",26))
                                  ;
    
    postbutton = controlPanel_CP5.addButton( "POST" ) //Create button with ID
                             .plugTo(this, "post_btn_click")                      //Link this button event to "btn_click" function
                             .setLock(false)
                             .setPosition((board_width+3)*BoxSize, (board_height)*BoxSize)              //Button position
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
  
  void set_turns_label( int _currentTurn, int _total_turns , boolean _isFirst ){
    turns_label.setText( str(_currentTurn) + "/" + str(_total_turns) );
    if(_isFirst){
      if(_currentTurn%2 == 0)
        turns_label.setColor(color(255, 0, 0));
      else
        turns_label.setColor(color(0, 255, 0));
    }
    else
    {
      if(_currentTurn%2 == 0)
        turns_label.setColor(color(0, 255, 0));
      else
        turns_label.setColor(color(255, 0, 0));
    }
      
  }
  
  void set_trunSecond_label( int _turn_time, boolean _TooEarly){
    
    timer.update(); 
    int currentSecond = _turn_time - timer.second();
    
    if(_TooEarly){
      trunSecond_label.setText( "READY\nTurn time = " + str(_turn_time) + "s");
    }
    else
      trunSecond_label.setText( str( currentSecond ) + " sec / " + str(_turn_time) + " sec");
  }
  
  void reset_trunSecond_label( ){
    timer.reset();
  }
  
  
  
  
  
  
  
  
}
