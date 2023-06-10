import java.util.*;

public class Train{
  
  private int trainLineNum;
  private boolean direction;
  private int stationIndex;
  private Passenger[] riders;
  private PVector position;
  private float speed;
  private int totalDropped = 0;
  private int stopTime = 0;
  private int stopTimeLimit = 30;
  private boolean visitFlag = false;
  
  public boolean visitStation(){
    Station nextSt = peekNextStation();
    if(stopTime != 0){
      stopTime++;
      // unload train when stopped at a station one passenger at a time
      if(stopTime % 4 == 0){
        unload(nextSt);
      }
      // set next station once time limit is up and load the train
      if(stopTime == stopTimeLimit){
        stopTime = 0;
        nextSt.loadTrain(this);
        nextStation();
        return true;
      } else {return false;}
    }
    
    if(Math.abs(position.x-nextSt.getX()) < 2 && Math.abs(position.y-nextSt.getY()) < 2){
      // set train position to station position when train is close to the station to avoid float errors
      position = new PVector(nextSt.getX(), nextSt.getY());
      visitFlag = false;
      stopTime = 1;
      return true;
    }
    else {
      float nextX = nextSt.getX();
      float nextY = nextSt.getY();
      PVector displacement = new PVector(0,0);
      if(direction && !visitFlag){
        if(Math.abs(position.x-nextX) < 2){
          visitFlag = true;
          position = new PVector(nextX, position.y); // set train x position to station x to align the train correctly
        }
        else if(Math.abs(position.y-nextY) < 2){
          visitFlag = true;
          position = new PVector(position.x, nextY); // set train y position to station y to align the train correctly
        }
        else if(nextX >= position.x && nextY >= position.y){
          displacement = new PVector(1,1);
        }
        else if(nextX >= position.x && nextY <= position.y){
          displacement = new PVector(1,-1);
        }
        else if(nextX <= position.x && nextY >= position.y){
          displacement = new PVector(-1,1);
        }
        else if(nextX <= position.x && nextY <= position.y){
          displacement = new PVector(-1,-1);
        }
      }
      else if(direction && visitFlag){
        displacement = PVector.sub(new PVector(nextX,nextY), position);
      }
      // reverse the directions following the path it came from basically
      else if(!direction && !visitFlag){
        if(Math.abs((position.y-nextY)/(position.x-nextX)) < 1.01 && Math.abs((position.y-nextY)/(position.x-nextX)) > 0.99){
          visitFlag = true;
        }
        else if(nextX > position.x && nextY > position.y){
          if(nextX-position.x > nextY-position.y){
            displacement = new PVector(1,0);
          } else {
            displacement = new PVector(0,1);
          }
        }
        else if(nextX > position.x && nextY < position.y){
          if(nextX-position.x> position.y-nextY){
            displacement = new PVector(1,0);
          } else {
            displacement = new PVector(0,-1);
          }
        }
        else if(nextX < position.x && nextY > position.y){
          if(position.x-nextX > nextY-position.y){
            displacement = new PVector(-1,0);
          } else {
            displacement = new PVector(0,1);
          }
        }
        else if(nextX < position.x && nextY < position.y){
          if(position.x-nextX > position.y-nextY){
            displacement = new PVector(-1,0);
          } else {
            displacement = new PVector(0,-1);
          }
        }
      }
      else if(!direction && visitFlag){
        displacement = PVector.sub(new PVector(nextX,nextY), position);
      }
      
      // correctly scale the displacement vector
      displacement.normalize();
      displacement.mult(speed);
      position.add(displacement);
      return false;
    }
  }
  
  public int getStationIndex(){
    return stationIndex;
  }
  
  public String toString(){
    String str = "";
    for(int i = 0; i < riders.length; i++){
      if(i < riders.length-1){
        str += riders[i] + ", ";
      } else {
        str += riders[i];
      }
    }
    
    return "[" + str + "]";
  }
  
  public void unload(Station st){
    for(int i = 0; i < riders.length; i++){
      if(riders[i] != null && riders[i].getType() == st.getType()){
        riders[i] = null;
        totalDropped++;
        i = riders.length;
      }
    }
  }
  
  public boolean add(Passenger p){
    for(int i = 0; i < riders.length; i++){
      if(riders[i] == null){
        riders[i] = p;
        return true;
      }
    }
    return false;
  }
  
