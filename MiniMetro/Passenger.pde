public class Passenger{
  private int pType;
  
  public Passenger(){
    int rand = (int) (Math.random() * 3);
    pType = rand;
  }
  
  public int getType(){
    return pType;
  }
}
