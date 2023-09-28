import http.requests.*;

class Contest2023_api{
  
  String url = "http://127.0.0.1:3000";
  //String token = "?token=" + "hongkongb6df0142c311d8d44169743c2f21a916ece310e82be067ed9dfa89b8";
  String token = "?token=" + "0987";
  String initMatches_endpoint = url + "/matches" + token ;
  //String initMatches_endpoint = url + "/matches" ;
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
  
  Structure_Type[][] StructuresArray = new Structure_Type[25][25];
  Wall_Type[][] WallArray = new Wall_Type[25][25];
  Manson[][] MansonArray = new Manson[25][25];
  
  Contest2023_api(){
    connection = false; 
    tooEarly = false;
    for(int i=0; i<25; i++)
      for(int j=0; j<25; j++){
        StructuresArray[i][j] = Structure_Type.FREESPACE;
        WallArray[i][j] = Wall_Type.NO_WALL;
        MansonArray[i][j] = new Manson(0);
      }
  }
  
  void get_initMatchesRequest(){
    println("Endpoint = " + initMatches_endpoint);
    getinitReq = new GetRequest(initMatches_endpoint);
    getinitReq.send();
    
    if(getinitReq.getContent() != null){
      connection = true;
      println("response: " + getinitReq.getContent());
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
            if(match_isFirst)
              MansonArray[j][i].manson_ID = rowArray.getInt(j);
            else
              MansonArray[j][i].manson_ID = rowArray.getInt(j)*(-1);
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
        //int id = response.getInt("id");
        match_turns = response.getInt("turn");
        
        JSONObject board = response.getJSONObject("board");
        //int width = board.getInt("width");
        //int height = board.getInt("height");
        //int mason = board.getInt("mason");
        
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
        
        JSONArray manson = board.getJSONArray("masons");
        for (int i = 0; i < map_height; i++) {
          JSONArray rowArray = manson.getJSONArray(i);
          for (int j = 0; j < map_width; j++) {
              MansonArray[j][i].manson_ID = rowArray.getInt(j);
          }
        }
      }
      else
        tooEarly = true;
    }
  }
  
  
  void post_MatchesRequest( ){
    String response = "";
    
    //********************************************************
    // Create a JSON object
    JSONObject json = new JSONObject();
    json.setInt("turn", match_turns+1);
    
    JSONArray actionsArray = new JSONArray();
    
    JSONObject action = new JSONObject();
    for(int i=0; i<mason_num; i++){
      action.setInt("type", inputKey[i].Action);    //Action type
      action.setInt("dir", inputKey[i].Direction);     //Action Direction
      actionsArray.append(action);
    }
   /* 
    mason_action = 
    String post_action1 = "{\"turn\": 200,\"actions\": [";
    for (int i = 0; i < mason_num; i++) {
      post_action1 += "{\"type\": " + actions[i][0] + ", \"dir\": " + actions[i][1] + "}";
      if (i < actions.length - 1) {
        post_action1 += ",";
      }
    }
    post_action1 += "]}";
    */
    
    
    
    
    
    
    
    
    
    
    json.setJSONArray("actions", actionsArray);
    //********************************************************
    
    
    
    postReq.addHeader("Content-Type", "application/json");    // Set the request headers
    String jsonPayload = json.toString();
    println("SEND:  " + jsonPayload);
    postReq.addData(jsonPayload);      // Set the request body with the JSON payload
    postReq.send();                    // Send the request and receive the response
    response = postReq.getContent();   // Get the response body
    println("Response: " + response);  // Print the response
    
  }

}
