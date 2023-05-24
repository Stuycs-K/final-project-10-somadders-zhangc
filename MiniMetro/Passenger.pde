public class Passenger{
  private int pType;
  
  public Passenger(){
    int rand = (int) (Math.random() * 3);
    pType = rand;
  }
  
  public int getType(){
    return pType;
  }
  
  public String toString(){
    if(pType == 0){
      return "circle";
    } else if (pType == 1){
      return "triangle";
    } else {
      return "square";
    }
  }
}
