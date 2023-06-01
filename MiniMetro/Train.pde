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
    
    if(Math.abs(position.x-nextSt.getX()) < 1 && Math.abs(position.y-nextSt.getY()) < 1){
      // set train position to station position when train is close to the station to avoid float errors
      position = new PVector(nextSt.getX(), nextSt.getY());
      stopTime = 1;
      return true;
    }
    else {
      PVector stPosition = new PVector(nextSt.getX(), nextSt.getY());
      PVector displacement = PVector.sub(stPosition, position);
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
      System.out.println(stIndex);
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
        if(stationIndex < stIndex){
          trainLine.remove(stIndex);
        }
        // train is approaching a station but the station to be removed is behind it
        if(stationIndex >= stIndex){
          System.out.println(stationIndex);
          System.out.println(trainLine.size());
          trainLine.remove(stIndex); //<>//
          stationIndex--;
        }
      // train is moving backward
      } else if (direction == false && flag) {
        // train is approaching the first station and the station to be removed is the first station
        if(stationIndex == 1 && stIndex == 0){
          trainLine.remove(stIndex);
          stationIndex = -1;
          direction = true;
        }
        // train is approaching a station and the station to be removed is behind it
        if(stationIndex <= stIndex){
          trainLine.remove(stIndex);
        }
        // train is approaching a station but the station to be removed is ahead of it
        if(stationIndex > stIndex){
          trainLine.remove(stIndex);
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
    position = new PVector(st.getX(),st.getY());
    speed = 2;
    trains.add(this);
  }
  
  public int getDrop(){
    return totalDropped;
  }
}
