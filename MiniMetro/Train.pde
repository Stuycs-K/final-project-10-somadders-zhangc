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
  
  private void moveUpElements(Passenger[] arr){
    Passenger[] temp = new Passenger[riders.length];
    int k = 0;
    for(int i = 0; i < riders.length; i++){
      if(riders[i] != null){
        temp[k] = riders[i];
        k++;
      }
    }
    riders = temp;
  }
  
  public void unload(Station st){
    for(int i = 0; i < riders.length; i++){
      if(riders[i].getType() == st.getType()){
        riders[i] = null;
      }
    }
  }
  
  public boolean add(Passenger p){
    return false;
  }
  
  public void nextStation(){
    
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
