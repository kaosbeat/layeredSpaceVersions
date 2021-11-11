import netP5.*;
import oscP5.*;
// import codeanticode.syphon.*;
import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus


OscP5 oscP5;
NetAddress pureData;
// SyphonServer server;


PImage[] mountainImgs;

ParticleSystem mountains;
ParticleSystem skys;
ParticleSystem planets;
ParticleSystem backgrounds;
ParticleSystem foregrounds;

import themidibus.*;
import java.io.*;


color c;
float brightness;
float globalscrollspeed;
int count = 0;
/*
MidiBus myBus;
int channel = 1;
int pitch = 64;
int velocity = 127;
*/

void setup() {
  size(800, 800, P3D);
  MidiBus.list();
  myBus = new MidiBus(this,"SLIDER/KNOB",0);
  //String userHome = System.getProperty("user.home");
  //println(userHome);
  //println();
  
  globalscrollspeed = 1.0;
  
  //for (int i = 0; i < fMountains.list().length; i++) {
  //    mountainImgs[0] = loadImage("05-Mountains/"+fMountains.list()[i]);
  //  }
  File fSky = new File(dataPath(""), "/00-Sky/");
  File fPlanets = new File(dataPath(""), "/02-Planets/");
  File fMountains = new File(dataPath(""), "/05-Mountains/");
  File fBackground = new File(dataPath(""), "/10-Background/");
  File fForeground = new File(dataPath(""), "/20-Foreground/");
  // particles
  mountains = new ParticleSystem(new PVector(width, 0), "05-Mountains/", fMountains.list(),new PVector(-4, 0));  
  skys = new ParticleSystem(new PVector(width, height/2), "00-Sky/", fSky.list(),new PVector(-2, 0));  
  //mountains = new ParticleSystem(new PVector(width, 0), mountainImgs ,new PVector(-4, 0));
  
  // server = new SyphonServer(this, "de portables");
}

void draw() {
  background(0);
  fill(255);
  noStroke(); 
  count++;
  clear();

  if ( count % 100 == 0) {
    mountains.addParticle(globalscrollspeed); ///naar eigen logic
    skys.addParticle(globalscrollspeed);
  }
  /// draw lkayers in correct oprder (bottom first)
  mountains.run(); //verplicht iedere frame
  skys.run();
  
  // server.sendScreen();
}


void controllerChange(ControlChange change) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+change.channel());
  println("Number:"+change.number());
  println("Value:"+change.value());
  globalscrollspeed = (change.value() / 64) + 0.2;
  
}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
