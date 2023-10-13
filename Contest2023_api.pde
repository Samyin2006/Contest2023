import http.requests.*;

enum Wall_Type { 
  NO_WALL,RED_WALL, GREEN_WALL;
}

enum Territories_Type {
  FREESPACE, RED_TERRITORIES, GREEN_TERRITORIES;
}

enum Structure_Type {
  FREESPACE, POND, CASTLE;
}



class Contest2023_api{
  
  //String url = "http://192.168.1.102:3000";
  String url = "http://localhost:3000";
  String token = "?token=" + "hongkongb6df0142c311d8d44169743c2f21a916ece310e82be067ed9dfa89b8";
  //String token = "?token=" + "1234";
  String initMatches_endpoint = url + "/matches" + token ;
  String inGame_Matches_endpoint;
  boolean connection;
  int match_id;
  int total_turns;
  int match_turns;
  int match_turnSeconds;
  int wallBonus;
  int territoryBonus;
  int castleBonus;
  int map_width;
  int map_height;
  int mason_num;
  String opponent_name;
  boolean match_isFirst;
  boolean tooEarly;
  private GetRequest getinitReq;
  private GetRequest getReq;
  private PostRequest postReq;
  
  Structure_Type[][] StructuresArray = new Structure_Type[25][25];      //Collect the Struction information from server
  Wall_Type[][] WallArray = new Wall_Type[25][25];                      //Collect the Wall information from server
  Manson[][] MansonArray = new Manson[25][25];                          //Collect the Manson information from server
  Territories_Type[][] TerritoriesArray = new Territories_Type[25][25]; //Collect the Territories information from server
  MansonPlan[] actionPlan = new MansonPlan[6];
  //MansonPosition[] MansonPos = new MansonPosition[6];                   //Record all manson position
  
  Contest2023_api(){
    connection = false; 
    tooEarly = false;
    for(int i=0; i<25; i++){
      for(int j=0; j<25; j++){
        StructuresArray[i][j] = Structure_Type.FREESPACE;
        WallArray[i][j] = Wall_Type.NO_WALL;
        MansonArray[i][j] = new Manson(0);
      }
    }
    
    for(int k=0; k<6; k++)
      actionPlan[k] = new MansonPlan();
    
  }
  
  boolean get_initMatchesRequest(){
    println("Endpoint = " + initMatches_endpoint);
    getinitReq = new GetRequest(initMatches_endpoint);
    getinitReq.send();
    
    if(getinitReq.getContent() != null){
      connection = true;
      //println("response: " + getinitReq.getContent());
      JSONObject response = parseJSONObject(getinitReq.getContent());
      JSONArray matches = response.getJSONArray("matches");
      JSONObject match = matches.getJSONObject(0);
      match_id = match.getInt("id");
      total_turns = match.getInt("turns");
      match_turns = -1;
      match_turnSeconds = match.getInt("turnSeconds");
      
      JSONObject bonus = match.getJSONObject("bonus");
      wallBonus = bonus.getInt("wall");
      territoryBonus = bonus.getInt("territory");
      castleBonus = bonus.getInt("castle");
      
      JSONObject board = match.getJSONObject("board");
      map_width = board.getInt("width");
      map_height = board.getInt("height");
      mason_num = board.getInt("mason");
      
      opponent_name = match.getString("opponent");
      match_isFirst = match.getBoolean("first");
      
      //Get JSON structures array
      JSONArray structures = board.getJSONArray("structures");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = structures.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
            switch(rowArray.getInt(j)){
              default:
              case 0:
                StructuresArray[j][i] = Structure_Type.FREESPACE;
                break;
              case 1:
                StructuresArray[j][i] = Structure_Type.POND;
                break;
              case 2:
                StructuresArray[j][i] = Structure_Type.CASTLE;
                break;
            }
          }
        }
        
    
      //Get JSON manson array
      JSONArray manson = board.getJSONArray("masons");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = manson.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
            //if(match_isFirst == true)
              MansonArray[j][i].manson_ID = rowArray.getInt(j);
            //else
            //  MansonArray[j][i].manson_ID = rowArray.getInt(j)*(-1);
              
