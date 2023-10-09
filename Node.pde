import java.util.PriorityQueue;
import java.util.LinkedList;

class Node implements Comparable<Node> {
  int x, y;
  int distance;
  Node parent;

  Node(int x, int y, int distance, Node parent) {
    this.x = x;
    this.y = y;
    this.distance = distance;
    this.parent = parent;
  }

  public int compareTo(Node other) {
    return Integer.compare(this.distance, other.distance);
  }
}

void aStar(Board _maze, MRect _start, MRect _end) {
  PriorityQueue<Node> queue = new PriorityQueue<>();
  queue.add(new Node(_start.index_x, _start.index_y, 0, null));    //Starting Point
  
  println("aStar perform (size) = " + _maze.numOfHorizontal + "x" + _maze.numOfVertical );
  println("aStar perform (start) = " + _start.index_x + "," + _start.index_y );
  println("aStar perform (start) = " + _end.index_x + "," + _end.index_y );
  
  boolean[][] visited = new boolean[_maze.numOfHorizontal][_maze.numOfVertical];
  
  int[][] dirs = {{-1, -1}, { 0, -1}, { 1, -1}, 
                  {-1,  0},           { 1,  0}, 
                  {-1,  1}, { 0,  1}, { 1,  1}}; //Move direction

  while (!queue.isEmpty()) {
    Node current = queue.poll();
    println("aStar Searching...");

    if(visited[current.x][current.y]) {
      println("aStar Searching...[visited]");
      continue;
    }

    visited[current.x][current.y] = true;

    if (current.x == _end.index_x && current.y == _end.index_y) {
      println("aStar end Searching...");
      printPath(current);
      return;
    }

    for (int i = 0; i < 8; i++) {
      
      int newX = current.x + dirs[i][0];
      int newY = current.y + dirs[i][1]; 
      
      if ( newX >= 0 && newY >= 0 && newX < _maze.numOfHorizontal && newY < _maze.numOfVertical //Boundary
            && !visited[newX][newY] //Last visited
            && _maze.r[newX][newY].rect_type != MRect_Type.POND            //Manson cannot enter POND
            && _maze.r[newX][newY].rect_type != MRect_Type.RED_WALL_POND   //Manson cannot enter WALL on POND
            && _maze.r[newX][newY].rect_type != MRect_Type.GREEN_WALL      //Manson cannot enter Opponent Wall
            && _maze.r[newX][newY].rect_type != MRect_Type.RED_MANSON      //Manson cannot step on own Manson
            && _maze.r[newX][newY].rect_type != MRect_Type.GREEN_MANSON )  //Manson cannot step on opponent Manson 
      { 
        Node nextNode = new Node(newX, newY, current.distance + 1, current);
        queue.add(nextNode);
        println("aStar add Node");
      }
    }
  }
}

void printPath(Node node) {
  LinkedList<Node> path = new LinkedList<Node>();
  Node current = node;
  int moveX, moveY;
  
  while (current != null) {
    path.addFirst(current);
    current = current.parent;
  }

  for (Node n : path)
    println("[" + n.x + ", " + n.y + "]");
  
  if(path.size() > 1){
    moveX = path.get(1).x;
    moveY = path.get(1).y;
    println("The secondary node = " + "[" + moveX + ", " + moveY + "]");
    
     
    actionPlan[0].Action = 1;
    if(moveX < contest_api.MansonPos[manson_keyIn].xPos && moveY < contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 1;
      actionPlan[0].real_action = "MOVE TOP LEFT";
    }else if(moveX == contest_api.MansonPos[manson_keyIn].xPos && moveY < contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 2;
      actionPlan[0].real_action = "MOVE UP";
    }else if(moveX > contest_api.MansonPos[manson_keyIn].xPos && moveY < contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 3;
      actionPlan[0].real_action = "MOVE TOP RIGHT";
    }else if(moveX < contest_api.MansonPos[manson_keyIn].xPos && moveY == contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 8;
      actionPlan[0].real_action = "MOVE LEFT";
    }else if(moveX == contest_api.MansonPos[manson_keyIn].xPos && moveY == contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 0;
      actionPlan[0].real_action = "HOLD";
    }else if(moveX > contest_api.MansonPos[manson_keyIn].xPos && moveY == contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 4;
      actionPlan[0].real_action = "MOVE RIGHT";
    }else if(moveX < contest_api.MansonPos[manson_keyIn].xPos && moveY > contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 7;
      actionPlan[0].real_action = "MOVE BOTTOM LEFT";
    }else if(moveX == contest_api.MansonPos[manson_keyIn].xPos && moveY > contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 6;
      actionPlan[0].real_action = "MOVE DOWN";
    }else if(moveX > contest_api.MansonPos[manson_keyIn].xPos && moveY > contest_api.MansonPos[manson_keyIn].yPos){
      actionPlan[0].Direction = 5;
      actionPlan[0].real_action = "MOVE BOTTOM RIGHT";
    }
    myPanel.set_action_label(manson_keyIn, actionPlan[manson_keyIn].real_action);
  }
}
