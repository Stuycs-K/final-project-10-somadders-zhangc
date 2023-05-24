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
  t.addStation(s2);
  System.out.println(t.stationIndex);
  t.nextStation();
  System.out.println(t.stationIndex);
  t.nextStation();
  System.out.println(t.stationIndex);
  t.nextStation();
  System.out.println(t.stationIndex);
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
