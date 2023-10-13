//This is the function to handle all keyboard input
// KeyPad Move Action assignment
//
//  7 8 9  --> (Up-Left)    (UP)   (Up-Right)  -->  <1> <2> <3>
//  4 5 6  -->  (Left)     (HOLD)   (RIGHT)    -->  <8> <0> <4>
//  1 2 3  --> (DW-Left)   (Down)  (DW-Right)  -->  <7> <6> <5>
//
void keyReleased(){
  //for external keypad
  if(key >= 0xFFFF && keyCode != UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT &&
     ( key == 'z' || key == 'Z' || key == 'x' || key == 'X' || key == 'c' || key == 'C' || key == 'v' || key == 'V' ||
       key == 'b' || key == 'B' || key == 'n' || key == 'N' ) )
    return;
    
  if (key == ENTER || key == RETURN) {
    println("Path searching");
    for(int i=0; i< contest_api.mason_num ; i++)
      aStar(myBoard, contest_api.actionPlan[i]);
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
    int pos_x = contest_api.actionPlan[manson_keyIn].current_x;
    int pos_y = contest_api.actionPlan[manson_keyIn].current_y;
    
    if(keyCode == UP){
      contest_api.actionPlan[manson_keyIn].Direction = 2;
      if(contest_api.WallArray[pos_x][pos_y-1] == Wall_Type.GREEN_WALL){
        contest_api.actionPlan[manson_keyIn].Action = 3;  
        contest_api.actionPlan[manson_keyIn].real_action = "Destroy UP";
        println("Destroy Up!!!!");
      }
      else{
        contest_api.actionPlan[manson_keyIn].Action = 2;
        contest_api.actionPlan[manson_keyIn].real_action = "BUILD UP";
        println("Build Up!!!!");
      }

    }
    else if (keyCode  == DOWN){ 
      
      contest_api.actionPlan[manson_keyIn].Direction = 6;
      if(contest_api.WallArray[pos_x][pos_y+1] == Wall_Type.GREEN_WALL){
        contest_api.actionPlan[manson_keyIn].Action = 3;  
        contest_api.actionPlan[manson_keyIn].real_action = "Destroy DOWN";
        println("Destroy DOWN!!!!");
      }
      else{
        contest_api.actionPlan[manson_keyIn].Action = 2;
        contest_api.actionPlan[manson_keyIn].real_action = "BUILD DOWN";
        println("Build DOWN!!!!");
      }
  
    }
    else if (keyCode  == LEFT){
      contest_api.actionPlan[manson_keyIn].Direction = 8;
      if(contest_api.WallArray[pos_x-1][pos_y] == Wall_Type.GREEN_WALL){
        contest_api.actionPlan[manson_keyIn].Action = 3;  
        contest_api.actionPlan[manson_keyIn].real_action = "Destroy LEFT";
        println("Destroy LEFT!!!!");
      }
      else{
        contest_api.actionPlan[manson_keyIn].Action = 2;
        contest_api.actionPlan[manson_keyIn].real_action = "BUILD LEFT";
        println("Build LEFT!!!!");
      }

    }
    else if (keyCode  == RIGHT){
      contest_api.actionPlan[manson_keyIn].Direction = 4;
      if(contest_api.WallArray[pos_x+1][pos_y] == Wall_Type.GREEN_WALL){
        contest_api.actionPlan[manson_keyIn].Action = 3;  
        contest_api.actionPlan[manson_keyIn].real_action = "Destroy RIGHT";
        println("Destroy RIGHT!!!!");
      }
      else{
        contest_api.actionPlan[manson_keyIn].Action = 2;
        contest_api.actionPlan[manson_keyIn].real_action = "BUILD RIGHT";
        println("Build RIGHT!!!!");
      }
    }
    
    
    
    //////////////////////////////////Move//////////////////////////////////////////
    else if (key  == '1'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 7;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE BOTTOM LEFT";
    }
    else if (key  == '2'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 6;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE DOWN";
    }
    else if (key  == '3'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 5;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE BOTTOM RIGHT";
    }
    else if (key  == '4'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 8;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE LEFT";
    }
    else if (key  == '6'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 4;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE RIGHT";
    }
    else if (key  == '7'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 1;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE TOP LEFT";
    }
    else if (key  == '8'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 2;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE UP";
    }
    else if (key  == '9'){
      contest_api.actionPlan[manson_keyIn].Action = 1;
      contest_api.actionPlan[manson_keyIn].Direction = 3;
      contest_api.actionPlan[manson_keyIn].real_action = "MOVE TOP RIGHT";
    }    
    else if (key == '0' || key == '5'){
      contest_api.actionPlan[manson_keyIn].Action = 0;
      contest_api.actionPlan[manson_keyIn].Direction = 0;
      contest_api.actionPlan[manson_keyIn].real_action = "HOLD";
    }
    myPanel.set_action_label(manson_keyIn, contest_api.actionPlan[manson_keyIn].real_action);
    manson_keyIn++;
  }
}