  public Station peekNextStation(){
    LinkedList<Station> trainLine = getTrainLine(trainLineNum);
    if(trainLine.size() == 1){
      return trainLine.get(stationIndex);
    }
    if(direction == true && stationIndex != trainLine.size() - 1){
      return trainLine.get(stationIndex+1);
    } else if (direction == false && stationIndex != 0){
      return trainLine.get(stationIndex-1);
    } else if (direction == true && stationIndex == trainLine.size() - 1){
      return trainLine.get(stationIndex-1);
    } else if (direction == false && stationIndex == 0){
      return trainLine.get(stationIndex+1);
    } else {return null;}
  }
  
  public Station nextStation(){
    LinkedList<Station> trainLine = getTrainLine(trainLineNum);
    if(trainLine.size() == 1){
      return trainLine.get(stationIndex);
    }
    if(direction == true && stationIndex + 1 != trainLine.size() - 1){
      stationIndex++;
      return trainLine.get(stationIndex);
      
    } else if (direction == false && stationIndex - 1 != 0){
      stationIndex--;
      return trainLine.get(stationIndex);
    } else if (direction == true && stationIndex + 1 == trainLine.size() - 1){
      stationIndex++;
      direction = false;
      return trainLine.get(stationIndex);
    } else if (direction == false && stationIndex - 1 == 0){
      stationIndex--;
      direction = true;
      return trainLine.get(stationIndex);
    } else {return null;}
  }
  
  private float calculateStationDist(Station st1, Station st2){
    return Math.abs(st1.getX() - st2.getY()) + Math.abs(st1.getY() - st2.getY());
  }
  
  public void addStation(Station st){
    if(selectedRoute == 0){
      redLine.addLast(st);
    } else if (selectedRoute == 1){
      blueLine.addLast(st);
    } else if (selectedRoute == 2){
      yellowLine.addLast(st);
    }
  } //<>// //<>//
    public void addStationFIRST(Station st){
    stationIndex++;
    if(selectedRoute == 0){
      redLine.addFirst(st);
    } else if (selectedRoute == 1){
      blueLine.addFirst(st);
    } else if (selectedRoute == 2){
      yellowLine.addFirst(st);
    }
  }
   //<>//
  // NOTE:
  // special cases: 2 stations, removed station is at very start or end (in which case, continue to next station)
  public void removeStation(Station st){
    LinkedList<Station> trainLine = getTrainLine(trainLineNum);
    // delete train line and train when train line is too small
    if(trainLine.size() <= 2){
      if(trainLineNum == 0){
        redLine = new LinkedList<Station>();
      } else if (trainLineNum == 1){
        blueLine = new LinkedList<Station>();
      } else if (trainLineNum == 2){
        yellowLine = new LinkedList<Station>();
      }
      trains.remove(this);
    }
    else {
      int stIndex = trainLine.indexOf(st);
      boolean flag = false;
      if(stIndex != -1){
        flag = true;
      }
      // train is moving forward
      if(direction == true && flag){
        // train is approaching the last station and the station to be removed is the last station
        if(stationIndex == trainLine.size()-2 && stIndex == trainLine.size()-1){
          trainLine.remove(stIndex);
          stationIndex = trainLine.size();
          direction = false;
        }
        // train is approaching a station and the station to be removed is ahead of it
        else if(stationIndex < stIndex){
          trainLine.remove(stIndex);
          if(stationIndex == stIndex - 1){     
            visitFlag = true;
          }
        }
        // train is approaching a station but the station to be removed is behind it
        else if(stationIndex >= stIndex){
          trainLine.remove(stIndex); //<>//
          stationIndex--;
        }
      // train is moving backward
      } else if (direction == false && flag) {
        // train is approaching the first station and the station to be removed is the first station
        if(stationIndex == 1 && stIndex == 0){
          trainLine.remove(stIndex);
          stationIndex = -1; //<>//
          direction = true;
        }
        // train is approaching a station and the station to be removed is behind it
        else if(stationIndex <= stIndex){
          trainLine.remove(stIndex);
        }
        // train is approaching a station but the station to be removed is ahead of it
        else if(stationIndex > stIndex){
          trainLine.remove(stIndex);
          if(stationIndex == stIndex + 1){     
            visitFlag = true;
          }
          stationIndex--;
        }
      } 
    }
  }
  
  public Train (Station st){
    this.addStation(st);
    trainLineNum = selectedRoute;
    direction = true;
    stationIndex = 0;
    riders = new Passenger[6];
    if(selectedRoute == 1) riders = new Passenger[10];
    position = new PVector(st.getX(),st.getY());
    speed = 2;
    if(selectedRoute == 2) speed = 4;
    trains.add(this);
  }
  
  public int getDrop(){
    return totalDropped;
  }
}
