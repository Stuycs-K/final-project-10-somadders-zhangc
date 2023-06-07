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
int screen = -1; //0 = ongoing game, 1 = winscreen, 2 = lose screen, -1 = start screen, -2 = tutorial 1, -3 = tutorial 2; -4 = tutorial 3; -5 = tutorial 4, -6 = tutorial 5 more screens can be added later;
int overcrowdedCount;
int numClick = 0;
int savedStIndex = -1;
float textWidthMM = 0;
boolean paused = false;

void setup(){
  size(1000,800);
  overcrowdedCount = 0;
  stations.add(new Station(0));
  stations.add(new Station(1));
  stations.add(new Station(2));

  Station s1 = stations.get(0);
  Station s2 = stations.get(1);
  Station s3 = stations.get(2);
  
  /*
  // below is for fast testing purposes
  Train t = new Train(s1);
  t.addStation(s2);
  Passenger p = new Passenger();
  t.add(p);
  */
  
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
  int count = 0;
  int scoreCount = 0;
  for(int i = 0; i < stations.size(); i++){
    count+= stations.get(i).getOvercrowded();
  }
  overcrowdedCount = count;
  
  for(int i = 0; i < trains.size(); i++){
    scoreCount+= trains.get(i).getDrop();
  }
  totalPassengers = scoreCount;
  
  if(overcrowdedCount > 50){
    screen = 2;
  }
  if(stations.size() > 60){
    screen = 1;
  }
  
  // DRAW START SCREEN
  if(screen == -1){
    // stations and train line display on start screen
    rectMode(CENTER);
    strokeWeight(10);
    stroke(RED);
    line(width/5,height/3,width*6/7,height/2);
    stroke(YELLOW);
    line(width*6/7,height/2,width*1/7,height*2/3);
    stroke(BLUE);
    line(width/5,height/3,width*1/7,height*2/3);
    stroke(0);
    strokeWeight(4);
    circle(width/5,height/3,50);
    square(width*6/7,height/2,50);
    triangle(width*1/7+25,height*2/3+25,width*1/7,height*2/3-25,width*1/7-25,height*2/3+25);
    
    // create cover over background objects
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    
    // text on screen
    fill(0);
    stroke(0);
    textSize(120);
    String MM = "Mini Metro";
    float sw = textWidth(MM);
    textWidthMM = sw;
    text(MM,(width-sw)/2,height*3/11);
    String b1 = "Game remade by Calvin Zhang and Siddhartha Somadder";
    textSize(15);
    text(b1,(width-sw)/2+10,height*3/11+20);
    
    // button for play
    fill(100,100);
    if(mouseX > (width-sw)/2 && mouseX < (width-sw)/2+sw && mouseY < height*3/11+95 && mouseY > height*3/11+40){
      noStroke();
      rect((width-sw)/2,height*3/11+40,sw,55);
    }
    fill(0);
    String b2 = "Play";
    textSize(50);
    text(b2,(width-sw)/2+40,height*3/11+80);
    triangle((width-sw)/2+20+5,height*3/11+67.5,(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+67.5-5*(float)Math.sin(PI/3),(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+67.5+5*(float)Math.sin(PI/3));
    stroke(0);
    fill(255);
    
    // button for tutorial
    fill(100,100);
    if(mouseX > (width-sw)/2 && mouseX < (width-sw)/2+sw && mouseY < height*3/11+155 && mouseY > height*3/11+100){
      noStroke();
      rect((width-sw)/2,height*3/11+100,sw,55);
    }
    fill(0);
    String b3 = "How To Play";
    textSize(50);
    text(b3,(width-sw)/2+40,height*3/11+140);
    triangle((width-sw)/2+20+5,height*3/11+127.5,(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+127.5-5*(float)Math.sin(PI/3),(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+127.5+5*(float)Math.sin(PI/3));
    stroke(0);
    fill(255);
  }
  
  if(screen == 0){
    background(255);
    int decline = frameCount/200;
    if(frameCount % 600 - decline == 0){
      for(int i = 0; i < (stations.size()/2) + 1; i++){
          spawn();
      }
     }

    if(frameCount % 400 == 0){
      spawnStation();
    }

    drawLines();
    displayStations();
    
    drawTrains();
    fill(0);
    textSize(32);
    text("Total Score: " + totalPassengers, 3*width/4, height/24);
    text("Overcrowded Counter: " + overcrowdedCount, width/25, height/24);
    line(0, 60, width, 60);
    drawSelectedLines();
    
    // pause button
    if(paused == true){
      stroke(0);
      strokeWeight(2);
      circle(width/2,30,30);
      triangle(width/2+10,30,width/2-10*(float)Math.cos(PI/3),30+10*(float)Math.sin(PI/3),width/2-10*(float)Math.cos(PI/3),30-10*(float)Math.sin(PI/3));
      strokeWeight(4);
    }
    if(paused == false){
      stroke(0);
      strokeWeight(2);
      circle(width/2,30,30);
      line(width/2-5,22,width/2-5,38);
      line(width/2+5,22,width/2+5,38);
      strokeWeight(4);
    }
   }
  if(screen == 2){
    fill(255);
    rect(width/2, height/2, 3 * width/4, height/3);
    fill(255,0,0);
    textSize(120);
    text("GAME OVER!", width/4-65, height/2);
  }
   if(screen == 1){ //welcome + how to add
    fill(255);
    rect(width/2, height/2, 3 * width/4, height/3);
    fill(0,255,0);
    textSize(120);
    text("YOU WIN!", width/3-60, height/2);
  }
  if(screen == -2){ //how to remove + desc
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(0);
    text("(1)", width/20, height/10);
    text("Press Anywhere to Continue", width/20, 9*height/10 +30);
  }
  if(screen == -3){ //Passengers spawn at stations and have a specific type of station they want to go to.
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(0);
    text("(2)", width/20, height/10);
    text("Press Anywhere to Continue", width/20, 9*height/10 +30);
  }
  if(screen == -4){ // press space to change train lines and pause for construction mode
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(0);
    text("(3)", width/20, height/10);
    text("Press Anywhere to Continue", width/20, 9*height/10 +30);
  }
  if(screen == -5){ //be sure to watch out for your score and overcrowded counter
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(0);
    text("(4)", width/20, height/10);
    text("Press Anywhere to Continue", width/20, 9*height/10 +30);
  }
  if(screen == -6){
    fill(200,200);
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(0);
    textSize(50);
    text("(5)", width/20, height/10);
    fill(220);
    stroke(0);
    rect(3*width/4, 3*height/4, width/4, height/4);
    fill(0);
    textSize(26);
    text("Click Here to", 3*width/4+50, 3*height/4+90);
    text("return to main menu", 3*width/4+16, 3*height/4+125);   

  }
}

void mousePressed(){
  if(screen == -6  && mouseX > 3*width/4 && mouseY > 3*height/4){
    screen = -1;
  }
  if(screen == -5){
    screen = -6;
  }
  if(screen == -4){
    screen = -5;
  }
  if(screen == -3){
    screen = -4;
  }
  if(screen == -2){
    screen = -3;
  }
  // start the game if screen is start screen and pressed in the right region
  if(screen == -1 && mouseX > (width-textWidthMM)/2 && mouseX < (width-textWidthMM)/2+textWidthMM && mouseY < height*3/11+95 && mouseY > height*3/11+40){
    screen = 0;
  }
  if(screen == -1 && mouseX > (width-textWidthMM)/2 && mouseX < (width-textWidthMM)/2+textWidthMM && mouseY < height*3/11 + 150 && mouseY > height*3/11+100){
    screen = -2;
  }
  
  // pause the game
  if(screen == 0 && mouseX > width/2-15 && mouseX < width/2+15 && mouseY > 15 && mouseY < 45){
    if(paused){
      paused = false;
    } else {
      paused = true;
    }
  }
  
  //trains.get(0).removeStation(redLine.get(1));
  /*
  for(int i = 0; i < trains.size(); i++){
    trains.get(i).removeStation(redLine.get(0));
  }
  */
  for(int i = 0; i < stations.size(); i++){
    Station target = stations.get(i);
    if(mouseX > target.getX() - 50 && mouseX < target.getX() + 50 && mouseY > target.getY() - 50 && mouseY < target.getY() + 50){
      if(numClick == 0){
        stations.get(i).setStatus(true);
        numClick++;
        savedStIndex = i;
      }
      else if(numClick == 1){
        if(mouseX > stations.get(savedStIndex).getX() - 50 && mouseX < stations.get(savedStIndex).getX() 
        + 50 && mouseY > stations.get(savedStIndex).getY() - 50 && mouseY < stations.get(savedStIndex).getY() + 50){
            stations.get(savedStIndex).setStatus(false);
            numClick = 0;
            if(getTrainLine(selectedRoute).size() > 2){
              for(int j = 0; j < trains.size(); j++){
                  if(selectedRoute == trains.get(j).trainLineNum){
                     trains.get(j).removeStation(stations.get(savedStIndex));
                  }
              }
            }
        }
        else{
          boolean flag = true;
          for(int j = 0; j < trains.size(); j++){
            if(selectedRoute == trains.get(j).trainLineNum){
              flag = false;
              
              if(stations.get(savedStIndex) == getTrainLine(selectedRoute).get(0)){
                trains.get(j).addStationFIRST(target);
              }
              else if(stations.get(savedStIndex) == getTrainLine(selectedRoute).get(getTrainLine(selectedRoute).size()-1)){
                trains.get(j).addStation(target);
              }
              stations.get(savedStIndex).setStatus(false);
              numClick = 0;
            }
          }
          //add stations;
          // below adds a new train line if no train line currently exists
          if(flag){
            Train t = new Train(stations.get(savedStIndex));
            t.addStation(target);
            numClick = 0;
            stations.get(savedStIndex).setStatus(false);
          }
        }
      }
    }
  }
}

void keyPressed(){
  if(keyCode == ' '){
    selectedRoute = (selectedRoute + 1) % 3;
  }
}

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
  //trains.get(0).addStation(ST);
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
    fill(255);
    stroke(0);
    if(target.getType() == 0){
      if(target.getSelected()){
       fill(YELLOW);
       circle(target.getX(), target.getY(), 50);
      }
      else{
        circle(target.getX(), target.getY(), 50);
      }
    }
    if(target.getType() == 1){
      if(target.getSelected()){
         fill(YELLOW);
         triangle(target.getX()+25, target.getY()+25, target.getX(), target.getY()-25, target.getX()-25, target.getY()+25);
      }
      triangle(target.getX()+25, target.getY()+25, target.getX(), target.getY()-25, target.getX()-25, target.getY()+25);
    }
    if(target.getType() == 2){
      rectMode(CENTER);
       if(target.getSelected()){
         fill(YELLOW);
          square(target.getX(), target.getY(), 50);
      }
      square(target.getX(), target.getY(), 50);
    }
    int numCirc = 0;
    int numTri = 0;
    int numSq = 0;
    for(int j = 0; j < target.riderSize(); j++){
      if(target.get(j).getType() == 0){
        numCirc++;
      }
      if(target.get(j).getType() == 1){
        numTri++;
      }
      if(target.get(j).getType() == 2){
        numSq++;
      }
    }
    fill(0);
    if(target.getType() == 0){
      textSize(13);
      text("C: " + numCirc, target.getX()-9, target.getY()-5);
      text("T: " + numTri, target.getX()-9, target.getY()+5);
      text("S: " + numSq, target.getX()-9, target.getY()+15);
    }
    if(target.getType() == 1){
      textSize(10);
      text("C: " + numCirc, target.getX()-7, target.getY());
      text("T: " + numTri, target.getX()-7, target.getY()+10);
      text("S: " + numSq, target.getX()-7, target.getY()+20);
    }
    if(target.getType() == 2){
      textSize(13);
      text("C: " + numCirc, target.getX()-18, target.getY()-10);
      text("T: " + numTri, target.getX()-18, target.getY());
      text("S: " + numSq, target.getX()-18, target.getY()+10);
    }
}
}

void drawLines(){
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
}

// helper for drawLines()
void drawLine(Station s1, Station s2, color c){
  strokeWeight(10);
  stroke(c);

  line(s1.getX(), s1.getY(), s2.getX(), s2.getY());

  strokeWeight(4);
  stroke(0);
}

void drawTrains(){
  fill(255);
  rectMode(CENTER);
  for(int i = 0; i < trains.size(); i++){
    Train t = trains.get(i);
    if(paused == false){ t.visitStation(); }
    rect(t.position.x, t.position.y, 20, 20, 2, 2, 2, 2);
    Passenger[] riders = t.riders;
    int riderCount = 0;
    for(int j = 0; j < riders.length; j++){
      float adjustment = -10*(riderCount+2);
      if(riders[j] != null){
        if(riders[j].getType() == 0){
          circle(t.position.x+adjustment, t.position.y, 3);
        } else if (riders[j].getType() == 1){
          triangle(t.position.x+adjustment, t.position.y+1.5,
            t.position.x+adjustment+1.5*(float)Math.sin(PI/3), t.position.y-1.5*(float)Math.cos(PI/3),
            t.position.x+adjustment-1.5*(float)Math.sin(PI/3), t.position.y-1.5*(float)Math.cos(PI/3));
        } else if (riders[j].getType() == 2){
          square(t.position.x+adjustment, t.position.y, 3);
        }
        riderCount++;
      }
    }
  }
}

LinkedList<Station> getTrainLine(int type){
  if(type == 0){
    return redLine;
  } else if (type == 1){
    return blueLine;
  } else {
    return yellowLine;
  }
}

void drawSelectedLines(){
  fill(0);
  stroke(255);
  if(selectedRoute == 0){
    circle((float)width/4, height-60, 40);
  } else if (selectedRoute == 1){
    circle((float)width/2, height-60, 40);
  } else if (selectedRoute == 2){
    circle((float)width*3/4, height-60, 40);
  }
  noStroke();
  fill(RED);
  circle((float)width/4, height-60, 30);
  fill(BLUE);
  circle((float)width/2, height-60, 30);
  fill(YELLOW);
  circle((float)width*3/4, height-60, 30);
  fill(255);
  stroke(255);
}
