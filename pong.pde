// Based on serial example by Tom Igoe 
 
import processing.serial.*; 
 
PImage img; 

Serial myPort;    // The serial port
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed 
 
float ball_pos_x;
float ball_pos_y;

int bat_width = 10;
int bat_height = 50;

float x_displacement = 3;
float y_displacement = 2;

float y_position_player_one = 0f;
float y_position_player_two = 0f;

float x_position_player_one = 0f;
float x_position_player_two = 0f;

int player_one_score = 0;
int player_two_score = 0;

float deviation = 3;
 
int[] values;
void setup() { 
  size(600,350); 
  
  //img = loadImage("ball.png");
  
  ball_pos_x = width/2;
  ball_pos_y = height/2;

  printArray(Serial.list()); 
  // I know that the first port in the serial list on my mac 
  // is always my  Keyspan adaptor, so I open Serial.list()[0]. 
  // Open whatever port is the one you're using. 
  myPort = new Serial(this, Serial.list()[1], 115200); 
  myPort.bufferUntil(lf); 
} 
 
void draw() { 

  background(0); 
 
  values = int(split(inString,":"));
  
  update_ball_position();
  
  y_position_player_one = map(values[0],0,1023,0,height);
  y_position_player_two = map(values[1],0,1023,0,height);
  
  x_position_player_one = 0f;
  x_position_player_two = width-10;
  
  fill(0, 255, 0);
  text(player_one_score, width/4, 20);
  text(player_two_score, (width/4)*3 , 20);
  
  fill(0, 255, 0);
  rect(x_position_player_one,y_position_player_one,bat_width,bat_height);
  rect(x_position_player_two,y_position_player_two,bat_width,bat_height);
  
  //image(img, ball_pos_x,ball_pos_y);
  ellipse(ball_pos_x,ball_pos_y,10,10);
} 

void update_ball_position(){
  check_boundary_collision();
  check_bat_collision();
  
  ball_pos_x +=x_displacement;
  ball_pos_y +=y_displacement;
}

void check_bat_collision(){
  //collision on left of bat one
 if(ball_pos_x>x_position_player_two&&
     ball_pos_x<x_position_player_two+(bat_width/2)&&
    ball_pos_y>y_position_player_two+1&&
   ball_pos_y<y_position_player_two+bat_height-1){
     ball_pos_x=x_position_player_two-5;
   x_displacement=-(x_displacement+random(-deviation,deviation));
   }
   //collision on right of bat two
    if(ball_pos_x<x_position_player_one+bat_width&&
    ball_pos_x>x_position_player_one+(bat_width/2)-1&&
   ball_pos_y>y_position_player_one+1&&
   ball_pos_y<y_position_player_one+bat_height-1){
     ball_pos_x=x_position_player_one+bat_width+5;
   x_displacement=-(x_displacement+random(-deviation,deviation));
   }
  
}

void check_boundary_collision(){
if (ball_pos_x>width){
      ball_pos_x=width/2;
      x_displacement=-(random(-deviation,deviation));
      y_displacement=-(random(-deviation,deviation));
      //player_one_scores
      player_one_score+=1;
    }
    
if (ball_pos_x<0){
      ball_pos_x=width/2;
      x_displacement=-(1+random(-deviation,deviation));
      y_displacement=-(random(-deviation,deviation));
      //player two scores
      player_two_score+=1;
}

if (ball_pos_y>height){
  ball_pos_y=height;
  y_displacement=-(y_displacement)+random(-deviation,deviation);

}

if (ball_pos_y<0){
ball_pos_y=0;
y_displacement=-(y_displacement)+random(-deviation,deviation);
}
}

void serialEvent(Serial p) { 
  inString = p.readString(); 
} 
