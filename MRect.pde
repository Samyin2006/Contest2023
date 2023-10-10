enum MRect_Type {
  FREESPACE, POND, CASTLE, RED_MANSON, GREEN_MANSON, RED_WALL, RED_WALL_POND, GREEN_WALL, RED_TERRITORIES, GREEN_TERRITORIES, NULL;
}

import controlP5.*;
class MRect {
  public ControlP5 myCP5;
  PApplet my_applet;
  int xPos; // rect x_position
  int yPos ; // rect y_position
  int sq_size;
  int space;
  int index_x;
  int index_y;
  controlP5.Label button;
  PFont font;
  MRect_Type rect_type;
  
  //Constructor
  MRect(PApplet _applet, int X, int Y, int size, int _space, int _ID_X, int _ID_Y, MRect_Type _type) {
    my_applet = _applet;
    xPos = X;
    yPos = Y;
    sq_size = size;
    space = _space;
    index_x = _ID_X;
    index_y = _ID_Y;
    rect_type = _type;

    myCP5 = new ControlP5(my_applet);
    font = createFont("Courier New",sq_size/3);
     
    button = myCP5.addButton( str(index_x) + "," + str(index_y) ) //Create button with ID
                  .plugTo(this, "btn_click")                      //Link this button event to "btn_click" function
                  .setLock(false)
                  .setPosition(xPos+space, yPos+space)            //Button position
                  .setSize(sq_size-space, sq_size-space)          //Button size
                  .setFont(font)                                  //Set font type and size
                  .getCaptionLabel()
                  .align(ControlP5.CENTER, ControlP5.CENTER)
                  .setVisible(false) //Set Label align and invisible
                  ;
    
    this.setMRect_Type(rect_type);
  }
  
  void setMRect_Type(MRect_Type _setType){
    rect_type = _setType;
    CColor[] MRect_Color = new CColor[9];
    //Prepare the button color
    //A CColor instance contains the colors of foreground-, background-, active-, captionlabel- and valuelabel-colors. 
    //Reference: https://sojamo.de/libraries/controlP5/reference/controlP5/CColor.html
    //FREESPACE, POND, CASTLE, RED_MANSON, GREEN_MANSON, RED_WALL, GREEN_WALL
    MRect_Color[0] = new CColor(color(200), color(130), color(70), color(255), color(0,255,0));                         //FreeSpace
    MRect_Color[1] = new CColor(color(128, 159, 255), color(51, 102, 255), color(0,0,102), color(255), color(0,255,0)); //POND
    MRect_Color[2] = new CColor(color(221, 204, 255), color(153, 51, 255), color(102, 0, 204), color(255), color(255)); //Castle
    MRect_Color[3] = new CColor(color(255, 153, 204), color(255, 0, 102), color(153, 51, 102), color(255), color(255)); //RED Menson
    MRect_Color[4] = new CColor(color(96,255,96), color(51, 255, 87), color(96,255,96), color(0), color(0));            //Green Manson
    MRect_Color[5] = new CColor(color(204,0,0), color(128, 0, 0), color(80, 0, 0), color(255), color(0,255,0));         //Red wall
    MRect_Color[6] = new CColor(color(51, 204, 51), color(0, 153, 51), color(0, 102, 0), color(255), color(255));       //Green Wall
    MRect_Color[7] = new CColor(color(200), color(255,204,229), color(70), color(255), color(0,255,0));       //Red Territory
    MRect_Color[8] = new CColor(color(200), color(229, 255, 204), color(70), color(255), color(0,255,0));       //Green Territory
    
    
    switch(rect_type){
      case POND:
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[1]);
        break;
      case CASTLE:
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[2]);
        font = createFont("Courier New",sq_size/4);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setCaptionLabel("Castle");
        myCP5.getController(str(index_x) + "," + str(index_y)).getCaptionLabel().setVisible(true);
        break;
      case RED_MANSON:  
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[3]);
        break;
      case GREEN_MANSON:
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[4]);
        break;
      case RED_WALL:
        font = createFont("Courier New",8);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[5]);
        break;
      case RED_WALL_POND:  
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[5]);
        font = createFont("Courier New",40);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setCaptionLabel("P");
        myCP5.getController(str(index_x) + "," + str(index_y)).getCaptionLabel().setVisible(true);
        break;
      case GREEN_WALL:
        font = createFont("Courier New",8);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[6]);
        break;
      case RED_TERRITORIES:
        font = createFont("Courier New",8);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[7]);
        break;
      case GREEN_TERRITORIES:
        font = createFont("Courier New",8);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[8]);
        break;
      case FREESPACE:
      default:
        font = createFont("Courier New",8);
        myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
        myCP5.getController(str(index_x) + "," + str(index_y)).setColor(MRect_Color[0]);
        break;
    }
    
  }
  
  
  void setCaptionLabel(String str){
    if(str.length() < 4)
      font = createFont("Arial",sq_size/1.5,true);
    else
      font = createFont("Courier New",sq_size/2);
    myCP5.getController(str(index_x) + "," + str(index_y)).setFont(font);
    myCP5.getController(str(index_x) + "," + str(index_y)).setCaptionLabel(str);
    myCP5.getController(str(index_x) + "," + str(index_y)).getCaptionLabel().setVisible(true);
  }
  
  
  
  void btn_click() {
    
    if (mouseButton == RIGHT)
    {
      println(" -----btn_click: " + str(index_x) + "," + str(index_y) + " <Right-click>");
    }
    else
    {
      mouse_Record(index_x, index_y);
      println(" -----btn_click: " + str(index_x) + "," + str(index_y));
    }
     
  }
  
}
