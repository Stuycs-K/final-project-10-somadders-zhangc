import java.util.*;

public class Train{
  
  private LinkedList<Station> trainLine;
  private int trainLineNum;
  private boolean direction;
  private int stationIndex;
  private Passenger[] riders;
  private PVector position;
  private float speed;
  
  public void visitStation(){
    // implement drawing train later
    Station nextSt = peekNextStation();
    if(Math.abs(position.x-nextSt.getX()) < 0.01 && Math.abs(position.y-nextSt.getY()) < 0.01){
      nextSt = nextStation();
      unload(nextSt);
      nextSt.loadTrain(this);
    }
    else {
      PVector displacement = new PVector(nextSt.getX() - position.x,nextSt.getY() - position.y);
      displacement.normalize();
      displacement.mult(speed);
      position.add(displacement);
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
      if(riders[i].getType() == st.getType()){
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
    if(trainLine.size() == 1){
      return trainLine.get(stationIndex);
    }
    if(direction){
      if(stationIndex + 1 >= trainLine.size()){
        return peekNextStation();
      }
      return trainLine.get(stationIndex);
      
    } else {
      if(stationIndex - 1 < 0){
        return nextStation();
      }
      return trainLine.get(stationIndex);
    }
  }
  
  public Station nextStation(){
    if(trainLine.size() == 1){
      return trainLine.get(stationIndex);
    }
    if(direction){
      if(stationIndex + 1 >= trainLine.size()){
        direction = false;
        return nextStation();
      }
      stationIndex++;
      return trainLine.get(stationIndex);
      
    } else {
      if(stationIndex - 1 < 0){
        direction = true;
        return nextStation();
      }
      stationIndex--;
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
    trainLine.addFirst(st);
  }
  
  // precondition: st is in trainLine
  public void removeStation(Station st){
    int stIndex = trainLine.indexOf(st);
    trainLine.remove(stIndex);
    if (stIndex == stationIndex){
      if(direction){
        stationIndex--;
      } else {
        stationIndex++;
      }
    }
  }
  
  public Train (Station st){
    trainLine = new LinkedList<Station>();
    trainLine.addFirst(st);
    trainLineNum = stations.size();
    direction = true;
    stationIndex = 0;
    riders = new Passenger[6];
    position = new PVector(st.getX(),st.getY());
    speed = 0.1;
  }
  
}
