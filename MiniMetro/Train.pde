import java.util.*;

public class Train{
  
  private LinkedList<Station> trainLine;
  private int trainLineNum;
  private boolean direction;
  private int stationIndex;
  private Passenger[] riders;
  private float x;
  private float y;
  
  public void visitStation(Station st){}
  
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
  
  public void nextStation(){
    
  }
  
  private float calculateStationDist(Station st1, Station st2){
    return Math.abs(st1.getX() - st2.getY()) + Math.abs(st1.getY() - st2.getY());
  }
  
  public void addStation(Station st){
    
  }
  
  public void removeStation(Station st){
  }
  
  public Train (Station st){
    trainLine = new LinkedList<Station>();
    trainLineNum = stations.size();
    direction = true;
    stationIndex = 0;
    riders = new Passenger[6];
    x = st.getX();
    y = st.getY();
  }
  
}
