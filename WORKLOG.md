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

### date y

info
