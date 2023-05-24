import java.util.*;

ArrayList<Train> trains = new ArrayList<Train>();
ArrayList<Station> stations = new ArrayList<Station>();
int totalPassengers = 0;
int selectedRoute = 0;

void setup(){
  size(1000,800);
  
  Station s1 = new Station();
  Station s2 = new Station();
  Station s3 = new Station();
  
  stations.add(s1);
  stations.add(s2);
  stations.add(s3);
  /*
  Train t = new Train(s1);
  Passenger p = new Passenger();
  t.add(p);
  System.out.println(t);
  System.out.println("add s2");
  t.addStation(s2);
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  
  System.out.println("add s3");
  t.addStation(s3);
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  
  System.out.println("test removeStation");
  t.removeStation(s1);
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  t.nextStation();
  System.out.println(t.getStationIndex());
  */
}

void draw(){
  background(255);
  displayStations();
  int decline = frameCount/200;
  if(frameCount % 200 - decline == 0){
    for(int i = 0; i <= (stations.size()/2) + 1; i++){
      spawn();
    }
  }
  
  if(frameCount % 1000 == 0){
    spawnStation();
  }
}

void mousePressed(){}

void spawn(){
   int randSt = (int) (Math.random() * stations.size());
   totalPassengers++;
   stations.get(randSt).addPassengers();
}

void spawnStation(){
  boolean newST = true;
  Station ST = new Station();
  while(newST){
    newST = false;
    for(int i = 0; i < stations.size(); i++){
      if(ST.getX() > stations.get(i).getX()-40 && ST.getX() < stations.get(i).getX()+40 && ST.getY() > stations.get(i).getY()-40 && ST.getY() < stations.get(i).getY()+40){
        ST = new Station();
        newST = true;
      }
    }
  } 
  ST.addPassengers();
  stations.add(ST);
}

void displayStations(){
  stroke(0);
  for(int i = 0; i < stations.size(); i++){
    Station target = stations.get(i);
    if(target.getType() == 0){
      circle(target.getX(), target.getY(), 40);
    }
    if(target.getType() == 1){
      triangle(target.getX()+20, target.getY()+20, target.getX(), target.getY()-20, target.getX()-20, target.getY()+20);
    }
    if(target.getType() == 2){
      square(target.getX()-10, target.getY()-10, 40);
    }
  }
}
