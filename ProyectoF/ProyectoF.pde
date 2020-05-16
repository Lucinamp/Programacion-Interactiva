import oscP5.*;
import netP5.*;

NetAddress direccionRemota;


OscP5 oscP5;
int x = 0;
int y = 0;
int p = 0;
int c=0;
int c2=0;
int p2 = 0;
float myRandom;
int total = 4;

boolean same = false;
boolean keep = false;
int dis = 2;
void setup(){
  size(700,700);
  strokeWeight(4);
  
 
  oscP5 = new OscP5(this, 12001);
  
  direccionRemota = new NetAddress("192.168.0.15", 12001);

}
void draw(){
  stroke(190,(c*2)+80,(c2*2)+80);

  if(p == 1) same = !same;
  if(p2 == 1) keep = !keep;
  if(!keep)
    background(50);
  translate(width/2, height/2);
  for(int i = 0; i < 3000; i++){
      
  point(x, y);
  float prevR = myRandom;
  myRandom = floor(random(0, total));
  if(!same)
    while(prevR%4 == myRandom%4) myRandom = floor(random(0, total));
  x = floor(x+width/2*cos(myRandom*TWO_PI/total))/dis;
  y = floor(y+height/2*sin(myRandom*TWO_PI/total))/dis;
  }
}


void oscEvent(OscMessage theOscMessage) {  
  //si el mensaje está etiquetado como "/x"
  if (theOscMessage.checkAddrPattern("/x") == true) {
    //asigna el valor entero a la variable x
    total = theOscMessage.get(0).intValue();
  }

  //si el mensaje está etiquetado como "/y"
  if (theOscMessage.checkAddrPattern("/y") == true) {
    //asigna el valor entero a la variable y
    dis = theOscMessage.get(0).intValue();
  }
  //si el mensaje está etiquetado como "/p"
  if (theOscMessage.checkAddrPattern("/p") == true) {
    //asigna el valor entero a la variable p
    p = theOscMessage.get(0).intValue();
  }
  //si el mensaje está etiquetado como "/p2"
  if (theOscMessage.checkAddrPattern("/p2") == true) {
    //asigna el valor entero a la variable p2
    p2 = theOscMessage.get(0).intValue();
  }
  //color1
  if (theOscMessage.checkAddrPattern("/c") == true) {
  
    c = theOscMessage.get(0).intValue();
  }
  //color2
  if (theOscMessage.checkAddrPattern("/c2") == true) {

    c2 = theOscMessage.get(0).intValue();
  }
  
 
}
