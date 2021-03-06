//import stuff for pathfinding
import java.util.Deque;
import java.util.Iterator;
import java.util.LinkedList;

Pacman pacman;
/* @pjs preload="map.jpg"; */
PImage img;//background image 

Pinky pinky;
Blinky blinky;
Clyde clyde;
Inky inky;
Tile[][] tiles = new Tile[31][28]; //note it goes y then x because of how I inserted the data
int[][] tilesRepresentation = { 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 6, 6, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};//its not sexy but it does the job
//--------------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  frameRate(100);
  size(448, 496);
  img = loadImage("map.jpg");
  //initiate tiles
  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      tiles[j][i] = new Tile(16*i +8, 16*j+8);
      switch(tilesRepresentation[j][i]) {
      case 1: //1 is a wall
        tiles[j][i].wall = true;
        break;
      case 0: // 0 is a dot
        tiles[j][i].dot = true;
        break;
      case 8: // 8 is a big dot
        tiles[j][i].bigDot = true;
        break;
      case 6://6 is a blank space
        tiles[j][i].eaten = true;
        break;
      }
    }
  }

  pacman = new Pacman();
  pinky = new Pinky();
  blinky = new Blinky();
  clyde = new Clyde();
  inky = new Inky();
}
//--------------------------------------------------------------------------------------------------------------------------------------------------

void draw() {
  image(img, 0, 0);
  if (!pacman.gameOver) {
    stroke(255);

    for (int i = 0; i< 28; i++) {
      for (int j = 0; j< 31; j++) {
        tiles[j][i].show();
      }
    }
    pacman.move();

    //move and show the ghosts
    inky.show();
    inky.move();

    clyde.show();
    clyde.move();

    pinky.show();
    pinky.move();

    blinky.show();
    blinky.move();

    //show pacman last so he appears over the path lines
    pacman.show();
  }
}
//--------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {//controls for pacman
  switch(key) {
  case CODED:
    switch(keyCode) {
    case UP:
      pacman.turnTo = new PVector(0, -1);
      pacman.turn = true;
      break;
    case DOWN:
      pacman.turnTo = new PVector(0, 1);
      pacman.turn = true;
      break;
    case LEFT:
      pacman.turnTo = new PVector(-1, 0);
      pacman.turn = true;
      break;
    case RIGHT:
      pacman.turnTo = new PVector(1, 0);
      pacman.turn = true;
      break;
    }
  }
}
//--------------------------------------------------------------------------------------------------------------------------------------------------


//returns the nearest non wall tile to the input vector
//input is in tile coordinates
PVector getNearestNonWallTile(PVector target) {
  float min = 1000;
  int minIndexj = 0;
  int minIndexi = 0;
  for (int i = 0; i< 28; i++) {//for each tile
    for (int j = 0; j< 31; j++) {
      if (!tiles[j][i].wall) {//if its not a wall
        if (dist(i, j, target.x, target.y)<min) { //if its the current closest to target
          min =  dist(i, j, target.x, target.y);
          minIndexj = j;
          minIndexi = i;
        }
      }
    }
  }
  return new PVector(minIndexi, minIndexj);//return a PVector to the tile
}


