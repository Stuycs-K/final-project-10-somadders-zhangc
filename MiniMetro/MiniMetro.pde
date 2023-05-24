import java.util.*;

ArrayList<Train> trains = new ArrayList<Train>();
ArrayList<Station> stations = new ArrayList<Station>();
int totalPassengers = 0;
int selectedRoute = 0;

void setup(){
  size(1000,800);
  
  stations.add(new Station(0));
  stations.add(new Station(1));
  stations.add(new Station(2));
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
  
  if(frameCount % 1500 == 0){
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
      if(ST.getX() > stations.get(i).getX()-50 && ST.getX() < stations.get(i).getX()+50 && ST.getY() > stations.get(i).getY()-50 && ST.getY() < stations.get(i).getY()+50){
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
      circle(target.getX(), target.getY(), 50);
    }
    if(target.getType() == 1){
      triangle(target.getX()+25, target.getY()+25, target.getX(), target.getY()-25, target.getX()-25, target.getY()+25);
    }
    if(target.getType() == 2){
      square(target.getX()-10, target.getY()-10, 50);
    }
    /*
    textSize(6);
    int numCirc = 0;
    int numTri = 0;
    int numSq = 0;
    for(int j = 0; j < target.riderSize(); i++){
      if(target.get(i).getType() == 0){
        numCirc++;
      }
      if(target.get(i).getType() == 1){
        numTri++;
      }
      if(target.get(i).getType() == 2){
        numSq++;
      }
    }
    
    text("C: " + numCirc, target.getX(), target.getY()-5);
    text("T: " + numTri, target.getX(), target.getY());
    text("S: " + numSq, target.getX(), target.getY()+5);
 */
  }
}
