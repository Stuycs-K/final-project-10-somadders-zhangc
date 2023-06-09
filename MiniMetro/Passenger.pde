public class Passenger{
  private int pType;
  private int waitTime;
  
  public Passenger(){
    int rand = (int) (Math.random() * 3);
    pType = rand;
    waitTime = 0;
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

  public int getWait(){
    return waitTime;
  }

  public void addTime(){
    waitTime++;
  }
}