//--------------------------------------------------------------------------------------------------------------------------------------------------
//returns the shortest path from the start node to the finish node
Path AStar(Node start, Node finish, PVector vel)
{
  LinkedList<Path> big = new LinkedList<Path>();//stores all paths
  Path extend = new Path(); //a temp Path which is to be extended by adding another node
  Path winningPath = new Path();  //the final path
  Path extended = new Path(); //the extended path
  LinkedList<Path> sorting = new LinkedList<Path>();///used for sorting paths by their distance to the target

  //startin off with big storing a path with only the starting node
  extend.addToTail(start, finish);
  extend.velAtLast = new PVector(vel.x, vel.y);//used to prevent ghosts from doing a u turn
  big.add(extend);


  boolean winner = false;//has a path from start to finish been found  

  while (true) //repeat the process until ideal path is found or there is not path found 
  {
    extend = big.pop();//grab the front path form the big to be extended
    if (extend.path.getLast().equals(finish)) //if goal found
    {
      if (!winner) //if first goal found, set winning path
      {
        winner = true;
        winningPath = extend.clone();
      } else { //if current path found the goal in a shorter distance than the previous winner 
        if (winningPath.distance > extend.distance)
        {
          winningPath = extend.clone();//set this path as the winning path
        }
      }
      if (big.isEmpty()) //if this extend is the last path then return the winning path
      {
        return winningPath.clone();
      } else {//if not the current extend is useless to us as it cannot be extended since its finished
        extend = big.pop();//so get the next path
      }
    } 


    //if the final node in the path has already been checked and the distance to it was shorter than this path has taken to get there than this path is no good
    if (!extend.path.getLast().checked || extend.distance < extend.path.getLast().smallestDistToPoint)
    {     
      if (!winner || extend.distance + dist(extend.path.getLast().x, extend.path.getLast().y, finish.x, finish.y)  < winningPath.distance) //dont look at paths that are longer than a path which has already reached the goal
      {

        //if this is the first path to reach this node or the shortest path to reach this node then set the smallest distance to this point to the distance of this path
        extend.path.getLast().smallestDistToPoint = extend.distance;
        
        //move all paths to sorting form big then add the new paths (in the for loop)and sort them back into big.
        sorting = (LinkedList)big.clone();
        Node tempN = new Node(0, 0);//reset temp node
        if (extend.path.size() >1) {
          tempN = extend.path.get(extend.path.size() -2);//set the temp node to be the second last node in the path
        }

        for (int i =0; i< extend.path.getLast().edges.size(); i++) //for each node incident (connected) to the final node of the path to be extended 
        {
          if (tempN != extend.path.getLast().edges.get(i))//if not going backwards i.e. the new node is not the previous node behind it 
          {     
     
            //if the direction to the new node is in the opposite to the way the path was heading then dont count this path
            PVector directionToNode = new PVector( extend.path.getLast().edges.get(i).x -extend.path.getLast().x, extend.path.getLast().edges.get(i).y - extend.path.getLast().y );
            directionToNode.limit(vel.mag());
            if (directionToNode.x == -1* extend.velAtLast.x && directionToNode.y == -1* extend.velAtLast.y ) {
            } else {//if not turning around
              extended = extend.clone();
              extended.addToTail(extend.path.getLast().edges.get(i), finish);
              extended.velAtLast = new PVector(directionToNode.x, directionToNode.y);
              sorting.add(extended.clone());//add this extended list to the list of paths to be sorted
            }
          }
        }


        //sorting now contains all the paths form big plus the new paths which where extended
        //adding the path which has the higest distance to big first so that its at the back of big.
        //using selection sort i.e. the easiest and worst sorting algorithm
        big.clear();
        while (!sorting.isEmpty())
        {
          float max = -1;
          int iMax = 0;
          for (int i = 0; i < sorting.size(); i++)
          {
            if (max < sorting.get(i).distance + sorting.get(i).distToFinish)//A* uses the distance from the goal plus the paths length to determine the sorting order
            {
              iMax = i;
              max = sorting.get(i).distance + sorting.get(i).distToFinish;
            }
          }
          big.addFirst(sorting.remove(iMax).clone());//add it to the front so that the ones with the greatest distance end up at the back
          //and the closest ones end up at the front
        }
      }
      extend.path.getLast().checked = true;
    }
    //if no more paths avaliable
    if (big.isEmpty()) {
      if (winner ==false) //there is not path from start to finish
      {
        print("FUCK!!!!!!!!!!");//error message 
        return null;
      } else {//if winner is found then the shortest winner is stored in winning path so return that
        return winningPath.clone();
      }
    }
  }
}
//**********************************************************************************************************************************************************************
class Path {
  LinkedList<Node> path = new LinkedList<Node>();//a list of nodes 
  float distance = 0;//length of path
  float distToFinish =0;//the distance between the final node and the paths goal
  PVector velAtLast;//the direction the ghost is going at the last point on the path

