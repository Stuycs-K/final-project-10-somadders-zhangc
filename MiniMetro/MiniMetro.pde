import java.util.*;

ArrayList<Train> trains;
ArrayList<Station> stations;
int totalPassengers;
int selectedRoute;

void setup(){
  
}

void draw(){
  if(frameCount % 600 == 0){
    for(int i = 0; i <= (stations.size()/2) + 1; i++){
      spawn();
    }
  }
  
  if(frameCount % 1800 == 0){
    spawnStation();
  }
}

void mousePressed(){}

void spawn(){
   int randSt = (int) (Math.random() * stations.size());
   stations.get(randSt).addPassengers();
}

void spawnStation(){
  stations.add(new Station());
}
