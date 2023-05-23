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
  
  public void unload(Station st){}
  
  public boolean add(){}
  
  public void nextStation(){}
  
  public void addStation(Station st){
  }
  
  public void removeStation(Station st){}
  
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