            if(MansonArray[j][i].manson_ID > 0)
              actionPlan[ MansonArray[j][i].manson_ID - 1 ].updatePosition(j,i);
          }
        }
      
      inGame_Matches_endpoint = url + "/matches/" + str(match_id) + token;
      getReq = new GetRequest(inGame_Matches_endpoint);
      postReq = new PostRequest(inGame_Matches_endpoint);
      
      println("==========================================");
      println("id              = " + match_id);
      println("turns           = " + match_turns);
      println("turnSeconds     = " + match_turnSeconds);
      println("wallBonus       = " + wallBonus);
      println("territoryBonus  = " + territoryBonus);
      println("castleBonus     = " + castleBonus);
      println("map_width       = " + map_width);
      println("map_height      = " + map_height);
      println("mason           = " + mason_num);
      println("opponent name   = " + opponent_name);
      println("isFirst         = " + match_isFirst);
    }
    else
    {
       println("Server cannot connect");
       connection = false;
    }
    return connection;
  }
  
  void get_MatchesRequest(){
    if(connection == true){
      getReq.send();
      if(!(getReq.getContent().equals("TooEarly")) )
      {
        tooEarly = false;
        //println("response: " + getReq.getContent());
        // Parse the JSON data
        JSONObject response = parseJSONObject(getReq.getContent());
        
        // Access the values from the JSON object
        match_turns = response.getInt("turn");
        
        JSONObject board = response.getJSONObject("board");
        
        JSONArray structures = board.getJSONArray("structures");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = structures.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
            switch(rowArray.getInt(j)){
              default:
              case 0:
                StructuresArray[j][i] = Structure_Type.FREESPACE;
                break;
              case 1:
                StructuresArray[j][i] = Structure_Type.POND;
                break;
              case 2:
                StructuresArray[j][i] = Structure_Type.CASTLE;
                break;
            }
          }
        }
        
        JSONArray wall = board.getJSONArray("walls");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = wall.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
            switch(rowArray.getInt(j)){
              default:
              case 0:
                WallArray[j][i] = Wall_Type.NO_WALL;
                break;
              case 1:
                WallArray[j][i] = Wall_Type.RED_WALL;
                break;
              case 2:
                WallArray[j][i] = Wall_Type.GREEN_WALL;
                break;
            }
          }
        }
        
        JSONArray territories = board.getJSONArray("territories");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = territories.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
            switch(rowArray.getInt(j)){
              default:
              case 0:
                TerritoriesArray[j][i] = Territories_Type.FREESPACE;
                break;
              case 1:
                TerritoriesArray[j][i] = Territories_Type.RED_TERRITORIES;
                break;
              case 2:
                TerritoriesArray[j][i] = Territories_Type.GREEN_TERRITORIES;
                break;
            }
          }
        }
        
        
        
        
        JSONArray manson = board.getJSONArray("masons");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = manson.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
              MansonArray[j][i].manson_ID = rowArray.getInt(j);
              if(MansonArray[j][i].manson_ID > 0)
                actionPlan[ MansonArray[j][i].manson_ID - 1 ].updatePosition(j,i);
          }
        }
      }
      else
        tooEarly = true;
    }
  }
  
  
  void post_MatchesRequest( ){
      JSONArray actionsArray = new JSONArray();    // Clear the actionsArray 
      
      String response = "";
      // Create a JSON object
      JSONObject json = new JSONObject();
      json.setInt("turn", match_turns+1);
      
      for(int i=0; i<mason_num; i++ ){
        JSONObject action = new JSONObject();
        action.setInt("type", actionPlan[i].Action);    //Action type
        action.setInt("dir", actionPlan[i].Direction);     //Action Direction
        actionsArray.append(action);
      }
      
      json.setJSONArray("actions", actionsArray);
      postReq.addHeader("Content-Type", "application/json");    // Set the request headers
      String jsonPayload = json.toString();
      println("SEND:  " + jsonPayload);
      postReq.addData(jsonPayload);      // Set the request body with the JSON payload
      postReq.send();                    // Send the request and receive the response
      response = postReq.getContent();   // Get the response body
      println("Response: " + response);  // Print the response
  }
  
  int wall_count(Wall_Type _type){
    int count = 0;
    for (int i = 0; i < map_height; i++) {
      for (int j = 0; j < map_width; j++) {
        if( WallArray[j][i] == _type)
          count++;
      }
    }
    return count;
  }
  
  int castle_count(Territories_Type _type){
    int count = 0;
    for (int i = 0; i < map_height; i++) {
      for (int j = 0; j < map_width; j++) {
        if( TerritoriesArray[j][i] == _type && StructuresArray[j][i] == Structure_Type.CASTLE)
          count++;
      }
    }
    return count;
  }
  
  int Territories_count(Territories_Type _type){
    int count = 0;
    for (int i = 0; i < map_height; i++) {
      for (int j = 0; j < map_width; j++) {
        if( TerritoriesArray[j][i] == _type && StructuresArray[j][i] != Structure_Type.CASTLE)
          count++;
      }
    }
    return count;
  }

}
