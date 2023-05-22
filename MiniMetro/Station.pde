public class Station{
  private int type;
  private float x;
  private float y;
  private int maxCapacity;
  private Deque<Passenger> riders;
  private int overcrowdedTime;
  
  public Station(){
    x = Math.random();
    y = Math.random();
    maxCapacity = 6;
    overcrowdedTime = 0;
    riders = new Deque<Passenger>();
  }
  
  public void addPassengers(){}
  
  public void loadTrain(Train T){}
  
  public boolean overcrowded(){}
  
  public int getType{}
}
