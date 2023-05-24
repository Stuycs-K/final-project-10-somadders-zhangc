import java.util.*;
import java.io.*;

public class Station{
  private int type;
  private float x;
  private float y;
  private int maxCapacity;
  private ArrayDeque<Passenger> riders;
  private int overcrowdedTime;
  
  public Station(){
    x = (float) Math.random() * width;
    y = (float) Math.random() * height;
    if(x < 50){
      x = 50;
    }
    if(x > width-100){
      x = width-100;
    }
    if(y < 50){
      y = 50;
    }
    if(y > height-50){
      y = height -50;
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
    if(x > width-100){
      x = width-100;
    }
    if(y < 50){
      y = 50;
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
}
