void mouse_AI_move(int _ClickX, int _ClickY){

  if (keyPressed && (key == 'z' || key == 'Z')) {
    contest_api.actionPlan[0].target_x = _ClickX;
    contest_api.actionPlan[0].target_y = _ClickY;
  }else if(keyPressed && (key == 'x' || key == 'X')) {
    contest_api.actionPlan[1].target_x = _ClickX;
    contest_api.actionPlan[1].target_y = _ClickY;
  }else if(keyPressed && (key == 'c' || key == 'C') && contest_api.mason_num >= 3) {
    contest_api.actionPlan[2].target_x = _ClickX;
    contest_api.actionPlan[2].target_y = _ClickY;
  }else if(keyPressed && (key == 'v' || key == 'V') && contest_api.mason_num >= 4) {
    contest_api.actionPlan[3].target_x = _ClickX;
    contest_api.actionPlan[3].target_y = _ClickY;
  }else if(keyPressed && (key == 'b' || key == 'B') && contest_api.mason_num >= 5) {
    contest_api.actionPlan[4].target_x = _ClickX;
    contest_api.actionPlan[4].target_y = _ClickY;
  }else if(keyPressed && (key == 'n' || key == 'N') && contest_api.mason_num >= 6) {
    contest_api.actionPlan[5].target_x = _ClickX;
    contest_api.actionPlan[5].target_y = _ClickY;
  }
}

void mouse_AI_build(int _ClickX, int _ClickY){
  if (keyPressed && (key == 'z' || key == 'Z')) {
    contest_api.actionPlan[0].target_x = _ClickX;
    contest_api.actionPlan[0].target_y = _ClickY;
    contest_api.actionPlan[0].clearPlannedWall();
    contest_api.actionPlan[0].setPlannedWall_round(_ClickX,_ClickY);
  }else if(keyPressed && (key == 'x' || key == 'X')) {
    contest_api.actionPlan[1].target_x = _ClickX;
    contest_api.actionPlan[1].target_y = _ClickY;
    contest_api.actionPlan[1].clearPlannedWall();
    contest_api.actionPlan[1].setPlannedWall_round(_ClickX,_ClickY);
  }else if(keyPressed && (key == 'c' || key == 'C') && contest_api.mason_num >= 3) {
    contest_api.actionPlan[2].target_x = _ClickX;
    contest_api.actionPlan[2].target_y = _ClickY;
    contest_api.actionPlan[2].clearPlannedWall();
    contest_api.actionPlan[2].setPlannedWall_round(_ClickX,_ClickY);
  }else if(keyPressed && (key == 'v' || key == 'V') && contest_api.mason_num >= 4) {
    contest_api.actionPlan[3].target_x = _ClickX;
    contest_api.actionPlan[3].target_y = _ClickY;
    contest_api.actionPlan[3].clearPlannedWall();
    contest_api.actionPlan[3].setPlannedWall_round(_ClickX,_ClickY);
  }else if(keyPressed && (key == 'b' || key == 'B') && contest_api.mason_num >= 5) {
    contest_api.actionPlan[4].target_x = _ClickX;
    contest_api.actionPlan[4].target_y = _ClickY;
    contest_api.actionPlan[4].clearPlannedWall();
    contest_api.actionPlan[4].setPlannedWall_round(_ClickX,_ClickY);
  }else if(keyPressed && (key == 'n' || key == 'N') && contest_api.mason_num >= 6) {
    contest_api.actionPlan[5].target_x = _ClickX;
    contest_api.actionPlan[5].target_y = _ClickY;
    contest_api.actionPlan[5].clearPlannedWall();
    contest_api.actionPlan[5].setPlannedWall_round(_ClickX,_ClickY);
  }
  
  
}
