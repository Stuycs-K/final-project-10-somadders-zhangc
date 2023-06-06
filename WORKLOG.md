# Work Log

## Siddhartha Somadder

### 5/22/2023

- Completed Passenger class with no-parameter constructor and accessor methods.
- Completed UNTESTED Station class with accessors, constructor, and methods that interact with train class. Needs train class to be complete before proper testing ensues.

### 5/23/2023

- Debugged some issues in the station class.
- Added more accessors and a few mutators to the instances of station class.
- Developed MiniMetro.pde to have a proper drawStations() function that displays the current set of stations in accordance to stations array list, being wary of the type of station being displayed.
- Changed station spawning such that overlap is minimized, may need a little more work because it still happens rarely.

### 5/24/2023

- Each station now has a label for its current set of passengers.
- New get(index i) method for station class that returns a specific index of the stations riders respective to order.
- When printed, station returns set of passengers in an array.

### 5/25/2023
- Properly formatted the display of passengers per station and re-ordered the order of display methods so that display looks good.
- Created WIN screen and LOSE screen and continuing to work on how they are activated.
- Created a border in which stations cannot spawn so that map of stations does not look disorganized and places hard end to game after 2 hours.
- When game reaches a certain number of stations while the overcrowded threshold is not reached, win screen is displayed.

### 5/26/2023
- Worked on crowdedCount, total passenger, and win/lose screen processing so that it works smoothly.
- Slightly changed train unload method to keep count of TOTAL number of riders that the train has unloaded in its time.
- Game now displays the overCrowdedcount and the total passenger score.

### 5/27-29/2023
- Worked on mousePressed() for selecting stations in order for player to add/remove stations. High severity of bugs requires whiteboarding/discussion w/ Calvin.
- New 'selected' instance and respective accessor/mutators for station class that determines if station is mousePressed().
- Implemented system of savedStIndex to save last clicked on station to determine if player is adding/removing station. Some edge cases need to be addressed.

### 5/30/2023
- mousePressed() now has conditions to determine if adding/removing station is possible with the selected station(s).
- Fixed some bugs surrounding mousePressed(), significant issue with Train class remains.

### 5/31/2023
- Discussion w Calvin and investigation into issue regarding how stations are stored with addStation and removeStation.
- Added more edge cases to mousePressed and fixed some bugs in how stations are highlighted with mousePressed.

### 6/1/2023
- Tested new code both with print statements and playtested demo. Worked on separate doc for demo presentation.


## Calvin Zhang

### 5/22/2023

- Add skeleton code (instances and methods) to the main and Train classes based on our prototype.

### 5/23/2023

- Completed Train class with constructor, instances, and methods as described in our prototype.
- Add toString methods to Passenger and Train classes to help with debugging.
- Begin debugging (testing) Train addStation(), removeStation(), and nextStation() methods.
- Currently, addStation() will only add a Station to the end of the trainLine LinkedList, the complicated version has been commented out for now.

### 5/24/2023
- Implement visitStation() method for Train. Replace x and y of Train with a PVector for position. visitStation() moves the Train from one station to the next over time until it reaches the station and then unloads/loads passengers.
- Add drawLine() method to MiniMetro.pde to connect connected stations visually using the line LinkedLists in the same file.
- Update addStation() and removeStation() methods to work with red, blue, and yellow line LinkedLists.
- Update Train constructor to remove unnecessary code when testing and add Train object to ArrayList of all trains.

### 5/25/2023

- Create drawTrains() method to display the trains.
- Modify and fix visitStation() and nextStation() method for Train to visually and logically get a train from one station to the next.
- Fix loadTrain() NoSuchElementException bug.
- Remove unnecessary trainLine LinkedList in Train class and adjust methods as needed.
- Begin reworking on removeStation() which will visually and logically remove stations from a train line.

### 5/26/2023

- Redo and fix the code for adding new stations and allowing the train to move to these new stations. I mainly worked on the methods nextStation() and peekNextStation(). The new code allows the train to visually move to the next station as we would expect and allows the variables that control this to change as expected.

### 5/27/2023

- Complete removeStation() method to correctly remove stations from a train line and adjust which station the train should go to next depending on where the train is.
- Have each train stop at a station for a certain amount of time before going to the next station.
- Fix off-centered square stations.
- Reorganize the code, using helper methods, that draws train lines so that the draw() method isn't too crowded with code.
- Create graphics that indicate what train line is currently selected and allow the player to change train lines using the space bar.

### 5/29/2023

- Modified drawTrains() to display the passengers in the train.
- Have the train load passengers for the entire time when it is stopped at a station.
- Fix the issue where the first and last stations do not load/unload passengers.
- Modified visitStation() to unload passengers one at a time.

### 5/30/2023

- Create a starting screen with objects, text, and a play button to start the game.

### 5/31/2023

- Work on debugging code, specifically new problems in removeStation, addStation, and nextStation/visitStation. Problems were not resolved.

### 6/1/2023

- Fix the add and remove station bug where the train would not go to the right station.
- Allow the player to switch between train lines and add a new train line if the selected line does not already exist.

### 6/5/2023

- Add a tutorial button.
- Add a working pause button that toggles a paused boolean. Currently, only the trains stop moving but everything else still moves. This is more complicated than anticipated due to us using frame rate as a measurement of time.

### date y

info
