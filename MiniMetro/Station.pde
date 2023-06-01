import java.util.*;
import java.io.*;

public class Station{
  private int type;
  private float x;
  private float y;
  private int maxCapacity;
  private ArrayDeque<Passenger> riders;
  private int overcrowdedTime;
  private boolean selected = false;
  
  public Station(){
    x = (float) Math.random() * width;
    y = (float) Math.random() * height;
    if(x < 50){
      x = 50;
    }
    if(x > width-50){
      x = width-50;
    }
    if(y < 125){
      y = 125;
    }
    if(y > height-50){
      y = height-50;
    }
    maxCapacity = 6;
    overcrowdedTime = 0;
    riders = new ArrayDeque<Passenger>();
    
    int rand = (int) (Math.random() * 3);
    type = rand;
  }
  
  public Station(int Type){
    x = (float) Math.random() * width;
    y = (float) Math.random() * height;
    if(x < 50){
      x = 50;
    }
    if(x > width-125){
      x = width-125;
    }
    if(y < 100){
      y = 100;
    }
    if(y > height-50){
      y = height -50;
    }
    maxCapacity = 6;
    overcrowdedTime = 0;
    riders = new ArrayDeque<Passenger>();
    type = Type;
  }
  
  public void addPassengers(){
    if(!overcrowded()){
      riders.addFirst(new Passenger());
      overcrowdedTime--;
      if(overcrowdedTime < 0){
        overcrowdedTime = 0;
      }
    }
    else{
      overcrowdedTime++;
    }
  }
  
  public void loadTrain(Train T){
    while(riders.size() > 0 && T.add(riders.peekLast())){
      riders.removeLast();
    }
  }
  
  public boolean overcrowded(){
    return riders.size() >= maxCapacity;
  }
  
  public int getType(){
    return type;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public void setX(float X){
    x = X;
  }
  
  public void setY(float Y){
    y = Y;
  }
  
  public String toString(){
    return riders.toString();
  }
  
  public int riderSize(){
    return riders.size();
  }
  
  public Passenger get(int index){
    ArrayDeque<Passenger> cloned = riders.clone();
    for(int i = 0; i < index; i++){
      cloned.removeFirst();
    }
    return cloned.removeFirst();
  }
  
  public int getOvercrowded(){
    return overcrowdedTime;
  }
  
  public boolean getSelected(){
    return selected;
  }
  
  public void setStatus(boolean b){
    selected = b;
  }
  
}
