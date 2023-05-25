import java.util.*;

ArrayList<Train> trains = new ArrayList<Train>();
ArrayList<Station> stations = new ArrayList<Station>();
int totalPassengers = 0;
int selectedRoute = 0;
LinkedList<Station> redLine = new LinkedList<Station>();
LinkedList<Station> blueLine = new LinkedList<Station>();
LinkedList<Station> yellowLine = new LinkedList<Station>();
color RED = color(178,34,34);
color BLUE = color(0,0,205);
color YELLOW = color(255,215,0);

void setup(){
  size(1000,800);

  stations.add(new Station(0));
  stations.add(new Station(1));
  stations.add(new Station(2));

  Station s1 = stations.get(0);
  Station s2 = stations.get(1);
  Station s3 = stations.get(2);
  Train t = new Train(s1);
  Passenger p = new Passenger();
  t.add(p);
  t.addStation(s2);
  
  /* //TESTING VISIT STATION
  System.out.println(t.position);
  System.out.println(s1.x + " " + s1.y);
  System.out.println(s2.x + " " + s2.y);
  while(!t.visitStation()){}
  System.out.println(t.position);
  */

  /*//TESTING ADD AND REMOVE STATION
  System.out.println(t);
  System.out.println("add s2");
  //t.addStation(s2);
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
  
  // go through all three lines and draw connected stations
  for(int i = 0; i < redLine.size()-1; i++){
    drawLine(redLine.get(i),redLine.get(i+1),RED);
  }
  for(int i = 0; i < blueLine.size()-1; i++){
    drawLine(blueLine.get(i),blueLine.get(i+1),BLUE);
  }
  for(int i = 0; i < yellowLine.size()-1; i++){
    drawLine(yellowLine.get(i),yellowLine.get(i+1),YELLOW);
  }
  
  drawTrains();
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
  trains.get(0).addStation(ST);
}

void spawnStation(int type){
  boolean newST = true;
  Station ST = new Station(type);
  while(newST){
    newST = false;
    for(int i = 0; i < stations.size(); i++){
      if(ST.getX() > stations.get(i).getX()-50 && ST.getX() < stations.get(i).getX()+50 && ST.getY() > stations.get(i).getY()-50 && ST.getY() < stations.get(i).getY()+50){
        ST = new Station(type);
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

void drawLine(Station s1, Station s2, color c){
  strokeWeight(10);
  stroke(c);
  
  line(s1.getX(), s1.getY(), s2.getX(), s2.getY());
  
  strokeWeight(4);
  stroke(0);
}

void drawTrains(){
  rectMode(CENTER);
  for(int i = 0; i < trains.size(); i++){
    Train t = trains.get(i);
    t.visitStation();
    rect(t.position.x, t.position.y, 20, 20, 2, 2, 2, 2);
  }
}
