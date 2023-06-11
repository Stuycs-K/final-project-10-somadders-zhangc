import java.util.*; //<>// //<>// //<>//

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
int screen = -1; //0 = ongoing game, 1 = winscreen, 2 = lose screen, -1 = start screen, -2 to -6 are tutorial screens;
int overcrowdedCount;
int delayedPassengers = 0;
int numClick = 0;
int savedStIndex = -1;
float textWidthMM = 0;
boolean paused = false;
int internalClock = 0;
int tutorialClock = 0;

void setup(){
  size(1000,800);
  overcrowdedCount = 0;
  spawnStation(0);
  spawnStation(1);
  spawnStation(2);
  
  spawn();
  spawn();
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
  // DRAW START SCREEN
  if(screen == -1){
    // stations and train line display on start screen
    rectMode(CENTER);
    strokeWeight(10);
    stroke(RED);
    line(width/5,height/3,width*6/7-height/6,height/3);
    line(width*6/7-height/6,height/3,width*6/7,height/2);
    stroke(YELLOW);
    line(width*6/7,height/2,width*1/7+height/6,height/2);
    line(width*1/7+height/6,height/2,width*1/7,height*2/3);
    stroke(BLUE);
    line(width/5,height/3,width*1/7,height/3+width/5-width*1/7);
    line(width*1/7,height/3+width/5-width*1/7,width*1/7,height*2/3);
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
    String b3 = "Tutorial";
    textSize(50);
    text(b3,(width-sw)/2+40,height*3/11+140);
    triangle((width-sw)/2+20+5,height*3/11+127.5,(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+127.5-5*(float)Math.sin(PI/3),(width-sw)/2+20-5*(float)Math.cos(PI/3),height*3/11+127.5+5*(float)Math.sin(PI/3));
    stroke(0);
    fill(255);
  }
  
  if(screen == 0){
      int count = 0;
      int scoreCount = 0;
      int decline = internalClock/200;
      if(internalClock % 160 - decline == 0){
        for(int i = 0; i < stations.size(); i++){
          Station target = stations.get(i);
          for(int j = 0; j < target.riderSize(); j++){
            target.get(j).addTime();
            if(target.get(j).getWait() == 10){
              delayedPassengers++;
            }
          }
        }
      }  
  
    for(int i = 0; i < stations.size(); i++){
        count+= stations.get(i).getOvercrowded();
    }
    overcrowdedCount = count + delayedPassengers;
  
    for(int i = 0; i < trains.size(); i++){
      scoreCount+= trains.get(i).getDrop();
    }
    totalPassengers = scoreCount;
  
  if(overcrowdedCount > 50){
    screen = 2;
  }
  if(totalPassengers > 500){
    screen = 1;
  }
    background(255);
    if(!paused) { 
      internalClock += 1; 
      if(internalClock % 600- decline == 0){
        for(int i = 0; i < (stations.size()/2) + 1; i++){
            spawn();
        }
      }
      if(internalClock % 1500 == 0){
        spawnStation();
      }
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
      rectMode(CORNER);
      fill(0,60);
      rect(0,60,width,height-60);
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
    rectMode(CENTER);
    rect(width/2, height/2, 3 * width/4, height/3);
    fill(255,0,0);
    textSize(120);
    text("GAME OVER!", width/4-65, height/2);
  }
   if(screen == 1){
    fill(255);
    rectMode(CENTER);
    rect(width/2, height/2, 3 * width/4, height/3);
    fill(0,255,0);
    textSize(120);
    text("YOU WIN!", width/3-60, height/2);
  }
  if(screen == -2){
    background(220);
    textSize(40);
    fill(0);
    text("(1) Welcome to MiniMetro!", width/20, height/10);
    text("Press any key to continue", width/20, 9*height/10+10);
    
    textSize(24);
    text("This is a recreation of the real MiniMetro in processing.", width/20+20, height/10+50);
    text("To get started, lets learn how to add stations to train lines.", width/20+20, height/10+90);
    text("First, click on a station already on a train route. If you have no stations already on a route, ", width/20+20, height/10+130);
    text("use this procedure to create the route of that color.", width/20+20, height/10+155);
    text("Next, click on another station that isn't already on the selected color's route.", width/20+20, height/10+195);
    text("Once a station is connected, a train of that color will have access to it and its riders", width/20+20, height/10+445);

    
    stroke(RED);
    strokeWeight(10);
    line(0, height/2, width/3-30, height/2);
    if(tutorialClock >375){
    line(width/3-30, height/2, 2*width/3+30, height/2);
    }
    stroke(0);
    fill(255);
    strokeWeight(4);
    circle(width/3-30, height/2, 80);
    if(tutorialClock > 160){
      fill(YELLOW);
      circle(width/3-30, height/2, 80);
    }
    if(tutorialClock > 375){
      fill(255);
      circle(width/3-30, height/2, 80);
    }
    fill(255);
    rectMode(CENTER);
    square(2*width/3+30, height/2, 80);
    
    if(tutorialClock < 125){
      triangle((width/3-20) + ((100.0) - tutorialClock), ((height/2)-200+tutorialClock*1.5), (width/3-20) + ((120.0) - tutorialClock), ((height/2)-160+tutorialClock*1.5), (width/3-20) + ((140.0) - tutorialClock), ((height/2)-180+tutorialClock*1.5));
    }
    if(tutorialClock >= 125 && tutorialClock < 150){
      triangle((width/3-20)-25, (height/2)-12.5, (width/3-20)-5, (height/2)+27.5, (width/3-20)+15, (height/2)+7.5);
    }
    if(tutorialClock >= 150 && tutorialClock < 160){
      triangle((width/3-20)-15, (height/2)-7.5, (width/3-20)-3, (height/2)+16.5, (width/3-20)+9, (height/2)+4.5);
    }
    if(tutorialClock >= 160 && tutorialClock < 190){
      triangle((width/3-20)-25, (height/2)-12.5, (width/3-20)-5, (height/2)+27.5, (width/3-20)+15, (height/2)+7.5);
    }
    if(tutorialClock > 190 && tutorialClock < 340){
      triangle((2*width/3-20)-359+(tutorialClock-190)*2.65, (height/2)-12.5, (2*width/3-20)-339+(tutorialClock-190)*2.65, (height/2)+27.5, (2*width/3-20)-319+(tutorialClock-190)*2.65, (height/2)+7.5);
    }
    if(tutorialClock >= 340 && tutorialClock < 365){
      triangle((2*width/3+30)-15, (height/2)-12.5, (2*width/3+30)+5, (height/2)+27.5, (2*width/3+30)+25, (height/2)+7.5);
    }
    if(tutorialClock >= 365 && tutorialClock < 375){
      triangle((2*width/3+30)-5, (height/2)-7.5, (2*width/3+30)+7, (height/2)+16.5, (2*width/3+30)+19, (height/2)+4.5);
    }
    if(tutorialClock >= 375){
      triangle((2*width/3+30)-15+((tutorialClock - 375)*7), (height/2)-12.5+((tutorialClock - 375)*4), (2*width/3+30)+5+((tutorialClock - 375)*7), (height/2)+27.5+((tutorialClock - 375)*4), (2*width/3+30)+25+((tutorialClock - 375)*7), (height/2)+7.5+((tutorialClock - 375)*4));
    }
    
    tutorialClock++;
    if(tutorialClock >= 500){
      tutorialClock = 0;
    }
  }
  if(screen == -3){
    background(220);
    textSize(40);
    fill(0);
    text("(2) Removing Stations", width/20, height/10);
    text("Press any key to continue", width/20, 9*height/10+10);
    
    textSize(24);
    text("Removing stations from a line is just as easy!", width/20+20, height/10+50);
    text("Simply double click a station that is connected to a train route.", width/20+20, height/10+90);
    text("Stations before and after the removed station will automatically connect.", width/20+20, height/10+130);
    text("Trains on stations about to be removed will automatically shift over to the next", width/20+20, height/10+170);
    text("station in line.", width/20+20, height/10+195);
    
    stroke(RED);
    strokeWeight(10);
    line(0, height/2, width/3-30, height/2);
    if(tutorialClock < 200){
      line(width/3-30, height/2, width/2, 3*height/4);
      line(width/2, 3*height/4, 2*width/3+30, height/2);
    }
    else{
        line(2*width/3+30, height/2, width/3-30, height/2);
    }
    line(2*width/3+30, height/2, width, height/2);
    if(tutorialClock >375){
    line(width/3-30, height/2, 2*width/3+30, height/2);
    }
    stroke(0);
    fill(255);
    strokeWeight(4);
    circle(width/3-30, height/2, 80);
    circle(width/2, 3*height/4, 80);
    circle(2*width/3+30, height/2, 80);
    if(tutorialClock >= 160){
      fill(YELLOW);
      circle(width/2, 3*height/4, 80);
    }
    if(tutorialClock >= 200){
      fill(255);
      circle(width/2, 3*height/4, 80);
    }
    fill(255);
    
     if(tutorialClock < 125){
      triangle((width/2) + ((100.0) - tutorialClock), ((3*height/4)-200+tutorialClock*1.5), (width/2) + ((120.0) - tutorialClock), ((3*height/4)-160+tutorialClock*1.5), (width/2) + ((140.0) - tutorialClock), ((3*height/4)-180+tutorialClock*1.5));
    }
    if(tutorialClock >= 125 && tutorialClock < 150){
      triangle((width/2)-20, (3*height/4)-20, (width/2)+20, (3*height/4), (width/2), (3*height/4)+20);
    }
    if(tutorialClock >= 150 && tutorialClock < 160){
      triangle((width/2)-12, (3*height/4)-12, (width/2)+12, (3*height/4), (width/2), (3*height/4)+12);
    }
    if(tutorialClock >= 160 && tutorialClock < 190){
      triangle((width/2)-20, (3*height/4)-20, (width/2)+20, (3*height/4), (width/2), (3*height/4)+20);
    }
    if(tutorialClock >= 190 && tutorialClock < 200){
      triangle((width/2)-12, (3*height/4)-12, (width/2)+12, (3*height/4), (width/2), (3*height/4)+12);
    }
    if(tutorialClock >= 200 && tutorialClock < 220){
      triangle((width/2)-20, (3*height/4)-20, (width/2)+20, (3*height/4), (width/2), (3*height/4)+20);
    }
    if(tutorialClock >= 220){
      triangle((width/2)-20+((tutorialClock - 220)*7), (3*height/4)-20+((tutorialClock - 220)*4), (width/2)+20+((tutorialClock - 220)*7), (3*height/4)+((tutorialClock - 220)*4), (width/2)+((tutorialClock - 220)*7), (3*height/4)+20+((tutorialClock - 220)*4));
    }  
    
    tutorialClock++;
    if(tutorialClock >= 360){
      tutorialClock = 0;
    }
  }
  if(screen == -4){
    background(220);
    textSize(40);
    fill(0);
    text("(3) Passengers", width/20, height/10);
    text("Press any key to continue", width/20, 9*height/10+10);
    text(tutorialClock, width/2, height/2);
    tutorialClock++;
    if(tutorialClock >= 1200){
      tutorialClock = 0;
    }
  }
  if(screen == -5){
    background(220);
    fill(0);
    textSize(40);
    text("(4) Construction Mode", width/20, height/10);
    text("Press any key to continue", width/20, 9*height/10+10);
    text(tutorialClock, width/2, height/2);
    tutorialClock++;
    if(tutorialClock >= 1200){
      tutorialClock = 0;
    }
  }
  if(screen == -6){
    background(220);
    textSize(40);
    fill(0);
    text("(5) Score", width/20, height/10);
    text("Press any key to exit tutorial", width/20, 9*height/10+10);
    text(tutorialClock, width/2, height/2);
    tutorialClock++;
    if(tutorialClock >= 1200){
      tutorialClock = 0;
    }
  }
}

void mousePressed(){
  // start the game if screen is start screen and pressed in the right region
  if(screen == -1 && mouseX > (width-textWidthMM)/2 && mouseX < (width-textWidthMM)/2+textWidthMM && mouseY < height*3/11+95 && mouseY > height*3/11+40){
    screen = 0;
  }
  
  if(screen == -1 && mouseX > (width-textWidthMM)/2 && mouseX < (width-textWidthMM)/2+textWidthMM && mouseY < height*3/11+155 && mouseY > height*3/11+100){
    tutorialClock = 0;
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
    if(mouseX > target.getX() - 25 && mouseX < target.getX() + 25 && mouseY > target.getY() - 25 && mouseY < target.getY() + 25){
      if(numClick == 0){
        stations.get(i).setStatus(true);
        numClick++;
        savedStIndex = i;
      }
      else if(numClick == 1){
        if(mouseX > stations.get(savedStIndex).getX() - 25 && mouseX < stations.get(savedStIndex).getX() 
        + 50 && mouseY > stations.get(savedStIndex).getY() - 25 && mouseY < stations.get(savedStIndex).getY() + 25){
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
    if(screen <= -2 && screen >= -6){
      screen--;
      tutorialClock = 0;
      if(screen == -7){
        screen = -1;
      }
    }
    else{
      selectedRoute = (selectedRoute + 1) % 3;
    }
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
  
  if(s2.getX() >= s1.getX() && s2.getY() >= s1.getY()){
    if(s2.getX() - s1.getX() > s2.getY() - s1.getY()){
      line(s1.getX(),s1.getY(), s1.getX()+s2.getY()-s1.getY(),s2.getY());
      line(s1.getX()+s2.getY()-s1.getY(),s2.getY(), s2.getX(),s2.getY());
    } else {
      line(s1.getX(),s1.getY(), s2.getX(),s1.getY()+s2.getX()-s1.getX());
      line(s2.getX(),s1.getY()+s2.getX()-s1.getX(), s2.getX(),s2.getY());
    }
  }
  else if(s2.getX() >= s1.getX() && s2.getY() <= s1.getY()){
    if(s2.getX() - s1.getX() > s1.getY() - s2.getY()){
      line(s1.getX(),s1.getY(), s1.getX()-(s2.getY()-s1.getY()),s2.getY());
      line(s1.getX()-(s2.getY()-s1.getY()),s2.getY(), s2.getX(),s2.getY());
    } else {
      line(s1.getX(),s1.getY(), s2.getX(),s1.getY()-s2.getX()+s1.getX());
      line(s2.getX(),s1.getY()-s2.getX()+s1.getX(), s2.getX(),s2.getY());
    }
  }
  else if(s2.getX() <= s1.getX() && s2.getY() >= s1.getY()){
    if(s1.getX() - s2.getX() > s2.getY() - s1.getY()){
      line(s1.getX(),s1.getY(), s1.getX()-(s2.getY()-s1.getY()),s2.getY());
      line(s1.getX()-(s2.getY()-s1.getY()),s2.getY(), s2.getX(),s2.getY());
    } else {
      line(s1.getX(),s1.getY(), s2.getX(),s1.getY()-s2.getX()+s1.getX());
      line(s2.getX(),s1.getY()-s2.getX()+s1.getX(), s2.getX(),s2.getY());
    }
  }
  else if(s2.getX() <= s1.getX() && s2.getY() <= s1.getY()){
    if(s1.getX() - s2.getX() > s1.getY() - s2.getY()){
      line(s1.getX(),s1.getY(), s1.getX()+s2.getY()-s1.getY(),s2.getY());
      line(s1.getX()+s2.getY()-s1.getY(),s2.getY(), s2.getX(),s2.getY());
    } else {
      line(s1.getX(),s1.getY(), s2.getX(),s1.getY()+s2.getX()-s1.getX());
      line(s2.getX(),s1.getY()+s2.getX()-s1.getX(), s2.getX(),s2.getY());
    }
  }

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
