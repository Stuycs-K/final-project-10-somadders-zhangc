import java.util.*;

public class Train{
  
  private int trainLineNum;
  private boolean direction;
  private int stationIndex;
  private Passenger[] riders;
  private PVector position;
  private float speed;
  
  public boolean visitStation(){
    // implement drawing train later
    Station nextSt = peekNextStation();
    if(Math.abs(position.x-nextSt.getX()) < 1 && Math.abs(position.y-nextSt.getY()) < 1){
      // set train position to station position when train is close to the station to avoid float errors
      position = new PVector(nextSt.getX(), nextSt.getY());
      nextSt = nextStation();
      unload(nextSt);
      nextSt.loadTrain(this);
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
    if(direction == true && stationIndex != trainLine.size()-1){
      return trainLine.get(stationIndex+1);
    } else if (direction == false && stationIndex != 0){
      return trainLine.get(stationIndex-1);
    } else if (direction == true && stationIndex == trainLine.size()-1){
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
    if(direction == true && stationIndex != trainLine.size()-1){
      stationIndex++;
      return trainLine.get(stationIndex);
      
    } else if (direction == false && stationIndex != 0){
      stationIndex--;
      return trainLine.get(stationIndex);
    } else if (direction == true && stationIndex == trainLine.size()-1){
      stationIndex--;
      direction = false;
      return trainLine.get(stationIndex);
    } else if (direction == false && stationIndex == 0){
      stationIndex++;
      direction = true;
      return trainLine.get(stationIndex);
    } else {return null;}
  }
  
  private float calculateStationDist(Station st1, Station st2){
    return Math.abs(st1.getX() - st2.getY()) + Math.abs(st1.getY() - st2.getY());
  }
  
  public void addStation(Station st){
    /*
    float distToFront = calculateStationDist(st, trainLine.peekFirst());
    float distToLast = calculateStationDist(st, trainLine.peekLast());
    if(distToFront > distToLast){
      trainLine.addLast(st);
    } else {
      trainLine.addFirst(st);
    }
    */
    if(selectedRoute == 0){
      redLine.addLast(st);
    } else if (selectedRoute == 1){
      blueLine.addLast(st);
    } else if (selectedRoute == 2){
      yellowLine.addLast(st);
    }
  }
  
  // precondition: st is in trainLine
  
  // NOTE TO SELF: snap train back to previous station when station is removed
  // special cases: 2 stations, removed station is at very start or end (in which case, continue to next station)
  public void removeStation(Station st){
    LinkedList<Station> trainLine = getTrainLine(trainLineNum);
    if(trainLine.size() <= 2){
      // delete train line and train
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
        trainLine.remove(stIndex);
        flag = true;
      }
      if(direction && flag){
        if(stationIndex == 0){
          Station nextSt = nextStation();
          position = new PVector(nextSt.getX(), nextSt.getY());
          stationIndex = 0;
        }
        //stationIndex--;
      } else {
        //stationIndex++;
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
    speed = 1;
    trains.add(this);
  }
  
}
