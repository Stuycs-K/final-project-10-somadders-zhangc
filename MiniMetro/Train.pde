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
    if(direction){
      if(stationIndex >= trainLine.size()-1){
        return trainLine.get(stationIndex - 1);
      }
      return trainLine.get(stationIndex + 1);
      
    } else {
      if(stationIndex - 1 < 0){
        return trainLine.get(stationIndex + 1);
      }
      return trainLine.get(stationIndex - 1);
    }
  }
  
  public Station nextStation(){
    LinkedList<Station> trainLine = getTrainLine(trainLineNum);
    if(trainLine.size() == 1){
      return trainLine.get(stationIndex);
    }
    if(direction){
      stationIndex++;
      if(stationIndex + 1 >= trainLine.size()){
        direction = false;
        return trainLine.get(stationIndex);
      }
      return trainLine.get(stationIndex);
      
    } else {
      stationIndex--;
      if(stationIndex - 1 < 0){
        direction = true;
        return trainLine.get(stationIndex);
      }
      return trainLine.get(stationIndex);
    }
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
    /*
    if(trainLine.size() <= 2){
      // delete train line and train
      trainLine = null;
      trains.remove(this);
      
    }
    else {
      int stIndex = trainLine.indexOf(st);
      int stIndexInMain = redLine.indexOf(st);
      int route = 0;
      if (stIndexInMain == -1){
        stIndexInMain = blueLine.indexOf(st);
        route = 1;
      }
      if (stIndexInMain == -1){
        stIndexInMain = yellowLine.indexOf(st);
        route = 2;
      }
      System.out.println(route);
      
      if(stIndexInMain != -1){
        if(route == 0){
          redLine.remove(stIndexInMain);
        } else if (route == 1){
          blueLine.remove(stIndexInMain);
        } else if (route == 2){
          yellowLine.remove(stIndexInMain);
        }
      }
      
      trainLine.remove(stIndex);
      if (stIndex == stationIndex){
        if(direction){
          stationIndex--;
        } else {
          stationIndex++;
        }
      }
    }
    */
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
