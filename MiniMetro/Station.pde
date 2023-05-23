public class Station{
  private int type;
  private float x;
  private float y;
  private int maxCapacity;
  private Deque<Passenger> riders;
  private int overcrowdedTime;
  
  public Station(){
    x = (float) Math.random();
    y = (float) Math.random();
    maxCapacity = 6;
    overcrowdedTime = 0;
    riders = new Deque<Passenger>();
    
    int rand = (int) (Math.random() * 3);
    type = rand;
  }
  
  public void addPassengers(){
    if(!overcrowded()){
      riders.addFirst(new Passenger());
    }
    else{
      overcrowdedTime++;
    }
  }
  
  public void loadTrain(Train T){
    if(riders.size() > 0){
      while(T.add(riders.peekLast())){
        riders.removeLast();
      }
    }
  }
  
  public boolean overcrowded(){
    return riders.size() >= maxCapacity;
  }
  
  public int getType{
    return type;
  }
}
