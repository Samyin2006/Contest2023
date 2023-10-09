//This is the function to handle all keyboard input
// KeyPad Move Action assignment
//
//  7 8 9  --> (Up-Left)    (UP)   (Up-Right)  -->  <1> <2> <3>
//  4 5 6  -->  (Left)     (HOLD)   (RIGHT)    -->  <8> <0> <4>
//  1 2 3  --> (DW-Left)   (Down)  (DW-Right)  -->  <7> <6> <5>
//
void keyReleased(){
  //for external keypad
  if(key >= 0xFFFF && keyCode != UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT )
    return;
    
  if (key == ENTER || key == RETURN) {
    println("Path searching");
    aStar(myBoard, myBoard.r[contest_api.MansonPos[0].xPos][contest_api.MansonPos[0].yPos], myBoard.r[contest_api.map_width-1][contest_api.map_height-1]);
    return;
  }
  
  
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
