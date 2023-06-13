# Work Log

### Working Features
- Adding and removing stations to train routes using mouse clicks.
- Pause menu where you can edit train routes and/or take a break.
- Tutorial menu that teaches you the basics of the game.
- Ability to switch between what train route is being edited using spacebar.
- Passenger loading onto trains and unloading at stations.
- Score and Crowding trackers; Win/Lose screens based on tracker conditions.
- Passenger queue displays on both trains and on stations.
- Train travel between stations on a route using PVectors.

### Broken Features
- No known broken features.

### Useful Sources
- The actual Mini-Metro game (game design assets & graphics).
- Processing's documentation (https://processing.org/reference/).
- Java documentation for different data structures.

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

### 6/5/2023
- Added tutorial screens and bound them to How to Play button on main menu.

### 6/6/2023
- implemented mousePressed at specific location to scroll through tutorial screen.
- created outlines for 5 tutorial screens that use a specific tutorial internal clock for animation.

### 6/7/2023
- fixed bug in which tutorial would repeating after player exited tutorial, added extra button to last tutorial screen to stop from happening.

### 6/8/2023
- fixed station spawning bug where initial three trains overlap.
- modified station spawning conditions so that trainLine indicators (colored circled at bottom) do not overlap with station icons.

### 6/9/2023
- Uses internalClock counter to add waitTime to each passenger currently at a station. If passenger reaches a value of 10 for their wait time, they add 1 value to crowd counter.
- added "int waitTime" instance to passenger class and appropriate accessors/mutators.
- Check for waitTime added to the start of each draw call when screen == 0 (main game); one unit added to each wait time every 2.5 to 3 seconds.

### 6/10/2023
- Fixed station hitboxes so that they actually fit the size of the station rather than extending 25 pixels beyond it.
- Rebound scrolling through the tutorial with keypressed rather than mousepressed.
- Added internal tutorial timer for animation purposes.
- Fixed game over rectangle to be center mode and not corner mode.
- Fixed bug in which pausing at a specific frame spawned passengers every frame while in the pause menu (1/600 chance) and spawned stations every frame (1/1500 chance)
- Play tested the actual game, encountered bug in which trains pause at their station- only continuing when their original next station is removed- seems to be station specific and lasts throughout the game.
- Added tutorial screens 1, 2, 3.

### 6/11/2023
- Fixed animation bug on tutorial screen 1.
- Finished tutorial.
- Fixed small bug in the order to which new lines were drawn.

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

### 6/6/2023

- Complete the pause mechanism using a new internal clock, replacing the old clock (frameRate). Pausing should pause all spawning now.
- Modify and complete visitStation() and drawLine() to make the train curve in 45 degree angles like the original game. Also redrew the lines to reflect these changes.

### 6/7/2023

- Found bug where the train would move in an unexpected path and sometimes get stuck. Worked on debugging it, but ended up not fixing it.

### 6/8/2023

- Fixed the bug described in the previous entry. I ended up modifying the removeStation() method to change visitFlag's truth value depending on where the train was.
- Modified/shortened a section of visitStation's code because it was unnecessary.

### 6/9/2023

- Edit stroke size for train lines to make them all visible when they overlap each other.
- Create the three different types of trains (red = normal, blue = larger capacity, yellow = faster speed).

### 6/10/2023

- Fixed bug where the train would stop moving between two stations if they had the same x or y value.
- Fixed bug where blue train would not unload all its passengers.
- Add passengers to the train the moment the train spawns at a station.
- Prevent the triangle passengers from wobbling.

### 6/11/2023

- Minor code cleanup and re-fix bug where triangle passengers wobbled a lot.
