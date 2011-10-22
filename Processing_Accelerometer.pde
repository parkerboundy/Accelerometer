// import and set up serial connection to the Arduino
import processing.serial.*;
Serial port;

// variables for the coordinates
int coordinateX = 0;
int coordinateY = 0;

// index of the comma between values (when reading from Arduino)
int index = 0;

void setup(){
  // create window
  size (500, 500);
  
  // begin serial connection  
  // you will need to change the second argument for your setup
  port = new Serial(this, "/dev/tty.usbmodem1d11", 9600);
  port.bufferUntil('\n');
}

void draw(){
  // draw the background 
  background(0);
  
  // draw the grid
  stroke(255);
  line(250,0,250,500);
  line(0,250,500,250);
  
  // draw the ellipse 
  noStroke();
  fill(255,0,0);
  ellipse(coordinateY, coordinateX, 50, 50); 
  
  // draw the text
  fill(255);
  text("X: ", 10, 480);
  text(coordinateX, 25, 480);
  text("Y: ", 10, 500);
  text(coordinateY, 25, 500);
}

// called whenever we receive data from the arduino
void serialEvent(Serial port){
  
  // read the input
  String buffer = port.readStringUntil('\n');
  
  // if input is not null
  if(buffer != null){
     // find the index of the comma
    index = buffer.indexOf(",");
    // check that the index is greater than zero
    if(index > 0){
      
      // get the coordinates from the original string
      String stringX = buffer.substring(0, index);
      String stringY = buffer.substring(index+1, buffer.length());
    
      // trim coordinate strings so we don't get errors
      String trimX = trim(stringX);
      String trimY = trim(stringY);
    
      // set the ellipse's coordinates to the trimmed strings
      coordinateX = int(trimX);
      coordinateY = int(trimY);
    }
  }
}
