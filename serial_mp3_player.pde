//Based on Example by Tom Igoe 
//Kingston hackSpace 2023
//made available throught the creative commons license

import processing.serial.*; 
import ddf.minim.*;

Serial myPort;    // The serial port
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed 
 
boolean isPlaying = false;
 
Minim minim;
AudioPlayer player;

void setup() { 
  size(400,250); 

  printArray(Serial.list()); 
  // I know that the first port in the serial list on my mac 
  // is always my  Keyspan adaptor, so I open Serial.list()[0]. 
  // Open whatever port is the one you're using. 
  myPort = new Serial(this, Serial.list()[1], 115200); 
  myPort.bufferUntil(lf); 
  //make sure the data folder has file with the following name...
  player = minim.loadFile("groove.mp3");
} 
 
void draw() { 

  background(0); 
 
  int values = int(inString);
  
  if(values==1){
    isPlaying=true;
    play_pressed();
  }
  else if(values==0){
    isPlaying = false;
  }
  
} 

void play_pressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else
  {
    player.play();
  }
}

void serialEvent(Serial p) { 
  inString = p.readString(); 
} 
