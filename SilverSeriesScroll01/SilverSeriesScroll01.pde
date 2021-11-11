import netP5.*;
import oscP5.*;
import codeanticode.syphon.*;
import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus


OscP5 oscP5;
NetAddress pureData;
SyphonServer server;

ParticleSystem mountains;
ParticleSystem skys;


import themidibus.*;
import java.io.*;

/* NEXT STEPS
> Make function or object of loading
> Load more than one image
> Discard image when out of view
*/

float tilesX = 400;
float tilesY = 5;
float tileSizeX;
float tileSizeY;

color c;
float brightness;

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
  myBus = new MidiBus(this, -1, "Bus 1");
  String userHome = System.getProperty("user.home");
  println(userHome);
  println();
  File fMountains = new File(dataPath(""), "/05-Mountains/");
  File fSky = new File(dataPath(""), "/00-Sky/");
  // particles
  mountains = new ParticleSystem(new PVector(width, 0), "05-Mountains/", fMountains.list(),new PVector(-4, 0));  
  skys = new ParticleSystem(new PVector(width, height/2), "00-Sky/", fSky.list(),new PVector(-2, 0));  

  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);
  fill(255);
  noStroke(); 
  count++;
  clear();

  if ( count % 100 == 0) {
    mountains.addParticle(); ///naar eigen logic
    skys.addParticle();
  }
  /// draw lkayers in correct oprder (bottom first)
  mountains.run(); //verplicht iedere frame
  skys.run();
  
  server.sendScreen();
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
