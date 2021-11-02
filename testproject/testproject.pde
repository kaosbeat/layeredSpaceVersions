import netP5.*;
import oscP5.*;

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

OscP5 oscP5;
NetAddress pureData;

ParticleSystem ps;



//state =


void setup() {
  size(900, 900, P3D);
  ps = new ParticleSystem(new PVector(width/2, 50));  
  background(0);
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 1, -1); 

  /* start oscP5, listening for incoming messages at port 12000, sending to 12001*/
  oscP5 = new OscP5(this, 12000);
  pureData = new NetAddress("127.0.0.1", 12001);

}


void draw() {
  clear();
  ps.run();
  ps.addParticle();

}




void noteOn(Note note) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+note.channel());
  println("Pitch:"+note.pitch());
  println("Velocity:"+note.velocity());
}

void noteOff(Note note) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+note.channel());
  println("Pitch:"+note.pitch());
  println("Velocity:"+note.velocity());
}

void controllerChange(ControlChange change) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+change.channel());
  println("Number:"+change.number());
  println("Value:"+change.value());
}

void oscEvent(OscMessage theOscMessage) {
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
  //println("time" + millis()/1000 + "___" + theOscMessage.get(0).floatValue());

  if (theOscMessage.checkAddrPattern("/stage")==true) {
    int stage = int(theOscMessage.get(0).floatValue());
    int state = int(theOscMessage.get(1).floatValue());
    println(stage,state);
  }
}