  //--------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Path() {
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //adds a node to the end of the path
  void addToTail(Node n, Node endNode)
  {
    if (!path.isEmpty())//if path is empty then this is the first node and thus the distance is still 0
    {
      distance += dist(path.getLast().x, path.getLast().y, n.x, n.y);//add the distance from the current last element in the path to the new node to the overall distance
    }

    path.add(n);//add the node
    distToFinish = dist(path.getLast().x, path.getLast().y, endNode.x, endNode.y);//recalculate the distance to the finish
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
 //retrun a clone of this 
  Path clone()
  {
    Path temp = new Path();
    temp.path = (LinkedList)path.clone();
    temp.distance = distance;
    temp.distToFinish = distToFinish;
    temp.velAtLast = new PVector(velAtLast.x, velAtLast.y);
    return temp;
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
   //removes all nodes in the path
  void clear()
  {
    distance =0;
    distToFinish = 0;
    path.clear();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //draw lines representing the path
  void show() {
    strokeWeight(2);
    for (int i = 0; i< path.size()-1; i++) {
      line(path.get(i).x*16 +8, path.get(i).y*16 +8, path.get(i+1).x*16 +8, path.get(i+1).y*16 +8);//
    }
    ellipse((path.get(path.size() -1).x*16)+8, (path.get(path.size() -1).y*16)+8, 5, 5);
  }
}
//***************************************************************************************************************************************************************************************
class Tile {
  boolean wall = false;
  boolean dot = false;
  boolean bigDot = false;
  boolean eaten = false;
  PVector pos;
//-------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Tile(float x, float y) {
    pos = new PVector(x, y);
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------
//draw a dot if there is one in this tile
  void show() {
    if (dot) {
      if (!eaten) {//draw dot
        fill(255, 255, 0);
        noStroke();
        ellipse(pos.x, pos.y, 3, 3);
      }
    } else if (bigDot) {
      if (!eaten) {//draw big dot
        fill(255, 255, 0);
        noStroke();
        ellipse(pos.x, pos.y, 6, 6);
      }
    }
  }
}
//*************************************************************************************************************************************************************************************
class Node {

  LinkedList<Node> edges = new LinkedList<Node>();//all the nodes this node is connected to 
  float x;
  float y;
  float smallestDistToPoint = 10000000;//the distance of smallest path from the start to this node 
  int degree;
  int value;  
  boolean checked = false;
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Node(float x1, float y1) {
    x = x1;
    y = y1;
  }
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //draw a litle circle
  void show() {
    fill(0, 100, 100);
    ellipse(x*16 +8, y*16 +8, 10, 10 );
  }

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //add all the nodes this node is adjacent to 
  void addEdges(ArrayList<Node> nodes) {
    for (int i =0; i < nodes.size(); i++) {//for all the nodes
      if (nodes.get(i).y == y ^ nodes.get(i).x == x) {
        if (nodes.get(i).y == y) {//if the node is on the same line horizontally
          float mostLeft = min(nodes.get(i).x, x) + 1;
          float max = max(nodes.get(i).x, x);
          boolean edge = true;
          while (mostLeft < max) {//look from the one node to the other looking for a wall
            if (tiles[(int)y][(int)mostLeft].wall) {
              edge = false;//not an edge since there is a wall in the way
              break;
            }
            mostLeft ++;//move 1 step closer to the other node
          }
          if (edge) {
            edges.add(nodes.get(i));//add the node as an edge
          }
        } else if (nodes.get(i).x == x) {//same line vertically
          float mostUp = min(nodes.get(i).y, y) + 1;
          float max = max(nodes.get(i).y, y);
          boolean edge = true;
          while (mostUp < max) {
            if (tiles[(int)mostUp][(int)x].wall) {
              edge = false;
              break;
            }
            mostUp ++;
          }
          if (edge) {
            edges.add(nodes.get(i));
          }
        }
      }
    }
  }
}
//********************************************************************************************************************************************************************************************
class Pacman {
  PVector pos;
  PVector vel = new PVector(-1, 0);
  
  //when pacman reaches a node its velocity changes to the value stored in turnto
  PVector turnTo = new PVector(-1, 0);
  boolean turn = false;
  int score = 0;
  int lives = 2;
  boolean  gameOver = false;
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Pacman() {
    pos = new PVector(13*16+8, 23*16 +8);
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  
  //draws pacman
  void show() {
    fill(255, 255, 0);
    stroke(255, 255, 0);
    ellipse(pos.x, pos.y, 20, 20);
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //move pacman if not facing wall
  void move() {
    if (checkPosition()) {
      pos.add(vel);
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  
  //returns whether the input vector hits pacman
  boolean hitPacman(PVector GhostPos) {
    if (dist(GhostPos.x, GhostPos.y, pos.x, pos.y) < 10) {
      return true;
    }
    return false;
  }
  
  
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //called when a ghost hits pacman
  void kill() {
    lives -=1;
    if (lives < 0) {//game over if no lives left
      gameOver = true;
    } else {
      pos = new PVector(13*16+8, 23*16 +8);     //reset positions  

      blinky = new Blinky();
      clyde = new Clyde();
      pinky = new Pinky();
      inky = new Inky();
      vel = new PVector(-1, 0);
      turnTo = new PVector(-1, 0);
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //returns whether pacman can move i.e. there is no wall in the direction of vel
  boolean checkPosition() {

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position

      //reset all the paths for all the ghosts  
      blinky.setPath();
      pinky.setPath();
      clyde.setPath();
      inky.setPath(); 
      
      //check if the position has been eaten or not, note the blank spaces are initialised as already eaten
      if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten) {
        tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;
        score +=1;//add a point
        if (tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].bigDot) {//if big dot eaten
          //set all ghosts to frightened
          blinky.frightened = true;
          blinky.flashCount = 0;
          clyde.frightened = true;
          clyde.flashCount = 0;
          pinky.frightened = true;
          pinky.flashCount = 0;
          inky.frightened = true;
          inky.flashCount = 0;
        }
      }
      
      
      PVector positionToCheck= new PVector(matrixPosition.x + turnTo.x, matrixPosition.y+ turnTo.y); // the position in the tiles double array that the player is turning towards

      if (tiles[floor(positionToCheck.y)][floor(positionToCheck.x)].wall) {//check if there is a free space in the direction that it is going to turn
        if (tiles[floor(matrixPosition.y + vel.y)][floor(matrixPosition.x + vel.x)].wall) {//if not check if the path ahead is free
          return false;//if neither are free then dont move
        } else {//forward is free
          return true;
        }
      } else {//free to turn
        vel = new PVector(turnTo.x, turnTo.y);
        return true;
      }
    } else {
      if ((pos.x+10*vel.x-8)%16 == 0 && (pos.y + 10*vel.y - 8)% 16 ==0) {//if 10 places off a critical position in the direction that pacman is moving
        PVector matrixPosition = new PVector((pos.x+10*vel.x-8)/16, (pos.y+10*vel.y-8)/16);//convert that position to an array position
        if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten ) {//if that tile has not been eaten 
          tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;//eat it
          score +=1;
          println("Score:", score);
          if (tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].bigDot) {//big dot eaten
            //set all ghosts as frightened
            blinky.frightened = true;
            blinky.flashCount = 0;
            clyde.frightened = true;
            clyde.flashCount = 0;
            pinky.frightened = true;
            pinky.flashCount = 0;
            inky.frightened = true;
            inky.flashCount = 0;
          }
        }
      }
      if (turnTo.x + vel.x == 0 && vel.y + turnTo.y ==0) {//if turning chenging directions entirely i.e. 180 degree turn
        vel = new PVector(turnTo.x, turnTo.y);//turn
        return true;
      }
      return true;//if not on a critical postion then continue forward
    }

  }
}
//************************************************************************************************************************************************************************************************
class Pinky {
  PVector pos = new PVector(23*16 +8, 26*16+8);
  PVector vel = new PVector(1, 0);
  Path bestPath; // the variable stores the path the ghost will be following
  ArrayList<Node> ghostNodes = new ArrayList<Node>();//the nodes making up the path including the ghosts position and the target position
  Node start;//the ghosts position as a node
  Node end; //the ghosts target position as a node
  color colour = color(255, 0, 255);//pink


  boolean chase = true;//true if the ghost is in chase mode false if in scatter mode
  boolean frightened = false;//true if the ghost is in frightened mode
  int flashCount = 0;//in order to make the ghost flash when frightened this is a counter
  int chaseCount = 0;//counter for the switch between chase and scatter
  boolean returnHome = false;//if eaten return home
  boolean deadForABit = false;//after the ghost returns home it disappears for a bit
  int deadCount = 0;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Pinky() {
    setPath();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------

  void show() {
    //increments counts
    chaseCount ++;
    if (chase) {
      if (chaseCount > 2000) {
        chase = false;  
        chaseCount = 0;
      }
    } else {
      if (chaseCount > 700) {
        chase = true;
        chaseCount = 0;
      }
    }
    
    
    
    if (deadForABit) {
      deadCount ++;
      if (deadCount > 300) {
        deadForABit = false;
      }
    } else {//if not deadforabit then show the ghost
      if (!frightened) {
        if (returnHome) {//have the ghost be transparent if on its way home
          stroke(colour, 100); 
          fill(colour, 100);
        } else {// colour the ghost
          stroke(colour);
          fill(colour);
        }
        bestPath.show();//show the path the ghost is following
      } else {//if frightened
        flashCount ++;
        if (flashCount > 800) {//after 8 seconds the ghosts are no longer frightened
          frightened = false;
          flashCount = 0;
        }

        if (floor(flashCount / 30) %2 ==0) {//make it flash white and blue every 30 frames
          stroke(255);
          fill(255);
        } else {//flash blue
          stroke(0, 0, 200);
          fill(0, 0, 200);
        }
      }
      ellipse(pos.x, pos.y, 20, 20);//draw the ghost as a circle
    }
  }

  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //moves the ghost along the path
  void move() {
    if (!deadForABit) {//dont move if dead
      pos.add(vel);
      checkDirection();//check if need to change direction next move
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  
  //calculates a path from the first node in ghost nodes to the last node in ghostNodes and sets it as best path
  void setPath() {
    ghostNodes.clear();
    setNodes();
    start  = ghostNodes.get(0);
    end = ghostNodes.get(ghostNodes.size()-1);
    Path temp = AStar(start, end, vel);
    if (temp!= null) {//if not path is found then dont change bestPath
      bestPath = temp.clone();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //sets all the nodes and connects them with adjacent nodes 
  //also sets the target node
  void setNodes() {

    ghostNodes.add(new Node((pos.x-8)/16, (pos.y-8)/16));//add the current position as a node
    for (int i = 1; i< 27; i++) {//check every position
      for (int j = 1; j< 30; j++) {
        //if there is a space up or below and a space left or right then this space is a node
        if (!tiles[j][i].wall) {
          if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
            if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space

              ghostNodes.add(new Node(i, j));//add the nodes
            }
          }
        }
      }
    }
    if (returnHome) {//if returning home then the target is just above the ghost room thing
      ghostNodes.add(new Node(13, 11));
    } else {
      if (chase) {
        //pinky moves towards 4 positions ahead of pacman
        int lookAhead = 4;
        PVector pacmanMatrixPos = new PVector((pacman.pos.x-8) / 16 +  (pacman.vel.x *lookAhead), (pacman.pos.y-8 )/16 +(pacman.vel.y *lookAhead));
        while (!(pacmanMatrixPos.x > 0 && pacmanMatrixPos.y >0 && pacmanMatrixPos.x <28 
          && pacmanMatrixPos.y < 31 && !tiles[(int)pacmanMatrixPos.y][(int)pacmanMatrixPos.x].wall)) {
          lookAhead -=1;
          pacmanMatrixPos = new PVector((pacman.pos.x-8) / 16 +  (pacman.vel.x *lookAhead), (pacman.pos.y-8 )/16 +(pacman.vel.y *lookAhead));
        }
        if (dist((pos.x-8)/16, (pos.y-8)/16, pacmanMatrixPos.x, pacmanMatrixPos.y)<1) {
          ghostNodes.add(new Node((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16));
        } else {

          ghostNodes.add(new Node(pacmanMatrixPos.x, pacmanMatrixPos.y));//(pacman.pos.x-8 + (pacman.vel.x *4)) / 16, (pacman.pos.y-8 +(pacman.vel.y *4))/16));
        }
      } else {//scatter
        ghostNodes.add(new Node(26, 1));
      }
    }
    
    for (int i = 0; i< ghostNodes.size(); i++) {//connect all the nodes together
      ghostNodes.get(i).addEdges(ghostNodes);
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //check if the ghost needs to change direction as well as other stuff
  void checkDirection() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      if (frightened) {//eaten by pacman
        returnHome = true;
        frightened = false;
      } else if (!returnHome) {//killPacman
        pacman.kill();
      }
    }


    // check if reached home yet
    if (returnHome) {
      if (dist((pos.x-8)/16, (pos.y - 8)/16, 13, 11) < 1) {
        //set the ghost as dead for a bit
        returnHome = false;
        deadForABit = true;
        deadCount = 0;
      }
    }

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position 

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position

      if (frightened) {//no path needs to generated by the ghost if frightened
        boolean isNode = false;
        for (int j = 0; j < ghostNodes.size(); j++) {
          if (matrixPosition.x ==  ghostNodes.get(j).x && matrixPosition.y == ghostNodes.get(j).y) {
            isNode = true;
          }
        }
        if (!isNode) {//if not on a node then no need to do anything
          return;
        } else {//if on a node
          //set a random direction
          PVector newVel = new PVector();
          int rand = floor(random(4));
          switch(rand) {
          case 0:
            newVel = new PVector(1, 0);
            break;
          case 1:
            newVel = new PVector(0, 1);
            break;
          case 2:
            newVel = new PVector(-1, 0);
            break;
          case 3:
            newVel = new PVector(0, -1);
            break;
          }
          //if the random velocity is into a wall or in the opposite direction then choose another one
          while (tiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
            rand = floor(random(4));
            switch(rand) {
            case 0:
              newVel = new PVector(1, 0);
              break;
            case 1:
              newVel = new PVector(0, 1);
              break;
            case 2:
              newVel = new PVector(-1, 0);
              break;
            case 3:
              newVel = new PVector(0, -1);
              break;
            }
          }
          vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
        }
      } else {//not frightened

        setPath();

        for (int i =0; i< bestPath.path.size(); i++) {//if currently on a node turn towards the direction of the next node in the path 
          if (matrixPosition.x ==  bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {
            
            vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y);
            vel.limit(1);

            return;
          }
        }
      }
    }
  }
}
//*************************************************************************************************************************************************************************************************
class Inky {
  PVector pos = new PVector(8*16 +8, 1*16+8);//starting position
  PVector vel = new PVector(1, 0);
  Path bestPath; // the variable stores the path the ghost will be following
  ArrayList<Node> ghostNodes = new ArrayList<Node>();//the nodes making up the path including the ghosts position and the target position
  Node start;//the ghosts position as a node
  Node end; //the ghosts target position as a node
  color colour = color(135, 206, 250);//blueish

  
  boolean chase = true;//true if the ghost is in chase mode false if in scatter mode
  boolean frightened = false;//true if the ghost is in frightened mode
  int flashCount = 0;//in order to make the ghost flash when frightened this is a counter
  int chaseCount = 0;//counter for the switch between chase and scatter
  boolean returnHome = false;//if eaten return home
  boolean deadForABit = false;//after the ghost returns home it disappears for a bit
  int deadCount = 0;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Inky() {
    setPath();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------

  void show() {
    //increments counts
    chaseCount ++;
    if (chase) {
      if (chaseCount > 2000) {
        chase = false;  
        chaseCount = 0;
      }
    } else {
      if (chaseCount > 700) {
        chase = true;
        chaseCount = 0;
      }
    }
    
    
    
    if (deadForABit) {
      deadCount ++;
      if (deadCount > 300) {
        deadForABit = false;
      }
    } else {//if not deadforabit then show the ghost
      if (!frightened) {
        if (returnHome) {//have the ghost be transparent if on its way home
          stroke(colour, 100); 
          fill(colour, 100);
        } else {// colour the ghost
          stroke(colour);
          fill(colour);
        }
        bestPath.show();//show the path the ghost is following
      } else {//if frightened
        flashCount ++;
        if (flashCount > 800) {//after 8 seconds the ghosts are no longer frightened
          frightened = false;
          flashCount = 0;
        }

        if (floor(flashCount / 30) %2 ==0) {//make it flash white and blue every 30 frames
          stroke(255);
          fill(255);
        } else {//flash blue
          stroke(0, 0, 200);
          fill(0, 0, 200);
        }
      }
      ellipse(pos.x, pos.y, 20, 20);//draw the ghost as a circle
    }
  }

  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //moves the ghost along the path
  void move() {
    if (!deadForABit) {//dont move if dead
      pos.add(vel);
      checkDirection();//check if need to change direction next move
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  
  //calculates a path from the first node in ghost nodes to the last node in ghostNodes and sets it as best path
  void setPath() {
    ghostNodes.clear();
    setNodes();
    start  = ghostNodes.get(0);
    end = ghostNodes.get(ghostNodes.size()-1);
    Path temp = AStar(start, end, vel);
    if (temp!= null) {//if not path is found then dont change bestPath
      bestPath = temp.clone();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //sets all the nodes and connects them with adjacent nodes 
  //also sets the target node
  void setNodes() {

    ghostNodes.add(new Node((pos.x-8)/16, (pos.y-8)/16));//add the current position as a node
    for (int i = 1; i< 27; i++) {//check every position
      for (int j = 1; j< 30; j++) {
        //if there is a space up or below and a space left or right then this space is a node
        if (!tiles[j][i].wall) {
          if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
            if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space

              ghostNodes.add(new Node(i, j));//add the nodes
            }
          }
        }
      }
    }
    if (returnHome) {//if returning home then the target is just above the ghost room thing
      ghostNodes.add(new Node(13, 11));
    } else {
      if (chase) {
        PVector pacmanPosition = new PVector((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16);
        PVector blinkyPosition = new PVector((blinky.pos.x-8)/16, (blinky.pos.y - 8)/16);
        PVector blinkyToPacman = new PVector(pacmanPosition.x - blinkyPosition.x, pacmanPosition.y - blinkyPosition.y);

        PVector target = new PVector (pacmanPosition.x + blinkyToPacman.x, pacmanPosition.y + blinkyToPacman.y);
        PVector nearestTile = getNearestNonWallTile(target);

        if (dist((pos.x-8)/16, (pos.y-8)/16, nearestTile.x, nearestTile.y)<1) {
          ghostNodes.add(new Node((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16));
        } else {


          ghostNodes.add(new Node(nearestTile.x, nearestTile.y));
        }
      } else {//scatter
        ghostNodes.add(new Node(26, 29));
      }
    }
    
    for (int i = 0; i< ghostNodes.size(); i++) {//connect all the nodes together
      ghostNodes.get(i).addEdges(ghostNodes);
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //check if the ghost needs to change direction as well as other stuff
  void checkDirection() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      if (frightened) {//eaten by pacman
        returnHome = true;
        frightened = false;
      } else if (!returnHome) {//killPacman
        pacman.kill();
      }
    }


    // check if reached home yet
    if (returnHome) {
      if (dist((pos.x-8)/16, (pos.y - 8)/16, 13, 11) < 1) {
        //set the ghost as dead for a bit
        returnHome = false;
        deadForABit = true;
        deadCount = 0;
      }
    }

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position 

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position

      if (frightened) {//no path needs to generated by the ghost if frightened
        boolean isNode = false;
        for (int j = 0; j < ghostNodes.size(); j++) {
          if (matrixPosition.x ==  ghostNodes.get(j).x && matrixPosition.y == ghostNodes.get(j).y) {
            isNode = true;
          }
        }
        if (!isNode) {//if not on a node then no need to do anything
          return;
        } else {//if on a node
          //set a random direction
          PVector newVel = new PVector();
          int rand = floor(random(4));
          switch(rand) {
          case 0:
            newVel = new PVector(1, 0);
            break;
          case 1:
            newVel = new PVector(0, 1);
            break;
          case 2:
            newVel = new PVector(-1, 0);
            break;
          case 3:
            newVel = new PVector(0, -1);
            break;
          }
          //if the random velocity is into a wall or in the opposite direction then choose another one
          while (tiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
            rand = floor(random(4));
            switch(rand) {
            case 0:
              newVel = new PVector(1, 0);
              break;
            case 1:
              newVel = new PVector(0, 1);
              break;
            case 2:
              newVel = new PVector(-1, 0);
              break;
            case 3:
              newVel = new PVector(0, -1);
              break;
            }
          }
          vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
        }
      } else {//not frightened

        setPath();

        for (int i =0; i< bestPath.path.size(); i++) {//if currently on a node turn towards the direction of the next node in the path 
          if (matrixPosition.x ==  bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {
            
            vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y);
            vel.limit(1);

            return;
          }
        }
      }
    }
  }
}
//****************************************************************************************************************************************************************************************************
class Blinky {
  PVector pos = new PVector(13*16 +8, 11*16+8);//starting position
  PVector vel = new PVector(1, 0);
  Path bestPath; // the variable stores the path the ghost will be following
  ArrayList<Node> ghostNodes = new ArrayList<Node>();//the nodes making up the path including the ghosts position and the target position
  Node start;//the ghosts position as a node
  Node end; //the ghosts target position as a node
  color colour = color(255, 0, 0);//red
  
  boolean chase = true;//true if the ghost is in chase mode false if in scatter mode
  boolean frightened = false;//true if the ghost is in frightened mode
  int flashCount = 0;//in order to make the ghost flash when frightened this is a counter
  int chaseCount = 0;//counter for the switch between chase and scatter
  boolean returnHome = false;//if eaten return home
  boolean deadForABit = false;//after the ghost returns home it disappears for a bit
  int deadCount = 0;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Blinky() {
    setPath();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------

  void show() {
    //increments counts
    chaseCount ++;
    if (chase) {
      if (chaseCount > 2000) {
        chase = false;  
        chaseCount = 0;
      }
    } else {
      if (chaseCount > 700) {
        chase = true;
        chaseCount = 0;
      }
    }
    
    
    
    if (deadForABit) {
      deadCount ++;
      if (deadCount > 300) {
        deadForABit = false;
      }
    } else {//if not deadforabit then show the ghost
      if (!frightened) {
        if (returnHome) {//have the ghost be transparent if on its way home
          stroke(colour, 100); 
          fill(colour, 100);
        } else {// colour the ghost
          stroke(colour);
          fill(colour);
        }
        bestPath.show();//show the path the ghost is following
      } else {//if frightened
        flashCount ++;
        if (flashCount > 800) {//after 8 seconds the ghosts are no longer frightened
          frightened = false;
          flashCount = 0;
        }

        if (floor(flashCount / 30) %2 ==0) {//make it flash white and blue every 30 frames
          stroke(255);
          fill(255);
        } else {//flash blue
          stroke(0, 0, 200);
          fill(0, 0, 200);
        }
      }
      ellipse(pos.x, pos.y, 20, 20);//draw the ghost as a circle
    }
  }

  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //moves the ghost along the path
  void move() {
    if (!deadForABit) {//dont move if dead
      pos.add(vel);
      checkDirection();//check if need to change direction next move
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  
  //calculates a path from the first node in ghost nodes to the last node in ghostNodes and sets it as best path
  void setPath() {
    ghostNodes.clear();
    setNodes();
    start  = ghostNodes.get(0);
    end = ghostNodes.get(ghostNodes.size()-1);
    Path temp = AStar(start, end, vel);
    if (temp!= null) {//if not path is found then dont change bestPath
      bestPath = temp.clone();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //sets all the nodes and connects them with adjacent nodes 
  //also sets the target node
  void setNodes() {

    ghostNodes.add(new Node((pos.x-8)/16, (pos.y-8)/16));//add the current position as a node
    for (int i = 1; i< 27; i++) {//check every position
      for (int j = 1; j< 30; j++) {
        //if there is a space up or below and a space left or right then this space is a node
        if (!tiles[j][i].wall) {
          if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
            if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space

              ghostNodes.add(new Node(i, j));//add the nodes
            }
          }
        }
      }
    }
    if (returnHome) {//if returning home then the target is just above the ghost room thing
      ghostNodes.add(new Node(13, 11));
    } else {
      if (chase) {
        ghostNodes.add(new Node((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16));//target pacman
      } else {
        ghostNodes.add(new Node(1, 1));//scatter to corner
      }
    }
    
    for (int i = 0; i< ghostNodes.size(); i++) {//connect all the nodes together
      ghostNodes.get(i).addEdges(ghostNodes);
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //check if the ghost needs to change direction as well as other stuff
  void checkDirection() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      if (frightened) {//eaten by pacman
        returnHome = true;
        frightened = false;
      } else if (!returnHome) {//killPacman
        pacman.kill();
      }
    }


    // check if reached home yet
    if (returnHome) {
      if (dist((pos.x-8)/16, (pos.y - 8)/16, 13, 11) < 1) {
        //set the ghost as dead for a bit
        returnHome = false;
        deadForABit = true;
        deadCount = 0;
      }
    }

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position 

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position

      if (frightened) {//no path needs to generated by the ghost if frightened
        boolean isNode = false;
        for (int j = 0; j < ghostNodes.size(); j++) {
          if (matrixPosition.x ==  ghostNodes.get(j).x && matrixPosition.y == ghostNodes.get(j).y) {
            isNode = true;
          }
        }
        if (!isNode) {//if not on a node then no need to do anything
          return;
        } else {//if on a node
          //set a random direction
          PVector newVel = new PVector();
          int rand = floor(random(4));
          switch(rand) {
          case 0:
            newVel = new PVector(1, 0);
            break;
          case 1:
            newVel = new PVector(0, 1);
            break;
          case 2:
            newVel = new PVector(-1, 0);
            break;
          case 3:
            newVel = new PVector(0, -1);
            break;
          }
          //if the random velocity is into a wall or in the opposite direction then choose another one
          while (tiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
            rand = floor(random(4));
            switch(rand) {
            case 0:
              newVel = new PVector(1, 0);
              break;
            case 1:
              newVel = new PVector(0, 1);
              break;
            case 2:
              newVel = new PVector(-1, 0);
              break;
            case 3:
              newVel = new PVector(0, -1);
              break;
            }
          }
          vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
        }
      } else {//not frightened

        setPath();

        for (int i =0; i< bestPath.path.size(); i++) {//if currently on a node turn towards the direction of the next node in the path 
          if (matrixPosition.x ==  bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {
            
            vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y);
            vel.limit(1);

            return;
          }
        }
      }
    }
  }
}
//*************************************************************************************************************************************************************************************************
class Clyde {
    PVector pos = new PVector(1*16 +8, 29*16+8);
  PVector vel = new PVector(1, 0);
  Path bestPath; // the variable stores the path the ghost will be following
  ArrayList<Node> ghostNodes = new ArrayList<Node>();//the nodes making up the path including the ghosts position and the target position
  Node start;//the ghosts position as a node
  Node end; //the ghosts target position as a node
  color colour = color(255, 100, 0);//orange
  
  boolean chase = true;//true if the ghost is in chase mode false if in scatter mode
  boolean frightened = false;//true if the ghost is in frightened mode
  int flashCount = 0;//in order to make the ghost flash when frightened this is a counter
  int chaseCount = 0;//counter for the switch between chase and scatter
  boolean returnHome = false;//if eaten return home
  boolean deadForABit = false;//after the ghost returns home it disappears for a bit
  int deadCount = 0;
  

  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Clyde() {
    setPath();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------

  void show() {
    //increments counts
    chaseCount ++;
    if (chase) {
      if (chaseCount > 2000) {
        chase = false;  
        chaseCount = 0;
      }
    } else {
      if (chaseCount > 700) {
        chase = true;
        chaseCount = 0;
      }
    }
    
    
    
    if (deadForABit) {
      deadCount ++;
      if (deadCount > 300) {
        deadForABit = false;
      }
    } else {//if not deadforabit then show the ghost
      if (!frightened) {
        if (returnHome) {//have the ghost be transparent if on its way home
          stroke(colour, 100); 
          fill(colour, 100);
        } else {// colour the ghost
          stroke(colour);
          fill(colour);
        }
        bestPath.show();//show the path the ghost is following
      } else {//if frightened
        flashCount ++;
        if (flashCount > 800) {//after 8 seconds the ghosts are no longer frightened
          frightened = false;
          flashCount = 0;
        }

        if (floor(flashCount / 30) %2 ==0) {//make it flash white and blue every 30 frames
          stroke(255);
          fill(255);
        } else {//flash blue
          stroke(0, 0, 200);
          fill(0, 0, 200);
        }
      }
      ellipse(pos.x, pos.y, 20, 20);//draw the ghost as a circle
    }
  }

  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //moves the ghost along the path
  void move() {
    if (!deadForABit) {//dont move if dead
      pos.add(vel);
      checkDirection();//check if need to change direction next move
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  
  //calculates a path from the first node in ghost nodes to the last node in ghostNodes and sets it as best path
  void setPath() {
    ghostNodes.clear();
    setNodes();
    start  = ghostNodes.get(0);
    end = ghostNodes.get(ghostNodes.size()-1);
    Path temp = AStar(start, end, vel);
    if (temp!= null) {//if not path is found then dont change bestPath
      bestPath = temp.clone();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //sets all the nodes and connects them with adjacent nodes 
  //also sets the target node
  void setNodes() {

    ghostNodes.add(new Node((pos.x-8)/16, (pos.y-8)/16));//add the current position as a node
    for (int i = 1; i< 27; i++) {//check every position
      for (int j = 1; j< 30; j++) {
        //if there is a space up or below and a space left or right then this space is a node
        if (!tiles[j][i].wall) {
          if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
            if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space

              ghostNodes.add(new Node(i, j));//add the nodes
            }
          }
        }
      }
    }
    if (returnHome) {//if returning home then the target is just above the ghost room thing
      ghostNodes.add(new Node(13, 11));
    } else {
      if (chase) {
        if (dist((pos.x-8)/16, (pos.y-8)/16, (pacman.pos.x-8) / 16, (pacman.pos.y-8)/16) > 8) {

          ghostNodes.add(new Node((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16));
        } else {

          ghostNodes.add(new Node(1, 29));
        }
      } else {//scatter
        ghostNodes.add(new Node(1, 29));
      }
    }
    
    for (int i = 0; i< ghostNodes.size(); i++) {//connect all the nodes together
      ghostNodes.get(i).addEdges(ghostNodes);
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //check if the ghost needs to change direction as well as other stuff
  void checkDirection() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      if (frightened) {//eaten by pacman
        returnHome = true;
        frightened = false;
      } else if (!returnHome) {//killPacman
        pacman.kill();
      }
    }


    // check if reached home yet
    if (returnHome) {
      if (dist((pos.x-8)/16, (pos.y - 8)/16, 13, 11) < 1) {
        //set the ghost as dead for a bit
        returnHome = false;
        deadForABit = true;
        deadCount = 0;
      }
    }

    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position 

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position

      if (frightened) {//no path needs to generated by the ghost if frightened
        boolean isNode = false;
        for (int j = 0; j < ghostNodes.size(); j++) {
          if (matrixPosition.x ==  ghostNodes.get(j).x && matrixPosition.y == ghostNodes.get(j).y) {
            isNode = true;
          }
        }
        if (!isNode) {//if not on a node then no need to do anything
          return;
        } else {//if on a node
          //set a random direction
          PVector newVel = new PVector();
          int rand = floor(random(4));
          switch(rand) {
          case 0:
            newVel = new PVector(1, 0);
            break;
          case 1:
            newVel = new PVector(0, 1);
            break;
          case 2:
            newVel = new PVector(-1, 0);
            break;
          case 3:
            newVel = new PVector(0, -1);
            break;
          }
          //if the random velocity is into a wall or in the opposite direction then choose another one
          while (tiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
            rand = floor(random(4));
            switch(rand) {
            case 0:
              newVel = new PVector(1, 0);
              break;
            case 1:
              newVel = new PVector(0, 1);
              break;
            case 2:
              newVel = new PVector(-1, 0);
              break;
            case 3:
              newVel = new PVector(0, -1);
              break;
            }
          }
          vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
        }
      } else {//not frightened

        setPath();

        for (int i =0; i< bestPath.path.size(); i++) {//if currently on a node turn towards the direction of the next node in the path 
          if (matrixPosition.x ==  bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {
            
            vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y);
            vel.limit(1);

            return;
          }
        }
      }
    }
  }
}
//******************************************************************************************************************************************************************************************************
