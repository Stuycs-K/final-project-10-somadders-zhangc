import java.util.*;

ArrayList<Train> trains = new ArrayList<Train>();
ArrayList<Station> stations = new ArrayList<Station>();
int totalPassengers;
int selectedRoute;

void setup(){
  Station s1 = new Station();
  Station s2 = new Station();
  Station s3 = new Station();
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
}

void draw(){
  /*
  if(frameCount % 600 == 0){
    for(int i = 0; i <= (stations.size()/2) + 1; i++){
      spawn();
    }
  }
  
  if(frameCount % 1800 == 0){
    spawnStation();
  }
  */
}

void mousePressed(){}

void spawn(){
   int randSt = (int) (Math.random() * stations.size());
   stations.get(randSt).addPassengers();
}

void spawnStation(){
  stations.add(new Station());
}
